
enum Optional<Wrapper> {
    case some(Wrapper)
    case none
}

extension Optional {
    // autoclosure to achieve lazy evaluation
    static func ??(_ originValue: Optional<Wrapper>, yieldValue: @autoclosure () -> Wrapper) -> Wrapper {
        if case let .some(value) = originValue {
            return value
        } else {
            return yieldValue()
        }
    }
    
    // hight-order function for transform the wrapper type
    func map<T>(_ closure: (Wrapper) -> T) -> Optional<T> {
        
        // pattern match with memory binding
        switch self {
        case let .some(value): return .some(closure(value))
        case .none           : return .none
        }
    }
}


// protocol condition conformance, when value conformance a protocol then the contain type will conform specific protocol.
extension Optional: Equatable where Wrapper: Equatable { }
extension Optional: Hashable  where Wrapper: Hashable  { }


Optional("1") == Optional("1") // true

let optionalInt = Optional<Int>.some(10)
let transform = optionalInt.map { $0 * 3 }
print(transform)                   // 30



// None coalescing with lazy evaluation
Optional<Int>.some(20) ?? 10       // 20
Optional<Int>.none     ?? 10       // 10


// Initializers with literal
extension Optional: ExpressibleByNilLiteral {
    init(nilLiteral: ()) {
        self = .none
    }
}

let nilOptions: Optional<Int> = nil
print(nilOptions) // none

extension Optional: ExpressibleByFloatLiteral where Wrapper == Double {
    init(floatLiteral value: Wrapper) {
        self = .some(value)
    }
}

let doubleOptions: Optional<Double> = 12.345
print(doubleOptions) // .some(12.345)


extension Optional: ExpressibleByIntegerLiteral where Wrapper == Int {
    init(integerLiteral value: IntegerLiteralType) {
        self = .some(value)
    }
}

let IntOptions: Optional<Int> = 12345
print(IntOptions) // .some(1234)


extension Optional: ExpressibleByUnicodeScalarLiteral where Wrapper == String {
    init(unicodeScalarLiteral value: Wrapper) {
        self = .some(value)
    }
}

extension Optional: ExpressibleByExtendedGraphemeClusterLiteral where Wrapper == String {
    init(extendedGraphemeClusterLiteral value: Wrapper) {
        self = .some(value)
    }
}

extension Optional: ExpressibleByStringLiteral where Wrapper == String {
    init(stringLiteral value: Wrapper) {
        self = .some(value)
    }
}
