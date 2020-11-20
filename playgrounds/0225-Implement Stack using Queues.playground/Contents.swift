/*
 
 
 ### Implement Stack using Queues

 Implement the following operations of a stack using queues.

 * `push(x)` -- Push element x onto stack.
 * `pop()` -- Removes the element on top of the stack.
 * `top()` -- Get the top element.
 * `empty()` -- Return whether the stack is empty.

 __Example:__
 ```
 MyStack stack = new MyStack();

 stack.push(1);
 stack.push(2);
 stack.top();   // returns 2
 stack.pop();   // returns 2
 stack.empty(); // returns false
 ```

 __Notes:__
 * You must use *only* standard operations of a queue -- which means only `push to back`, `peek/pop from front`, `size`, and `is empty` operations are valid.
 * Depending on your language, queue may not be supported natively. You may simulate a queue by using a list or deque (double-ended queue), as long as you use only standard operations of a queue.
 * You may assume that all operations are valid (for example, no pop or top operations will be called on an empty stack).
 
 */


struct Queue<Element> {
    private var storage = Array<Element>()
    
    mutating func enqueue(_ element: Element) {
        storage.append(element)
    }
    
    mutating func dequeue() -> Element? {
        storage.removeFirst()
    }
    
    var first: Element? {
        storage.last
    }
}

struct Stack<Element> {
    
    private var storage = Queue<Element>()
    private var _top: Element?
    
//    O(1)
    mutating func push(_ element: Element) {
        storage.enqueue(element)
        _top = element
    }
    
//    Space O(n), Time O(n)
    mutating func pop() -> Element? {
        var queue = Queue<Element>()
        var top: Element?
        
        defer {
            storage = queue
            self._top = top
        }
        
        while let _ = storage.first {
            if let value = storage.dequeue() {
                top = value
                if storage.first != nil {
                    queue.enqueue(value)
                }
            }
        }
        return top
    }
    
//    O(1)
    var isEmpty: Bool {
       _top == nil
    }
    
//    O(1)
    func top() -> Element? {
        _top
    }
}



var stack = Stack<Int>()

stack.push(1)
stack.push(2)
stack.pop()
stack.pop()
stack.pop()
stack.isEmpty
