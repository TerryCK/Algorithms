import Foundation
import UIKit

//
//let url = Bundle.main.url(forResource: "pinFull", withExtension: "pdf")!
//
//let data = try! Data(contentsOf: url)
//
//let image = UIImage(named: "pinFull.png")

func memoize<T: Hashable, U>( body: @escaping (T) -> U ) -> (T) -> U  {
    var memo = Dictionary<T, U>()
    return { x in
        if let q = memo[x] { return q }
        let r = body(x)
        memo[x] = r
        return r
    }
}
func sizeof<T> (_ : T) -> Int { return (MemoryLayout<T>.size) }

func sizeof<T> (_ value : [T]) -> Int { return (MemoryLayout<T>.size * value.count) }

func address(of o: UnsafeRawPointer) -> String { return Int(bitPattern: o).toHexString }

func addressHeap<T: AnyObject>(of o: T) -> String { return unsafeBitCast(o, to: Int.self).toHexString }

extension Int {
    var toHexString: String { return String(format: "%p", self) }
}
// Swift Quiz

var language = "Objc"

let code = { [language] in
    print(language)
}

language = "Swift"

let newCode = code
newCode()

// What's the output?


class A {
    let name:String
    init(name: String) {
        
        self.name = name
    }
}


var a = A(name: "Objc")
addressHeap(of: a)
let x = { [a] in
    addressHeap(of: a)
    print(a.name)
}

a = A(name: "Swift")
addressHeap(of: a)
let newX = x
newX()
addressHeap(of: a)
