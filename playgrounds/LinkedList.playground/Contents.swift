



struct LinkedList<Element> {
    class Node<Value> {
        var value: Value
        var next: Node?
        
        init(value: Value, next: Node? = nil) {
            self.value = value
            self.next = next
        }
    }
    
    
    var head: Node<Element>?
    var tail: Node<Element>?
    
    
    init() {
        
    }
    
    
    var isEmpty: Bool {
        head == nil
    }
    
    
    mutating func push(_ value: Element) {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    
    mutating func append(_ value: Element) {
        guard !isEmpty else {
            push(value)
            return
        }
        
        tail?.next = Node(value: value)
        tail = tail?.next
    }
    
    @discardableResult
    mutating func insert(_ value: Element, after index: Int) -> Node<Element> {
        guard let node = node(at: index) else {
            preconditionFailure("Can't find node at index")
        }
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    
    @discardableResult
    mutating func insert(_ value: Element, after node: Node<Element>) -> Node<Element> {
        guard node !== tail else {
            append(value)
            return tail!
        }
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    
    func node(at index: Int) -> Node<Element>? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return currentNode
    }
    
    mutating func pop() -> Element? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    
    mutating func removeLast() -> Element? {
        
        guard let head = head else {
            return nil
        }
        guard head.next != nil else {
            return pop()
        }
        
        var prev = head
        var current = head
        while let next = current.next {
            prev = current
            current = next
        }
        
        return current.next
    }
}



