### LRU Cache
#### Introduction
![Cache](images/CacheLRU.jpg)

A cache LRU a.k.a __Least Recently Used__ is similar to a Dictionary, it stores a data with associated to a key, however the difference between LRU and Dictionary is LRU has a capacity but dictionary not, it has great perfomance when hightly hit same memory access and reduct memory space with specific capacity.

#### Function of LRU

1. get a value with a key
2. set a value with a key
3. initial with a capacity
4. keep order in storage

#### Implemetion

__Data Structure:__

```Swift 
class CacheRLU<Key: Hashable, Value> {
    
    private var storage = Array<(key: Key, value: Value)>()
    
    private var capacity: Int
    
    init(capacity: Int) {
        self.capacity = max(0, capacity)
    }
}

```

__Get Value by a Key with time complexity O(capacity + capacity + capacity):__

```Swift 
func getValue(_ key: Key) -> Value? {
    let boundary = min(storage.count, capacity)
    for index in 0..<boundary where storage[index].key == key {
        if index != 0 {
            let target = storage.remove(at: index)
            storage.insert(target, at: 0)
        }
        return storage.first?.value
    }
    return nil
}
```

__Get a Value by a Key with time complexity O(capacity + capacity):__

```Swift 
func getValue(_ key: Key) -> Value? {
    let boundary = min(storage.count, capacity)
    for index in 0..<boundary where storage[index].key == key {
        if index != 0 {
            storage.pickToFirst(at: index)
        }
        return storage.first?.value
    }
    
    return nil
}

extension Array  {
    func pickToFirst(at pickIndex: Index) -> Array {
        guard (1..<count).contains(pickIndex) else { return self }
        var copy = self
        copy[1] = self[0]
        copy[0] = self[pickIndex]
        
        for index in 2...pickIndex {
            copy[index] = self[index-1]
        }
        
        return copy
    }
}

```

__Set a Value by a Key with time complexity O(capacity + capacity):__

```Swift 
func setValue(_ value: Value, for key: Key) {
    let newElement = (key, value)
    storage.insert(newElement, at: 0)
    
    if storage.count > capacity {
        let k = storage.count - capacity
        storage.removeLast(k)
    }
}
```


__Full Implemetation:__

```Swift 

class CacheRLU<Key: Hashable, Value>: CustomDebugStringConvertible {
    var debugDescription: String {
        "storage: \(storage)"
    }
    
    
    private var storage = Array<(key: Key, value: Value)>()
    
    private var capacity: Int
    
    init(capacity: Int) {
        self.capacity = max(0, capacity)
    }
    
    // O(capacity + 2*capacity)
    func getValue(_ key: Key) -> Value? {
        let boundary = min(storage.count, capacity)
        for index in 0..<boundary where storage[index].key == key {
            if index != 0 {
                let target = storage.remove(at: index)
                storage.insert(target, at: 0)
            }
            return storage.first?.value
        }
        return nil
    }
    
    // O(capacity + capacity) reduce of array remove and insert time complexity
    func getValue2(_ key: Key) -> Value? {
        let boundary = min(storage.count, capacity)
        for index in 0..<boundary where storage[index].key == key {
            if index != 0 {
                storage.pickToFirst(at: index)
            }
            return storage.first?.value
        }
        
        return nil
    }
    
    // O(capacity + capacity)
    func setValue(_ value: Value, for key: Key) {
        let newElement = (key, value)
        storage.insert(newElement, at: 0)
        
        if storage.count > capacity {
            let k = storage.count - capacity
            storage.removeLast(k)
        }
    }
    
    
    subscript(key: Key) -> Value? {
        get { getValue(key) }
        set {
            if let newValue = newValue {
                setValue(newValue, for: key)
            }
        }
    }
}

extension Array  {
    //O(n) 
    func pickToFirst(at pickIndex: Index) -> Array {
        guard (1..<count).contains(pickIndex) else { return self }
        var copy = self
        copy[1] = self[0]
        copy[0] = self[pickIndex]
        
        for index in 2...pickIndex {
            copy[index] = self[index-1]
        }
        
        return copy
    }
}

// Usage

let cache = CacheRLU<Int, Int>(capacity: 3) // storage: []
cache[5] = 5 //  storage: [(key: 5, value: 5)]
cache[2] = 5 //  storage: [(key: 2, value: 5), (key: 5, value: 5)]
cache[1] = 10 // storage: [(key: 1, value: 10), (key: 2, value: 5), (key: 5, value: 5)]
cache[5] = 1  // storage: [(key: 5, value: 1), (key: 1, value: 10), (key: 2, value: 5)]
cache[2]      // storage: [(key: 2, value: 5), (key: 5, value: 1), (key: 1, value: 10)]

```

#### Disussion
In this note, why use the Array instead of a DoublyLinkedList to store data?

The DoublyLinkedList is great for flexible allocation memory space and easy to use pointer to change the order of objects. 

However there needs more memory space than the array used, in DoublyLinkedList, we need to store more two-pointer memory space than the array dose. 
When random access in memory, the array is a chunk of continuing memory, DoublyLinkedList is not, which means the array access more efficient & predictable than DoublyLinkedList with lower instruments.

#### Playground
Xcode 12.2 Swift 5.3

[Swift playground](playgrounds/Cache LRU.playground)

#### Inspired by 
[How To Implement Cache LRU With Swift](https://marcosantadev.com/implement-cache-lru-swift/#getting_started)

[Bjarne Stroustrup: Why you should avoid Linked Lists](https://www.youtube.com/watch?v=YQs6IC-vgmo&feature=emb_title)