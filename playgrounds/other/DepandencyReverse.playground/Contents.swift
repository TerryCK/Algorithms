import Foundation

class APIClient {
    static let shared = APIClient()
    var session = URLSession.shared
    
    func execute<T: Decodable>(_ url: URL, completion: @escaping (T) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let payload = try JSONDecoder().decode(T.self, from: data)
                    completion(payload)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}


struct User: Decodable {
    let name: String
}

class LoginViewModel {
    typealias Service<T: Decodable> = ((@escaping (T) -> Void) -> Void)
    
    let login: Service<User>
    
    init(_ login: @escaping Service<User>) {
        self.login = login
    }
    
    func userDidTapLoginButton() {
        login { user in
            print(user)
        }
    }
}

let loginVM = LoginViewModel { userHandler in
    DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) {
        userHandler(User(name: "123"))
    }
}



class Service {
    static func login(_ completion: @escaping (User) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) {
            completion(User(name: "123"))
        }
    }
}

class LoginViewModelDependency {
    // source code dependence on Service class
    let login = Service.login

    func userDidTapLoginButton() {
        login { user in
            print(user)
        }
    }
}




loginVM.userDidTapLoginButton()
