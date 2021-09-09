import Foundation
class Node<T> {
    var value: T
    var isVisited = false
    var neighbor: [Node] = []
    init(value: T) {
        self.value = value
    }
}


let node1 = Node(value: 10)
let node2 = Node(value: 20)
let node3 = Node(value: 30)
let node4 = Node(value: 40)
let node5 = Node(value: 50)

node1.neighbor = [node2, node3]
node3.neighbor = [node4, node5]

struct Queue<T> {
    var array = [T]()
    func dequeue() -> T? { return array.last }
    mutating func enqueue(element: T) { array.insert(element, at: 0)}
}

func traversal<T>(root: Node<T>, closurue: ((Node<T>) -> Void)?) {
    var queue = Queue<Node<T>>()
    root.isVisited = true
    closurue?(root)
    queue.enqueue(element: root)
    while let node = queue.dequeue() {
        for neighbor in node.neighbor where !neighbor.isVisited {
            neighbor.isVisited = true
            queue.enqueue(element: neighbor)
            closurue?(node)
        }
    }
}

traversal(root: node1) { (node) in
    node.value *= 2
}

traversal(root: node1) { (node) in
    print(node)
}
