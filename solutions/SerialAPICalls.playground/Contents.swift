import Combine
import Foundation

class API {
    
    struct Login: Codable {
        let token: String
    }
    enum ErrorCode: Error {
        case error
    }
    
    struct Member: Codable {
        let name: String
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    
    func publisher<T: Codable>(urlString: String,
                               decoder: JSONDecoder = JSONDecoder(),
                               target: T.Type) -> AnyPublisher<T, Error> {
        URLSession.shared
            .dataTaskPublisher(for: URL(string: urlString)!)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    
    func fetch() {
        publisher(urlString: "domain/api/login", target: Login.self)
            .flatMap { login in
                self.publisher(urlString: "domain/api/\(login.token)", target: Member.self)
            }.sink { completion in
                switch completion {
                case let .failure(error): print(error)
                case .finished: break
                }
            } receiveValue: { member in
                print(member)
            }.store(in: &subscriptions)
    }
}
