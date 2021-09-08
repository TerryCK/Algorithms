import Foundation

class TreeNode {
    var value: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(_ value: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
}


// Time: O(n log n), every time will cut a half of input, it's cut down a execute time either. this is

// Space: n/2, because at first will cut a half of input to function stack til the subArray become empty.
func quickSort(_ input: [Int]) -> [Int] {
    guard !input.isEmpty else { return []}
    let pivot = input.last!
    let input = input.dropLast()
    let small = input.filter { $0 < pivot }
    let larger = input.filter { $0 > pivot }
    return quickSort(small) + [pivot] + quickSort(larger)
}

let testInput = (0...100).map { _ in Int.random(in: 0...1000)}
let sorted = quickSort(testInput)


func verifier(_ input: [Int], order: (Int,Int) -> Bool) -> Bool {
    
    guard input.count > 2 else { return true }
    let f = input[0]
    let s = input[1]
    
    return order(f, s) && verifier(Array(input[2...]), order: order)
    
    
    
}


let result = verifier(sorted, order: <)


func buildBST(_ sortedArray: [Int]) -> TreeNode? {
    guard !sortedArray.isEmpty else { return nil }
    let mid = sortedArray.count / 2
    let node = TreeNode(sortedArray[mid],
                        buildBST(Array(sortedArray[0..<mid])),
                        buildBST(Array(sortedArray[(mid+1)...]))
    )
    
    return node
}

let rootNode = buildBST(sorted)
var arrayResult: [Int] = []

func inorderTraversal(_ rootNode: TreeNode?, result: inout [Int]) {
    guard let rootNode = rootNode else {
        return
    }
    inorderTraversal(rootNode.left, result: &result)
    result.append(rootNode.value)
    inorderTraversal(rootNode.right, result: &result)
}


inorderTraversal(rootNode, result: &arrayResult)
verifier(arrayResult, order: <)



final class Heap {
    
    var order: (_ parentIndex: Int, Int) -> Bool
    var storage =  [Int]()
    
    
    init(_ values: [Int], _ order: @escaping (Int, Int) -> Bool) {
        self.order = order
        self.storage = values
        buildHeap()
    }
    
    typealias Index = Int
    
    func leftIndex(root: Index) -> Index? {
        root*2 + 1 < storage.count ?  root*2 + 1 : nil
    }
    
    func rightIndex(root: Index) -> Index? {
        root*2 + 2 < storage.count ?  root*2 + 2 : nil
    }
    
    func parent(root: Index) -> Index? {
        let rootTarget = (root - 1)/2
        return rootTarget < 0 ? nil : rootTarget
    }
    
    func shiftDown(_ node: Index) {
        var parentNode = node
        
        while true {
            var candidate = parentNode
            if let target = leftIndex(root: parentNode), !order(storage[candidate], storage[target]) {
                candidate = target
            }
            
            if let target = rightIndex(root: parentNode), !order(storage[candidate], storage[target]) {
                candidate = target
            }
            
            if parentNode == candidate { return }
            
            storage.swapAt(parentNode, candidate)
            parentNode = candidate
        }
    }
    
    func shiftUp(_ node: Index) {
        var currentNode = node
        while let parentNode = parent(root: currentNode) {
            if !order(storage[parentNode], storage[currentNode]) {
                storage.swapAt(parentNode, currentNode)
            }
            
            currentNode = parentNode
        }
    }
    
    func pop() -> Int? {
        if storage.isEmpty { return nil }
        storage.swapAt(0, storage.count-1)
        let result = storage.popLast()
        shiftDown(0)
        return result
    }
    
    
    
    func buildHeap() {
        for index in stride(from: storage.count/2, through: 0, by: -1) {
            shiftDown(index)
        }
    }
}


var arrayRandom = Array(Set((0...100).map { _ in Int.random(in: 0...100) }))

let heap = Heap(arrayRandom, <)

var heapReturns = [Int]()

while let value = heap.pop() {
    heapReturns.append(value)
}


verifier(heapReturns, order: <)
print(heapReturns)
