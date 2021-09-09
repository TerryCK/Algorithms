
//: [Previous](@previous)

import Foundation

@propertyWrapper
struct Uppercased {
    private var text: String
    var wrappedValue: String {
        get { text.uppercased() }
        set { text = newValue }
    }
    
    init(wrappedValue: String)  {
        self.text = wrappedValue
    }
}


@propertyWrapper
struct Clamping<Value: Comparable> {
    
    var value: Value
    let range: ClosedRange<Value>
    
    init(wrappedValue: Value, _ range: ClosedRange<Value>) {
        precondition(range.contains(wrappedValue))
        self.value = wrappedValue
        self.range = range
    }
    
    init(wrappedValue: Value, min: Value, max: Value) {
        self.value = wrappedValue
        self.range = Swift.min(max, min)...Swift.max(min, max)
    }
    
    var wrappedValue: Value {
        get { value }
        set { value = min(max(range.lowerBound, newValue), range.upperBound) }
    }
}

//
public protocol Copyable: AnyObject {
  func copy() -> Self
}

/// A property wrapper that gives an object copy-on-write semantics.
///
/// Source: Brent Royal-Gordon, [Swift Evolution proposal SE-0258](https://github.com/apple/swift-evolution/blob/master/proposals/0258-property-wrappers.md#copy-on-write)
@propertyWrapper
public struct CopyOnWrite<Value: Copyable> {
  private var _wrappedValue: Value

  public init(wrappedValue: Value) {
    _wrappedValue = wrappedValue
  }

  public var wrappedValue: Value {
    mutating get {
      if !isKnownUniquelyReferenced(&_wrappedValue) {
        _wrappedValue = _wrappedValue.copy()
      }
      return _wrappedValue
    }
    set {
      _wrappedValue = newValue
    }
  }
}


/// A wrapper for a getter and setter.
///
/// Can be used to create a "shared mutable struct": multiple `Ref` instances that
/// capture the same struct variable in their `read` and `write` closures will
/// mutate the common storage of the captured variable.
///
/// Source: [Swift Evolution proposal SE-0258](https://github.com/apple/swift-evolution/blob/master/proposals/0258-property-wrappers.md#ref--box)
@dynamicMemberLookup
@propertyWrapper
public struct Ref<Value> {
  /// The getter for reading the current value.
  private let read: () -> Value
  /// The setter for setting a new value.
  private let write: (Value) -> Void

   public init(read: @escaping () -> Value, write: @escaping (Value) -> Void) {
    self.read = read
    self.write = write
  }

   public var wrappedValue: Value {
    get { return read() }
    nonmutating set { write(newValue) }
  }

   /// A `Ref` that drills down into `wrappedValue` and provides a shared mutable
  /// view of the property specified by `keyPath`.
  public subscript<U>(dynamicMember keyPath: WritableKeyPath<Value, U>) -> Ref<U> {
    return Ref<U>(
      read: { self.wrappedValue[keyPath: keyPath] },
      write: { self.wrappedValue[keyPath: keyPath] = $0 })
  }
}

@propertyWrapper
public class Box<Value> {
  public var wrappedValue: Value

  public init(wrappedValue: Value) {
    self.wrappedValue = wrappedValue
  }

  /// A `Ref` that can read and mutate `wrappedValue`.
  public var projectedValue: Ref<Value> {
    Ref(read: { self.wrappedValue }, write: { self.wrappedValue = $0 })
  }
}


@propertyWrapper
struct Ranged<T: Comparable> {
    private var minimum: T
    private var maximum: T
    private var value: T
    var wrappedValue: T {
        get { value }
        set {
            if newValue > maximum {
                value = maximum
            } else if newValue < minimum {
                value = minimum
            } else {
                value = newValue
            }
        }
    }
    init(wrappedValue: T, minimum: T, maximum: T) {
        self.minimum = minimum
        self.maximum = maximum
        self.value = wrappedValue
        self.wrappedValue = wrappedValue
    }
}


@propertyWrapper
struct Localizable {
    private var key: String
    var wrappedValue: String {
        get { NSLocalizedString(key, comment: "") }
        set { key = newValue }
    }
    init(wrappedValue: String) {
        self.key = wrappedValue
    }
}

protocol UserDefualtAccessable {
    
}

extension Int: UserDefualtAccessable {}
extension Double: UserDefualtAccessable {}
extension String: UserDefualtAccessable {}
extension Array: UserDefualtAccessable {}
extension Data: UserDefualtAccessable {}
extension Date: UserDefualtAccessable {}
extension Float: UserDefualtAccessable {}
extension Bool: UserDefualtAccessable {}

@propertyWrapper
struct UserDefault<T: UserDefualtAccessable> {
    let key: String
    var defaultValue: T? = nil
    var wrappedValue: T? {
        set {
            switch newValue {
            case let newValue?: UserDefaults.standard.set(newValue, forKey: key)
            case .none:         UserDefaults.standard.removeObject(forKey: key)
            }
        }
        get {
            switch UserDefaults.standard.object(forKey: key) as? T {
            case let value?: return value
            case .none:
                UserDefaults.standard.set(defaultValue, forKey: key)
                return defaultValue
            }
        }
    }
}

@propertyWrapper
struct ISO8601DateFormatted {
    static private let formatter = ISO8601DateFormatter()
    var projectedValue: String { ISO8601DateFormatted.formatter.string(from: wrappedValue) }
    var wrappedValue: Date
}

@propertyWrapper
struct Trimmed {
    
    private(set) var value: String = ""
    
    var wrappedValue: String {
        get { value }
        set { value = newValue.trimmingCharacters(in: .whitespacesAndNewlines) }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}

/// Perform a GET request using ULRSession
typealias Service<Response> = (_ completionHandler: @escaping (Result<Response, Error>) -> Void) -> ()
@propertyWrapper
struct GET {
    private var url: URL
    init(url: String) {
        self.url = URL(string: url)!
    }
    var wrappedValue: Service<String> {
        get {
            return { completionHandler in
                let task = URLSession.shared.dataTask(with: self.url) { (data, response, error) in
                    guard error == nil else {
                        completionHandler(.failure(error!)); return
                    }
                    let string = String(data: data!, encoding: .utf8)!
                    completionHandler(.success(string))
                }
                task.resume()
            }
        }
    }
}

@propertyWrapper
struct Validate<Value> {
    
    private var _value: Value?
    private var _lastValid: Value?
    
    fileprivate let _isValid: (Value) -> Bool
    
    let asserts: Bool
    let useLastValid: Bool
    let message: (Value) -> String
    
    init(_ validation: @escaping (Value) -> Bool, asserts: Bool = false, useLastValid: Bool = false, message: @escaping (Value) -> String = { "Invalid - \(String(describing: $0))" }) {
        self._isValid = validation
        self.asserts = asserts
        self.useLastValid = useLastValid
        self.message = message
    }
    
    var wrappedValue: Value? {
        get {
            if !useLastValid {
                return _value
            } else {
                return _value ?? _lastValid
            }
        }
        set {
            if let newValue = newValue, !_isValid(newValue) {
                if asserts {
                    assertionFailure(self.message(newValue))
                }
                _value = nil
            } else {
                _value = newValue
                if useLastValid { _lastValid = newValue }
            }
        }
    }
}

extension Validate where Value: Equatable {
    init(equals otherValue: Value, asserts: Bool = false) {
        self.init({ $0 == otherValue }, asserts: asserts, message: { "Error: \($0) not equals to \(otherValue)" })
    }
    init(notEquals otherValue: Value, asserts: Bool = false) {
        self.init({ $0 != otherValue }, asserts: asserts, message: { "Error: \($0) equals to \(otherValue)" })
    }
}

extension Validate where Value: Comparable {
    init(lessThan otherValue: Value, asserts: Bool = false) {
        self.init({ $0 < otherValue }, asserts: asserts, message: { "Error: \($0) not less than \(otherValue)" })
    }
    init(greaterThan otherValue: Value, asserts: Bool = false) {
        self.init({ $0 > otherValue }, asserts: asserts, message: { "Error: \($0) not greater than \(otherValue)" })
    }
}

extension Validate where Value: Collection {
    init(isEmpty: Bool, asserts: Bool = false) {
        self.init({ isEmpty && $0.isEmpty }, asserts: asserts, message: { "Error: \($0) is not empty" })
    }
}

extension Validate where Value == String {
    init(regex: String, asserts: Bool = false) {
        self.init({ $0.range(of: regex, options: .regularExpression) != nil },
                  asserts: asserts,
                  message: { "Error: \($0) doesn't match regex: \(regex)" })
    }
    init(minLength: UInt = 0, maxLength: UInt = UInt(Int.max), asserts: Bool = false) {
        self.init({ (minLength...maxLength).contains(UInt($0.count)) },
                  asserts: asserts,
                  message: { "Error: \($0) not between \(minLength) and \(maxLength)" })
    }
    init(isBlank: Bool, asserts: Bool = false) {
        self.init({ isBlank && $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty },
                  asserts: asserts,
                  message: { "Error: \($0) \(isBlank ? "is not blank" : "is blank")" })
    }
}

extension Validate where Value: FixedWidthInteger {
    init(min: Value = .min, max: Value = .max, asserts: Bool = false) {
        self.init({ (min...max).contains($0) }, asserts: asserts, message: { "Error: \($0) not between \(min) and \(max)" })
    }
}

extension Validate where Value: Numeric & Comparable {
    init(min: Value, max: Value, asserts: Bool = false) {
        self.init({ (min...max).contains($0) }, asserts: asserts, message: { "Error: \($0) not between \(min) and \(max)" })
    }
}


@propertyWrapper
struct Cache<Value: Comparable> {
    private var seconds: TimeInterval
    private var date: TimeInterval
    
    var value: Value? = nil
    
    var wrappedValue: Value? {
        get {
            if (Date().timeIntervalSince1970 - self.date) > seconds {
                return nil
            } else {
                return value
            }
        }
        set {
            self.date = Date().timeIntervalSince1970
            value = newValue
        }
    }
    
    init(seconds: TimeInterval) {
        self.date = Date().timeIntervalSince1970
        self.seconds = seconds
    }
}


@propertyWrapper
struct Validate2<Value> {
    var value: Value?
    var validations: [(Value?) -> Bool] = []
    
    var wrappedValue: Value? {
        get {
            let passedValidations = validations.reduce(true) { (result, function) in
                return result && function(value)
            }
            guard passedValidations else {
                return nil
            }
            return value
        }
        set {
            value = newValue
        }
    }
    
    init(initialValue value: Value?, validations: [(Value?) -> Bool]) {
        self.value = value
        self.validations = validations
    }
}

/// A property wrapper for delayed initialization. Enforces the definite initialization rules dynamically at runtime
/// rather than at compile time.
///
/// A `@DelayedLet` property doesn't have to be initialized at initialization of its containing type. You must assign
/// a value _exactly once_ and _before_ accessing the value for the first time. Reading the value before setting it or
/// assigning a value more than once results in a runtime failure.
///
/// Source: [Swift Evolution proposal SE-0258](https://github.com/apple/swift-evolution/blob/master/proposals/0258-property-wrappers.md#delayed-initialization)
///
/// - Seealso: `DelayedVar`
@propertyWrapper
public struct DelayedLet<Value> {
  private var _value: Value? = nil

  public init() {}

  public var wrappedValue: Value {
    get {
      guard let value = _value else {
        fatalError("DelayedLet: property accessed before being initialized")
      }
      return value
    }

    // Perform initialization. Trap if the value is already initialized.
    set {
      if _value != nil {
        fatalError("DelayedLet: property initialized twice")
      }
      _value = newValue
    }
  }
}


/// A property wrapper for delayed initialization. Enforces the definite initialization rules dynamically at runtime
/// rather than at compile time.
///
/// A `@DelayedVar` property doesn't have to be initialized at initialization of its containing type. You must assign
/// a value _before_ accessing the value for the first time. Reading the value before setting it results in a runtime failure.
/// Unlike `@DelayedLet`, a `@DelayedVar` can be assigned to multiple times.
///
/// Source: [Swift Evolution proposal SE-0258](https://github.com/apple/swift-evolution/blob/master/proposals/0258-property-wrappers.md#delayed-initialization)
///
/// - Seealso: `DelayedLet`
@propertyWrapper
public struct DelayedVar<Value> {
  private var _value: Value? = nil

  public init() {}

  public var wrappedValue: Value {
    get {
      guard let value = _value else {
        fatalError("DelayedVar: property accessed before being initialized")
      }
      return value
    }
    set {
      _value = newValue
    }
  }

  /// "Resets" the wrapped value so it can be initialized again.
  /// This can be useful if you want to free up resources held by the current value without assigning a new one right away.
  public mutating func reset() {
    _value = nil
  }
}


/// A property wrapper for a value that's initialized lazily when it's first accessed.
///
/// This isn't a complete replacement for Swift's built-in `lazy` keyword because, unlike `lazy`, the initial value of a `@Lazy` property can't refer to the `self` of the enclosing type.
///
/// Source: [Swift Evolution proposal SE-0258](https://github.com/apple/swift-evolution/blob/master/proposals/0258-property-wrappers.md#proposed-solution)
@propertyWrapper
public enum Lazy<Value> {
  case uninitialized(() -> Value)
  case initialized(Value)
  
  /// Creates the lazy value without initializing it.
  /// - Parameter initialValue: The initializer function that's used to initialize the value on first access.
  public init(wrappedValue: @autoclosure @escaping () -> Value) {
    self = .uninitialized(wrappedValue)
  }
  
  public var wrappedValue: Value {
    mutating get {
      switch self {
      case .uninitialized(let initializer):
        let value = initializer()
        self = .initialized(value)
        return value
      case .initialized(let value):
        return value
      }
    }
    set {
      self = .initialized(newValue)
    }
  }
}






/// A property wrapper that stores its value directly in user defaults.
///
/// The `Value` type specifies how it stores itself as a property list object
/// via its `PropertyListConvertible` conformance. To store your own type in user defaults,
/// conform it to `PropertyListConvertible`.
///
/// Usage:
///
///     @UserDefault(key: "locationTrackingEnabled", defaultValue: false)
///     var isLocationTrackingEnabled: Bool
///
///     @UserDefault(key: "colorScheme", defaultValue: .solarizedDark)
///     var colorScheme: ColorScheme
///
/// Unless otherwise specified, defaults values are read from and written to `UserDefaults.standard`.
/// You can override this by passing an explicit `UserDefaults` instance to the initializer:
///
///     @UserDefault var localeIdentifier: String
///     ...
///     let myDefaults = UserDefaults(...)
///     $localeIdentifier = (key: "localeIdentifier", defaultValue: "en_US", userDefaults: myDefaults)
///
/// Source: Extended from a base implementation shown in [Swift Evolution proposal SE-0258](https://github.com/apple/swift-evolution/blob/master/proposals/0258-property-wrappers.md)
@propertyWrapper
public struct UserDefault2<Value: PropertyListConvertible> {
  public let key: String
  public let defaultValue: () -> Value
  public let userDefaults: UserDefaults

  public init(key: String, defaultValue: @autoclosure @escaping () -> Value, userDefaults: UserDefaults = .standard) {
    self.key = key
    self.defaultValue = defaultValue
    self.userDefaults = userDefaults
    // Register default value with user defaults
    if let defaultValue = defaultValue() as? OptionalProtocol {
      /// `nil` or `NSNull` are not valid property list values.
      // This means we can't register a `nil` default value and we can't distinguish between
      // "value not present" and "values was explicitly set to nil". This makes `nil` the only
      // safe choice as a default value.
      precondition(defaultValue.isNil, """
        The default value for optional UserDefault properties must be nil. \
        nil or NSNull are not valid property list values. This means we can't distinguish between \
        "value not present" and "values was explicitly set to nil". \
        This makes `nil` the only safe choice as a default value.
        """)
      // Do nothing else. We can't register `nil` as the default value.
    } else {
      userDefaults.register(defaults: [key: defaultValue().propertyListValue])
    }
  }

  public var wrappedValue: Value {
    get {
      guard let plistValue = userDefaults.object(forKey: key) as? Value.Storage,
        let value = Value(propertyListValue: plistValue)
        else { return defaultValue() }
      return value
    }
    nonmutating set {
      if let optional = newValue as? OptionalProtocol, optional.isNil {
        userDefaults.removeObject(forKey: key)
      } else {
        userDefaults.set(newValue.propertyListValue, forKey: key)
      }
    }
  }
}

// MARK: - PropertyListConvertible
/// A type that can convert itself to and from a plist-compatible type (for storage in a plist).
public protocol PropertyListConvertible {
  /// The type that's used for storage in the plist.
  associatedtype Storage: PropertyListNativelyStorable

  /// Creates an instance from its property list representation.
  ///
  /// The default implementation for PropertyListStorage == Self uses `propertyListValue` directly as `self`.
  ///
  /// - Returns: `nil` if the conversion failed.
  init?(propertyListValue: Storage)

  /// The property list representation of `self`.
  /// The default implementation for PropertyListStorage == Self returns `self`.
  var propertyListValue: Storage { get }
}

extension PropertyListConvertible where Storage == Self {
  public init?(propertyListValue: Self) {
    self = propertyListValue
  }

  public var propertyListValue: Self { self }
}

/// UUID stores itself as a String
extension UUID: PropertyListConvertible {
  public var propertyListValue: String { uuidString }

  public init?(propertyListValue: Storage) {
    self.init(uuidString: propertyListValue)
  }
}

/// Optionals can be stored in a property list if they wrap a PropertyListConvertible type
///
/// - Note: The default value for optional UserDefault properties must be `nil`.
///   `nil` or `NSNull` are not valid property list values. This means we can't distinguish between
///   "value not present" and "values was explicitly set to nil".
///   This makes `nil` the only safe choice as a default value.
extension Optional: PropertyListConvertible where Wrapped: PropertyListConvertible {
  public var propertyListValue: Wrapped.Storage? {
    return self?.propertyListValue
  }

  public init?(propertyListValue: Wrapped.Storage?) {
    guard let storedValue = propertyListValue else { return nil }
    self = Wrapped(propertyListValue: storedValue)
  }
}

/// Arrays convert themselves to their property list representation by converting each element to its plist representation.
extension Array: PropertyListConvertible where Element: PropertyListConvertible {
  /// Returns `nil` if one or more elements can't be converted.
  public init?(propertyListValue plistArray: [Element.Storage]) {
    var result: [Element] = []
    result.reserveCapacity(plistArray.count)
    for plistElement in plistArray {
      guard let element = Element(propertyListValue: plistElement) else {
        // Abort if one or more elements can't be created.
        return nil
      }
      result.append(element)
    }
    self = result
  }

  public var propertyListValue: [Element.Storage] {
    map { $0.propertyListValue }
  }
}

extension Dictionary: PropertyListConvertible
  where Key: PropertyListConvertible, Value: PropertyListConvertible,
    Key.Storage: Hashable,
    // The Swift 5.1 compiler forced me to add these two constraints, but they don't make much
    // sense to me. They are related to the `Dictionary: PropertyListNativelyStorable` extension.
    // I believe they mae sure that the PropertyListStorage associated type is the same in both
    // extensions.
    Key.Storage == Key.Storage.Storage,
    Value.Storage == Value.Storage.Storage
{
  /// Returns `nil` if one or more elements can't be converted.
  public init?(propertyListValue plistDict: [Key.Storage: Value.Storage]) {
    var result: [Key: Value] = [:]
    result.reserveCapacity(plistDict.count)
    for (plistKey, plistValue) in plistDict {
      guard let key = Key(propertyListValue: plistKey), let value = Value(propertyListValue: plistValue) else {
        // Abort if one or more elements can't be created.
        return nil
      }
      result[key] = value
    }
    self = result
  }

  /// If two or more keys convert to the same key, the result will include only one of those key-value pairs.
  public var propertyListValue: [Key.Storage: Value.Storage] {
    return Dictionary<Key.Storage, Value.Storage>(
      map { ($0.key.propertyListValue, $0.value.propertyListValue) },
      uniquingKeysWith: { $1 })
  }
}

// MARK: - PropertyListNativelyStorable
/// A type that can be natively stored in a property list, i.e. a _property list object_.
///
/// This is a marker protocol, i.e. it has no requirements. You should not conform your own types to it.
/// We already provide the required conformances for the standard plist-compatible types.
///
/// Instances of these types can be property list objects:
///
/// - Dictionary/NSDictionary (Key and Value must be plist types)
/// - Array/NSArray (Element must be a plist type)
/// - String/NSString
/// - A numeric type that's convertible to NSNumber
/// - Bool
/// - Date/NSDate
/// - Data/NSData
///
/// See https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/PropertyList.html
public protocol PropertyListNativelyStorable: PropertyListConvertible {}

extension String: PropertyListNativelyStorable {}
extension Int: PropertyListNativelyStorable {}
extension Int8: PropertyListNativelyStorable {}
extension Int16: PropertyListNativelyStorable {}
extension Int32: PropertyListNativelyStorable {}
extension Int64: PropertyListNativelyStorable {}
extension UInt: PropertyListNativelyStorable {}
extension UInt8: PropertyListNativelyStorable {}
extension UInt16: PropertyListNativelyStorable {}
extension UInt32: PropertyListNativelyStorable {}
extension UInt64: PropertyListNativelyStorable {}
extension Float: PropertyListNativelyStorable {}
extension Double: PropertyListNativelyStorable {}
extension Bool: PropertyListNativelyStorable {}
extension Date: PropertyListNativelyStorable {}
extension Data: PropertyListNativelyStorable {}

extension Optional: PropertyListNativelyStorable where Wrapped: PropertyListNativelyStorable {}

extension Array: PropertyListNativelyStorable where Element: PropertyListNativelyStorable {}

extension Dictionary: PropertyListNativelyStorable where Key: PropertyListNativelyStorable, Value: PropertyListNativelyStorable, Key.Storage == Key, Value.Storage == Value {}

// MARK: - OptionalProtocol
/// A marker protocol for Optionals.
/// Used to identify optional values in type casts in generic contexts.
protocol OptionalProtocol {
  var isNil: Bool { get }
}

extension Optional: OptionalProtocol {
  var isNil: Bool { self == nil }
}


#if canImport(UIKit)
import UIKit

@propertyWrapper
public struct UseAutoLayout<T: UIView> {
    public var wrappedValue: T {
        didSet {
            setAutoLayout()
        }
    }

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        setAutoLayout()
    }

    func setAutoLayout() {
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
#endif
