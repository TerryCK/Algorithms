### Min Stack

Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.

* push(x) -- Push element x onto stack.
* pop() -- Removes the element on top of the stack.
* top() -- Get the top element.
* getMin() -- Retrieve the minimum element in the stack.

__Example:__
```
MinStack minStack = new MinStack();
minStack.push(-2);
minStack.push(0);
minStack.push(-3);
minStack.getMin();   --> Returns -3.
minStack.pop();
minStack.top();      --> Returns 0.
minStack.getMin();   --> Returns -2.
```

### Solution
```Swift
struct MinStack<T: Comparable> {
    
    struct Element<T: Comparable> {
        let value, min: T
    }
    
    private var storage = [Element<T>]()
    
    mutating func push(element: T) {
        let new: Element<T>
        if let last = storage.last, last.min < element {
            new = Element(value: element, min: last.min)
        } else {
            new = Element(value: element, min: element)
        }
        storage.append(new)
    }
    
    // O(1)
    mutating func pop() -> T? {
        storage.popLast()?.value
    }
    // O(1)
    func top() -> T? {
        storage.last?.value
    }
    
    //O(1)
    func getMin() -> T? {
        storage.last?.min
    }
}


var stack = MinStack<Int>()


stack.push(element: 5)
stack.push(element: 2)
stack.push(element: 10)

stack.pop() // 10
stack.top() // 2
stack.getMin() // 2


/**
 * Your MinStack object will be instantiated and called as such:
 * let obj = MinStack()
 * obj.push(x)
 * obj.pop()
 * let ret_3: Int = obj.top()
 * let ret_4: Int = obj.getMin()
 */
```