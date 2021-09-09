import UIKit
import Foundation


class Node<Value> {
    var value: Value
    var left, right: Node?
    init(value: Value, right: Node? = nil, left: Node? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
    
    
    static func bfs(head: Node, handler: (Value) -> Void) {
        var queue = Queue<Node>()
        handler(head.value)
        if let left = head.left {
            queue.enqeue(element: left)
        }
        if let right = head.right {
            queue.enqeue(element: right)
        }
        
        while case let node? = queue.dequeue() {
            if let left = node.left {
                queue.enqeue(element: left)
            }
            if let right = node.right {
                queue.enqeue(element: right)
            }
             handler(node.value)
        }
        
    }
    
    
    static func dfs(head: Node, hanlder: (Value) -> Void) {
        hanlder(head.value)
        if let left = head.left { dfs(head: left, hanlder: hanlder)       }
        if let right = head.right { dfs(head: right, hanlder: hanlder)     }
    }
}



struct Queue<Element> {
    var array = Array<Element>()
    
    mutating func enqeue(element: Element) {
        array.append(element)
    }
    
    mutating func dequeue() -> Element? {
        guard !array.isEmpty else { return nil }
        return array.removeFirst()
    }
    
    var isEmpty: Bool { array.isEmpty }
}
let a = Node(value: "a")
let b = Node(value: "b")
let c = Node(value: "c")
let d = Node(value: "d")
let e = Node(value: "e")
let f = Node(value: "f")
let g = Node(value: "g")
let h = Node(value: "h")


a.left = b
a.right = c

b.left = d
b.right = e
c.left = g
c.right = h


print("\n -- BFS -- \n")
Node.bfs(head: a) { print($0) }

print("\n -- DFS -- \n")
Node.dfs(head: a) { print($0) }
