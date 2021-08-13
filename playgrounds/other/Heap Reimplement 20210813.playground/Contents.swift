import Foundation

protocol HeapProtocol {
    associatedtype Index
    associatedtype Element: Comparable
    associatedtype Order
    
    init(_ storage: Array<Element>, _ order: Order)
    
    //REMARK-: Basically Operations
    var isEmpty: Bool { get }
    var count: Int { get }
     
    var peek: Element? { get }
    
    mutating func heapifyDown(_ index: Index)
    mutating func heapifyUp(_ index: Index)
    
    func parentIndex(_ childIndex: Index) -> Index?
    func leftChildIndex(_ parentIndex: Index) -> Index?
    func rightChildIndex(_ parentIndex: Index) -> Index?
    
    //REMARK-: CRUD
    mutating func remove(_ index: Index) -> Element?
    mutating func insert(_ index: Index, _ element: Element)
    
    //REMARK-: Searching
    func indexFirst(_ element: Element, after index: Index) -> Index?
}


struct Heap<Element: Comparable>: HeapProtocol {
    
    private mutating func buildHeap() {
        for i in stride(from: count/2, through: 0, by: -1) {
            heapifyDown(i)
        }
    }
    
    typealias Order = (Element, Element) -> Bool
    
    private let order: Order
    
    init(_ storage: Array<Element>, _ order: @escaping Order = (>)) {
        self.order = order
        self.storage = storage
        buildHeap()
    }
    
    typealias Index = Int
    
    private var storage = [Element]()
    
    var isEmpty: Bool { storage.isEmpty }
    
    var count: Int { storage.count }
    
    
    var peek: Element? { storage.first }

    
    mutating func heapifyDown(_ index: Index) {
        var parent = index
        while true {
            var candidate = parent
            if let left = leftChildIndex(candidate), !order(storage[candidate], storage[left]) {
                candidate = left
            }
            
            if let right = rightChildIndex(candidate), !order( storage[candidate], storage[right])  {
                candidate = right
            }
            
            if candidate == parent { return }
            storage.swapAt(candidate, parent)
            parent = candidate
        }
    }
    
    
    mutating func heapifyUp(_ index: Index) {
        var currentIndex = index
        while let parent = parentIndex(currentIndex) {
            if !order(storage[parent], storage[currentIndex]) {
                storage.swapAt(currentIndex, parent)
            }
            currentIndex = parent
        }
    }
    
    func parentIndex(_ childIndex: Index) -> Index? {
        if childIndex == 0 { return nil }
        return (childIndex-1)/2
    }
    
    func leftChildIndex(_ parentIndex: Index) -> Index? {
        let target = parentIndex*2+1
        return target < count ? target : nil
    }
    
    func rightChildIndex(_ parentIndex: Index) -> Index? {
        let target = parentIndex*2+2
        return target < count ? target : nil
    }
    
    mutating func remove(_ index: Index) -> Element? {
        guard index < count else { return nil }
        if index == count-1 {
            return storage.popLast()
        }
        
        storage.swapAt(index, count-1)
        
        // REMARK-: Heapify after removed or cause the heap be invalidated by execution order
        let last = storage.popLast()
        heapifyDown(index)
        heapifyUp(index)
        return last
    }
    
    mutating func insert(_ index: Index, _ element: Element) {
        if index >= count {
            storage.append(element)
            heapifyUp(count-1)
            return
        }
        
        storage.insert(element, at: index)
        // TODO: Need clarify, is it execution order matter?
        // Ans: no order matter
        heapifyUp(index)
        heapifyDown(index)
    }
    
    
    func indexFirst(_ element: Element, after index: Index = 0) -> Index? {
        guard index < count else { return nil }
        
        if storage[index] == element {
            return index
        }
        
        if let left = leftChildIndex(index), let find = indexFirst(element, after: left) {
            return find
        }
        
        if let right = rightChildIndex(index), let find = indexFirst(element, after: right) {
            return find
        }
        
        return nil
        
    }
}


//let origin = (1...100).map { _ in Int.random(in: 1...1000) }
let origin = [1,3,2]
var heap = Heap(origin)
heap.insert(2, 10)

var target = [Int]()
let count = heap.count
print(heap)
print(heap.indexFirst(2))

//heap.remove(0)

