
// Double-end Node
final class Node<Element> {
    var next: Node?
    var previous: Node?
    var value: Element?
    
    init(_ value: Element?, next: Node? = nil) {
        self.next = next
        self.value = value
    }
}

final class LinkedList<Element> {

    var head: Node<Element>? = nil
    var tail: Node<Element>? = nil
    
    init(headValue: Element? = nil) {
        if let headValue = headValue {
            let head = Node(headValue)
            self.head = head
            self.tail = head
        }
    }
    
    // O(1), because there is only on pointer changing.
    func removeLast() -> Element? {
        defer { head = head?.next }
        return head?.value
    }

    // O(1), because there are no loop for iterating needed.
    func append(element: Element) {
        let newNode = Node(element)
        tail?.next = newNode
        tail = newNode
        if head == nil {
            head = newNode
        } else {
            newNode.previous = tail
        }
    }
}

struct Queue<Element> {
    
    var linkedList = LinkedList<Element>()
    
    func enqueue(_ element: Element) {
        linkedList.append(element: element)
    }
    
    func dequeue() -> Element? {
        linkedList.removeLast()
    }
}


var queue = Queue<Int>()
(1...10).forEach(queue.enqueue)

while let element = queue.dequeue() {
    print(element)
}



