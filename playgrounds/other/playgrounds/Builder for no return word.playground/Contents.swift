import Foundation

@_functionBuilder
struct Builder {
    typealias Component = String
    
    static func buildBlock(_ components: Component...) -> Component {
        components.joined()
    }
    
    static func buildEither(first component: Component) -> Component {
        component
    }
    
    static func buildEither(second component: Component) -> Component {
        component
    }
    
    static func buildExpression(_ expression: Int) -> Component {
        "\(expression)"
    }
    
    static func buildExpression(_ expression: Component) -> Component {
        expression
    }
    
    static func buildFinalResult(_ component: String) -> Int {
        Int(component) ?? 0
    }
    
    static func buildFinalResult(_ component: Component) -> Component {
        component
    }
}


//    static func buildArray(_ components: [String]) -> Component {
//        return components.joined(separator: "")
//    }

//    static func buildOptional(_ component: Component?) -> Component {
//        return component
//    }


protocol Proposed {
    @Builder func proposed() -> Int
}

enum Foo: Proposed {
    case bar
    case baz
    
    func original() -> Int {
        switch self {
        case .bar: return 42
        case .baz: return 6
        default  : return 9
        }
    }
    
//    @Builder
    func proposed() -> Int {
        switch self {
        case .bar: 42
        case .baz:  6
        default:    9
        }
    }
}

Foo.bar.proposed() // return 42

//
//@Builder func greet(name: String, countdown: Int) -> Int {
//    switch weather {
//    case .sun:             "sun"
//    case .wind(let speed): "wind \(speed)"
//
//    }
//}
//
//greet(name: "123", countdown: 12)



class Base {
    func test(i: Int = 1) {
        print("Base i: \(i)")
    }
}


class Sub: Base {
    override func test(i: Int = 2) {
        print("Sub i : \(i)")
        super.test(i: i)
    }
}

let s: Base = Sub()
s.test()
