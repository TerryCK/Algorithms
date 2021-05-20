import Foundation
// option pattern
//
//protocol OptionPattern {
//    associatedtype Value
//
//    static var defaultValue: Value { get }
//}
//
//
//
//class TrafficLight {
//    private var options = [ObjectIdentifier: Any]()
//
//    subscript<T: OptionPattern>(option type: T.Type) -> T.Value {
//        get {
//            options[ObjectIdentifier(type)] as? T.Value  ?? T.defaultValue
//        }
//        set {
//            options[ObjectIdentifier(type)] = newValue
//        }
//    }
//}
//
//
//
//
//extension Date {
//    init(x: Int = 0) {
//        self = Date()
//    }
//}
//
//Date(x: 10)
//let components = DateComponents()
//components.year
//
//
//
//protocol Person {
//
//    var name: String { get }
//}
//
//
//struct Doctor: Person {
//    let name: String
//
//    func surgery() {
//
//    }
//}
//
//struct Lawyer: Person {
//    let name: String
//    func debate() {
//    }
//}
//
//class Visitor {
//    func doSpecificThings(with person: Person) {
//        print("my name is \(person.name)")
//        switch person {
//        case let doctor as Doctor: doctor.surgery()
//        case let lawyer as Lawyer: lawyer.debate()
//        default: break
//        }
//    }
//}
//


func decode<T: Decodable, B: Decodable>(_ data: Data, to type: T.Type, or typeB: B.Type) -> Decodable? {
    var result: Decodable? = nil
    do {
        result = try JSONDecoder().decode(T.self, from: data)
    } catch {
        do {
            result = try JSONDecoder().decode(B.self, from: data)
        } catch {
        }
    }
    return result
}

// Demo
let data = "\"1\"".data(using: .utf8)!

let x = decode(data, to: Int.self, or: String.self)

switch x {
case let result as Int: print(result, "as Int")
case let result as String: print(result, "as String")
default: break
}












































func decode2<T: Decodable, B: Decodable>(_ data: Data, to type: T.Type, or typeB: B.Type) throws -> Decodable {
    let result: Result<Decodable, Error>
    do {
        let decode = try JSONDecoder().decode(T.self, from: data)
        result = Result.success(decode)
    } catch {
        do {
            let decode = try JSONDecoder().decode(B.self, from: data)
            result = Result.success(decode)
        } catch {
            result = .failure(error)
        }
    }
    
    switch result {
    case .success(let decode): return decode
    case .failure(let error): throw error
    }
}
struct DataModel : Decodable {
    let name: String
}

do {
    let x = try decode2(data, to: DataModel.self, or: Int.self)
    
    switch x {
    case let result as Int: print(result, "as String")
    case let result as String: print(result, "as String")
    default: break
    }
} catch {
    print(error)
}











































extension Data {
    func decodeMaybe<T: Decodable, B: Decodable>(aType: T.Type, bType: B.Type) throws -> Decodable {
        func decodeInternal<D: Decodable>(_ data: Data, to type: D.Type) throws -> Decodable {
            try JSONDecoder().decode(T.self, from: data)
        }
        do {
            return try decodeInternal(self, to: T.self)
        } catch {
            return try decodeInternal(self, to: B.self)
        }
    }
}

do {
    let x = try data.decodeMaybe(aType: String.self, bType: Int.self)
    switch x {
    case let result as Int: print(result, "as Int")
    case let result as String: print(result, "as String")
    default: break
    }
} catch {
    print(error)
}
