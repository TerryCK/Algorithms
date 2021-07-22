//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
public protocol CaseNameConvertible {
    var caseName: String { get }
}

extension CaseNameConvertible {
    public var caseName: String { return String(describing: self) }
}
struct AnyQuickMenuItem: CustomStringConvertible {
    var description: String {
        "AnyQuickMenuItem name\(name)"
    }
    
    let name: String
    
}
struct Product {
    
}
enum NavigationDestination: CaseNameConvertible {
    case splash
    case product(produce: Product, redirectUrlSuffix: String? = nil)
    case trendingBet(eventID: Double)
    
}


// call side



// enter implementation



NavigationDestination.product(produce: .init())

NavigationDestination.init()
