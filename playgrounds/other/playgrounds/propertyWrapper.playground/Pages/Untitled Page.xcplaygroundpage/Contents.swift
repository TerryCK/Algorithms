
import Foundation








import UIKit
// MARK: Legancy
extension UICollectionViewFlowLayout {
    
    func with(minimumLineSpacing: CGFloat) -> Self {
        self.minimumLineSpacing = minimumLineSpacing
        return self
    }
    
    func with(minimumInteritemSpacing: CGFloat) -> Self {
        self.minimumInteritemSpacing = minimumInteritemSpacing
        return self
    }
    
    func with(sectionInset: UIEdgeInsets) -> Self {
        self.sectionInset = sectionInset
        return self
    }
    
    func with(estimatedItemSize: CGSize) -> Self {
        self.estimatedItemSize = estimatedItemSize
        return self
    }
    
    func with(itemSize: CGSize) -> Self {
        self.itemSize = itemSize
        return self
    }
}



let flowLayoutLegancy: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                                                    .with(minimumInteritemSpacing: 50)
                                                    .with(minimumLineSpacing: 50)
                                                    .with(minimumInteritemSpacing: 50)
                                                    .with(sectionInset: .init(top: 10, left: 10, bottom: 10, right: 10))
                                                    .with(estimatedItemSize: .init(width: 0, height: 0))
                                                    .with(itemSize: .init(width: 10, height: 10))



enum Weather: Int {
    case A, B
    static subscript(int: Int) -> Self {
        return Self(rawValue: int)!
    }
}
Weather[1]

@dynamicMemberLookup
struct Builder<T> {
    let subject: T
    subscript<Value>(dynamicMember keyPath: WritableKeyPath<T, Value>) -> ((Value) -> Self) {
        var subjectCopy = subject
        return { value in
            subjectCopy[keyPath: keyPath] = value
            return Self(subject: subjectCopy)
        }
    }
}


// MARK: Latest
let flowLayout: UICollectionViewFlowLayout = Builder<UICollectionViewFlowLayout>(subject: UICollectionViewFlowLayout())
                                            .minimumLineSpacing(50)
                                            .minimumInteritemSpacing(50)
                                            .sectionInset(.init(top: 10, left: 10, bottom: 10, right: 10))
                                            .estimatedItemSize(.init(width: 0, height: 0))
                                            .itemSize(.init(width: -1, height: 10))
                                            .subject





//@dynamicMemberLookup
//enum Weather: String {
//    case sun, rain
//    subscript(dynamicMember keyPath: String) -> Self {
//        Self(rawValue: keyPath) ?? .sun
//    }
//}
//
//print(Weather.sun.rain.sun)
////
//@dynamicMemberLookup
//struct Person: Codable {
//    var cache = [String: Any]()
//    subscript<T>(dynamicMember keyPath: String) -> T? {
//        set {
//            cache[keyPath] = newValue
//        }
//        get {
//            return cache[keyPath] as? T
//        }
//
//    }
//}

//var person = Person()
//let x: String? = person.name
//
//person.name = "terry"
//
//let y: String? = person.name


let json = """
{
    "name": "Terry"
}
""".data(using: .utf8)!

print(String(data: json, encoding: .utf8))



struct Person: Encodable, Decodable {
    let name: String
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        dump(encoder)
    }
}


let person = Person(name: "terry")

let x = try JSONEncoder().encode(person)



@propertyWrapper
struct MyPropertyWrapper<T> {
    var wrappedValue: T
    
    
}
