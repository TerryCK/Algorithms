import Foundation

var str = ["234", "123",  "234", "234", "234", "2321", "123141"]

var stra = str.joined(separator: " ") + " "

class Test {
    
    
    // Time: O(n), Space: O(m) which m is result memory size
    static func solution(str: String) -> [Int] {
        guard !str.isEmpty else { return [] }
        
        // Pre-handle inputs
        let chars = str.last == Character(" ") ? Array(str.dropLast()) : Array(str)
        
        var result: [Int] = []
        
        // allocated memory layout for array with str size.
        result.reserveCapacity(str.count)
        
        var temp = ""
        
        for char in chars {
            if char != Character(" ") {
                temp.append(char)
            }
            else {
                result.append(Int(temp)!)
                temp.removeAll()
            }
        }
        // Post-handle
        result.append(Int(temp)!)
        return result
    }

    // Time: O(n), Space: O(1)
    static func majorElement(str: [String]) -> String {
        guard !str.isEmpty else { return "" }
        var result: String = ""
        var count: Int = 0
        
        for element in str {
            count = (element == result ? (+) : (-))(count, 1)
            
            if count < 0 {
                result = element
                count = 0
            }
        }
        
        return result
    }
}

let target = Test.majorElement(str: str)

let string = Test.solution(str: stra)

class Node {
    let value: Int
    var next: Node?
    init(value: Int, next: Node?) {
        self.value = value
        self.next = next
    }
    // v = 3 index, 1
    
    // Time: O(n), Space: O(1)
    func addFirst(value: Int, index: Int) -> Node {
        
        // This edge case when add value in the first, which mean head node should be changed to the new one
        guard index != 0 else {
            let newNode = Node(value: value, next: self)
            return newNode
        }
        
        var currentIndex = 0
        var current: Node? = self
        
        while let next = current {
            currentIndex += 1
            
            if currentIndex == index {
                let newNode = Node(value: value, next: next.next)
                next.next = newNode
                return self
            }
            
            current = next.next
        }
        
        // This is Edge case for index will out of whole list bounds, will throw a exception by message
        fatalError("index out of bounds, index should be smaller than or equal \(currentIndex)")
    }
    
    
}


extension Node {
    static func log(head: Node?) {
        var current = new
        while let next = current {
            print(next.value)
            current = current?.next
        }
    }
}
// linkedList data generator
extension Array where Element == Int {
    func linkList() -> Node? {
        guard !isEmpty else { return nil }
        var head: Node?
        for element in reversed() {
            let node = Node(value: element, next: head)
            head = node
        }
        
        return head
    }
}

let head = Array((1...10)).linkList()
let new = head?.addFirst(value: 50, index: 10)

Node.log(head: new)


//測資設計
// fail reason
// edge











//Test.majorElement(str: str)
// 轉換架構
// edge case
// 基本字串處理
// major element N,



