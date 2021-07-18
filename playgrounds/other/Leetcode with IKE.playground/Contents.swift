import Foundation

var str = ["234", "123",  "234", "234", "234", "2321", "123141"]



var stra = str.joined(separator: " ") + " "

class Test {
    static func solution(str: String) -> [Int] {
        guard !str.isEmpty else { return [] }
        
        let chars = str.last == Character(" ") ? Array(str.dropLast()) : Array(str)
        var result: [Int] = []
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
        result.append(Int(temp)!)
        return result
    }

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
    func addFirst(value: Int, index: Int) {
        var count = 0
        var current: Node? = self
        var breakNode = Node(value: .min, next: nil)
        
        while let next = current?.next {
            
            count += 1
            
            
            if count == index {
                let newNode = Node(value: value, next: current?.next)
                breakNode.next = newNode
                
                break
            }
            
            breakNode = current!
            current = current?.next
        }
    }
}



//測資設計
// fail reason
// edge











//Test.majorElement(str: str)
// 轉換架構
// edge case
// 基本字串處理
// major element N,



