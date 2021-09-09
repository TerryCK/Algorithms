
import Foundation

public func example(of id: String, closure: () -> Void) {
    print("---\(id)---")
    closure()
    print("\n")
}
