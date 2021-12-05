struct Stack<Element> {
    private var storage = Array<Element>()
    
    
    var isEmpty: Bool { storage.isEmpty }
    var peek: Element? { storage.last }
    
    mutating func pop() -> Element? {
        storage.popLast()
    }
    
    mutating func push(_ element: Element) {
        storage.append(element)
    }
}



struct Queue<Element> {
    private var inner = Stack<Element>()
    private var outer = Stack<Element>()
    
    mutating func enqueue(_ element: Element) {
        inner.push(element)
    }
    
    mutating func dequeue() -> Element? {
        if outer.isEmpty {
            fillOuter()
        }
        
       return outer.pop()
    }
    
    mutating func peek() -> Element? {
        if outer.isEmpty {
            fillOuter()
        }
        
       return outer.peek
    }
    
    mutating func fillOuter() {
        
        
        while let pop = inner.pop() {
            outer.push(pop)
        }
    }
}


var queue = Queue<Int>()

(1...10).forEach { queue.enqueue($0) }
queue.dequeue()
queue.enqueue(20)
while let element = queue.dequeue() {
    print(element)
}
