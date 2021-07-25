
class LRUCache {
    
    class Node {
        var previous: Node?
        let key: Int
        var value : Int
        var next: Node?
        init(_ h: Node? = nil, _ key : Int,  _ value: Int, next: Node? = nil) {
            previous = h
            self.key = key
            self.value = value
            self.next = next
        }
    }
    
    private var head: Node? = nil
    private var lastNode: Node? = nil
    private var cache: [Int: Node] = [:]
    
    let capacity: Int
    
    init(_ capacity: Int) {
        self.capacity = capacity
    }
    
    func get(_ key: Int) -> Int {
        guard let node = cache[key] else { return -1 }
        moveToFirst(node)
        return node.value
    }
    
    private func moveToFirst(_ node: Node) {

        if head == nil {
            head = node
            lastNode = node
            lastNode?.previous = head
            head?.next = lastNode
            return
        }
        
        
        if head === node {
            return
        } else if node === lastNode {
            lastNode = lastNode?.previous
            lastNode?.next = nil
        } else if case let (next?, prev?) = (node.next, node.previous) {
            prev.next = next
            next.previous = prev
        }
        
        
        head?.previous = node
        node.next = head
        node.previous = nil
        head = node
    }
    
    func put(_ key: Int, _ value: Int) {
        
        defer {
            if cache.count > capacity {
                cache[lastNode!.key] = nil
                lastNode = lastNode!.previous
                lastNode?.next = nil
            }
        }

        let node = cache[key] ?? Node(nil, key, value)
        node.value = value
        cache[key] = node
        moveToFirst(node)
    }
}

/**
 * Your LRUCache object will be instantiated and called as such:
 * let obj = LRUCache(capacity)
 * let ret_1: Int = obj.get(key)
 * obj.put(key, value)
 */


let lRUCache = LRUCache(2)

//cache.put(1, 0)
//cache.put(2, 1)
//cache.put(3, 1)
//cache.get(1)
//lRUCache.put(1, 1); // cache is {1=1}
//lRUCache.put(2, 2); // cache is {1=1, 2=2}
//lRUCache.get(1);    // return 1
//lRUCache.put(3, 3); // LRU key was 2, evicts key 2, cache is {1=1, 3=3}
//lRUCache.get(2);    // returns -1 (not found)
//lRUCache.put(4, 4); // LRU key was 1, evicts key 1, cache is {4=4, 3=3}
//lRUCache.get(1);    // return -1 (not found)
//lRUCache.get(3);    // return 3
//lRUCache.get(4);    // return 4


//["LRUCache","put","get","put","get","get"]
//[[1],[2,1],[2],[3,2],[2],[3]]


let lrucache2 = LRUCache(2)
lrucache2.put(2, 1)
lrucache2.put(1, 1)
lrucache2.put(2, 3)
lrucache2.put(4, 3)
lrucache2.get(1)
lrucache2.get(2) // == 3
//["LRUCache","put","put","put","put","get","get"]
//[[2],[2,1],[1,1],[2,3],[4,1],[1],[2]]


//["LRUCache","put","put","put","put","get","get","get","get","put","get","get","get","get","get"]
//[[3],[1,1],[2,2],[3,3],[4,4],[4],[3],[2],[1],[5,5],[1],[2],[3],[4],[5]]
