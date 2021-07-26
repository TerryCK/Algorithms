
// T: get: O(1), put: O(1)
// S: O(capacity)
final class LRUCache {
    
    final class Node<Key: Hashable, Value> {
        var prev: Node?
        let key: Key
        var value: Value
        var next: Node?
    
        init(key: Key, _ value: Value, _ prev: Node? = nil, _ next: Node? = nil) {
            self.prev = prev
            self.next = next
            
            self.value = value
            self.key = key
        }
    }
    private typealias IntNode = Node<Int, Int>
    
    private var storage: [Int: IntNode] = [:]
    private let capacity: Int
    
    init(capacity: Int) {
        self.capacity = max(0, capacity)
    }
    
    

    func put(_ key: Int, _ value: Int) {
    
        defer {
            // O(1)
            if storage.count > capacity {
                storage[back!.key] = nil
                back = back?.prev
                back?.next = nil
            }
        }
        // T: O(1)
        let node = storage[key] ?? Node(key: key, value)
        node.value = value
        storage[key] = node
        moveToFront(node)
    }
    
    
    private var front: IntNode?
    private var back: IntNode?
    
    func get(_ key: Int) -> Int {
        guard let node = storage[key] else { return -1 }
        moveToFront(node)
        return node.value
    }
    
    //O(1)
    private func moveToFront(_ node: IntNode) {
            
        if front == nil {
            front = node
            back = node
            
            front?.next = node
            back?.prev = node
        }
        
        
        if node === front {
            return
        } else if node === back {
            back = node.prev
            back?.next = nil
        } else {
            let prev = node.prev
            let back = node.next
            prev?.next = back
            back?.prev = prev
        }
        
        node.prev = nil
        node.next = front
        front?.prev = node
        front = node
    }
}
