import Foundation

@propertyWrapper
struct User<T> {
    var wrappedValue: T
}

class Person {
    @User(wrappedValue: "t")
    var x: String
    
    func dox() {
        print(_x)
    }
}

Person().dox()
@dynamicMemberLookup
struct Car {
    subscript(dynamicMember key: String) -> String {
        let propertys = ["city": "taipei", "weather": "rain"]
        return propertys[key, default: "not found"]
    }
}

let car = Car()
car[dynamicMember: "weather"]
car.city
car.x
