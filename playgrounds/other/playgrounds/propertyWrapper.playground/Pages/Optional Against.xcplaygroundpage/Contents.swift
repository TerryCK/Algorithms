import Foundation
//
//let bool: Bool? = true
//
//
//switch bool {
//case .none: print("none")
//case true: print("true")
//case false: print("false")
////default: print("test")
//}
//
//
//
//
//
//enum Weather {
//    case sun, rain, cloudy
//}
//
//let weather: Weather? = nil
//
//switch weather {
//case .cloudy: print("cloudy")
//case .sun: print("sun")
//case .none: print("none")
//case .rain: print("rain")
////default: print("no found")
//}


@dynamicMemberLookup
class A {
    subscript(dynamicMember keyPath: String) -> String {
        return "a"
    }
    
    var name: String = "A name"
}


A().name

A().x
