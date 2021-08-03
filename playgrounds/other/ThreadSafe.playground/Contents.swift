import Foundation

@propertyWrapper
final class ThreadSafely<Element> {
    let queue: DispatchQueue
    
    init(on dispatchQueue: DispatchQueue = .global()) {
        queue = dispatchQueue
    }
    
    var storage: Element?
    
    var wrappedValue: Element {
        set {
            queue.async(flags: .barrier) { [self] in
                storage = newValue
            }
        }
        get {
            var element: Element?
            queue.sync { element = storage }
            return element!
        }
    }
}


class Test {
    @ThreadSafely
    var list: Array<Int?>
    let count: Int
    
    init() {
        let count = 100000
        var a = Array<Int?>(repeating: nil, count: count)
        a.reserveCapacity(count)
        self.count = count
        list = a
        
    }
    
    
    func test() {
        for index in 0..<self.count {
            DispatchQueue.global().async {
                self.list[index] = Int.random(in: 0...self.count)
                print(index)
            }
        }
    }
}

Test().test()
