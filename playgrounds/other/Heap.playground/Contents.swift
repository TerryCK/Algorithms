import Foundation


struct Heap<Element: Comparable> {
    
    enum HeapType {
        case min, max
        var priority: (Element, Element) -> Bool { self == .min ? (>) : (<) } }
    
    init(_ elements: [Element], heapType: HeapType) {
        self.storage = elements
        self.priority = heapType.priority
        buildHeap()
    }
    
    init(_ elements: [Element], sort: @escaping ((Element, Element) -> Bool) = (>)) {
        self.storage = elements
        self.priority = sort
        buildHeap()
    }
    init(_ elements: Element..., sort: @escaping ((Element, Element) -> Bool) = (>)) {
        self.storage = elements
        self.priority = sort
        buildHeap()
    }
    
    private var storage = Array<Element>()

    typealias Index = Int

    let priority: (Element, Element) -> Bool

    var count: Int { storage.count }

    var isEmpty: Bool { storage.isEmpty }

    var peak: Element? { storage.first }

    mutating func dequeue() -> Element? {
        remove()
    }
    
    mutating func enqueue(element: Element) {
        storage.append(element)
        shiftUp(index: storage.count-1)
    }
    
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
        guard !isEmpty else { return nil }
        defer { shiftDown(index: 0) }
        storage.swapAt(0, count-1)
        return storage.removeLast()
    }
    
    
    mutating func shiftDown(index: Index) {
        var parent = index
        
        while true {
            let left = leftChild(index: parent)
            let right = rightChild(index: parent)
            var candidate = parent
            
            if left < count, !priority(storage[left], storage[candidate]) {
                candidate = left
            }
            
            if right < count, !priority(storage[right], storage[candidate]) {
                candidate = right
            }
            
            if parent == candidate { return }
            storage.swapAt(parent, candidate)
            parent = candidate
        }
    }
    
    
    mutating func shiftUp(index: Index) {
        var child = index
        while let parentIndex = parent(index: child), !priority(storage[parentIndex], storage[child]) {
            storage.swapAt(parentIndex, child)
            child = parentIndex
        }
    }
    
    mutating func buildHeap() {
        for i in stride(from: storage.count/2, through: 0, by: -1) {
            shiftDown(index: i)
        }
    }
}

let ramdon = (0...100).map { _ in Int.random(in: 0...100) }
print(ramdon)
var heap = Heap(ramdon, heapType: .min)


while let element = heap.dequeue() {
    print(element)
}


