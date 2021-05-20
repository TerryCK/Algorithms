import Foundation

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
    
    //O(capacity + capacity)
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

let cache = CacheRLU<Int, Int>(capacity: 3)
cache[5] = 5
cache.debugDescription
cache[2] = 5
cache.debugDescription
cache[1] = 10
cache.debugDescription
cache[5] = 1
cache.debugDescription
cache[2]
cache.debugDescription

func setValue(_ value: Value, for key: Key) {
    let newElement = (key, value)
    storage.insert(newElement, at: 0)
    
    if storage.count > capacity {
        let k = storage.count - capacity
        storage.removeLast(k)
    }
}


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
