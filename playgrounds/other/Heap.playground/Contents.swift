
struct Heap<Element: Equatable> {
    private var storage = Array<Element>()
    typealias Index = Int
    let priority: (Element, Element) -> Bool
    var count: Int { storage.count }
    var isEmpty: Bool { storage.isEmpty }
    var peak: Element? { storage.first }
    func leftChild(index: Index) -> Index {
        2 * index + 1
    }
    
    func rightChild(index: Index) -> Index {
        2 * index + 2
    }
    
    func parent(index: Index) -> Index? {
        index == 0 ? nil : (index - 1) / 2
    }
    
    
    mutating func remove() -> Element? {
        guard !isEmpty else {
            return nil
        }
        storage.swapAt(0, count-1)
        defer { shiftDown(index: 0) }
        return storage.removeLast()
    }
    
    
    mutating func shiftDown(index: Index) {
        var parent = index
        
        while true {
            let left = leftChild(index: parent)
            let right = rightChild(index: parent)
            var candidate = parent
            
            if left < count, !priority(storage[left], storage[parent]) {
                storage.swapAt(left, parent)
                candidate = left
            }
            
            if right < count, !priority(storage[right], storage[parent]) {
                storage.swapAt(right, parent)
                candidate = right
            }
            
            if parent == candidate { return }
            storage.swapAt(parent, candidate)
            parent = candidate
        }
    }
    
    
    mutating func shiftUp(index: Index) {
        var child = index
        
        while true {
            let parentIndex = parent(index: child)
            
            if !priority(storage[parentIndex], storage[child]) {
                storage.swapAt(parentIndex, child)
                parentIndex = child
            }
        }
        
        
        
    }
}
