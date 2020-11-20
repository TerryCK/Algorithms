
### Implement Queue using Stacks

Implement the following operations of a queue using stacks.

* __push(x)__ -- Push element x to the back of queue.
* __pop()__ -- Removes the element from in front of queue.
* __peek()__ -- Get the front element.
* __empty()__ -- Return whether the queue is empty.

__Example:__
```
MyQueue queue = new MyQueue();

queue.push(1);
queue.push(2);  
queue.peek();  // returns 1
queue.pop();   // returns 1
queue.empty(); // returns false
```

__Notes:__
* You must use only standard operations of a stack -- which means only `push to top`,  `peek/pop from top`, `size`, and `is empty` operations are valid.
* Depending on your language, stack may not be supported natively. You may simulate a stack by using a list or deque (double-ended queue), as long as you use only standard operations of a stack.
* You may assume that all operations are valid (for example, no pop or peek operations will be called on an empty queue).

### Solution
```Swift
/*
 ### Implement Queue using Stacks
 
 Implement the following operations of a queue using stacks.
 
 * __push(x)__ -- Push element x to the back of queue.
 * __pop()__ -- Removes the element from in front of queue.
 * __peek()__ -- Get the front element.
 * __empty()__ -- Return whether the queue is empty.
 
 __Example:__
 ```
 MyQueue queue = new MyQueue();
 
 queue.push(1);
 queue.push(2);
 queue.peek();  // returns 1
 queue.pop();   // returns 1
 queue.empty(); // returns false
 ```
 
 __Notes:__
 * You must use only standard operations of a stack -- which means only `push to top`,  `peek/pop from top`, `size`, and `is empty` operations are valid.
 * Depending on your language, stack may not be supported natively. You may simulate a stack by using a list or deque (double-ended queue), as long as you use only standard operations of a stack.
 * You may assume that all operations are valid (for example, no pop or peek operations will be called on an empty queue).
 */

struct Stack<Element> {
    private var storage = Array<Element>()
    
    mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    mutating func pop() -> Element? {
        storage.popLast()
    }
    
    var isEmpty: Bool {
        storage.isEmpty
    }
    
    var top: Element? {
        storage.last
    }
    
    var size: Int {
        storage.count
    }
}



struct Queue<Element> {
    private var storage = Stack<Element>()
    // O(1)
    var peek: Element? {
        storage.top
    }
    // O(1)
    mutating func dequeue() -> Element? {
        storage.pop()
    }
    // O(1)
    var isEmpty: Bool {
        peek == nil
    }
    
    // Space O(n), Time: O(n + n)
    mutating func enqueue(_ element: Element) {
        var stack = Stack<Element>()
        while let pop = storage.pop() {
            stack.push(pop)
        }
        stack.push(element)
        
        while let pop = stack.pop() {
            storage.push(pop)
        }
    }
}

var queue = Queue<Int>()

queue.enqueue(1) // 1
queue.peek 		// 1
queue.enqueue(2) 
queue.peek 	   // 1
queue.dequeue() // 1
queue.dequeue() // 2

/**
 * Your MyQueue object will be instantiated and called as such:
 * let obj = MyQueue()
 * obj.push(x)
 * let ret_2: Int = obj.pop()
 * let ret_3: Int = obj.peek()
 * let ret_4: Bool = obj.empty()
 */
```