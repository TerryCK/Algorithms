/*
 Valid Parentheses
 
 Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
 
 An input string is valid if:
 
 Open brackets must be closed by the same type of brackets.
 Open brackets must be closed in the correct order.
 Note that an empty string is also considered valid.
 
 Example 1:
 
 Input: "()"
 Output: true
 Example 2:
 
 Input: "()[]{}"
 Output: true
 Example 3:
 
 Input: "(]"
 Output: false
 Example 4:
 
 Input: "([)]"
 Output: false
 Example 5:
 
 Input: "{[]}"
 Output: true
 */





class Solution {
    
    struct Stack<T> {
        private var storage = Array<T>()
        mutating func push(_ e: T) {
            storage.append(e)
        }
        
        var isEmpty: Bool {
            storage.isEmpty
        }
        
        mutating func pop() -> T? {
            storage.popLast()
        }
        func top() -> T? {
            storage.last
        }
    }
    
    // Space: O(s), Time: O(s), Brute-force
    // This version is not perfectly for "(})" as input, and output mistake result.
    static func isValid(_ s: String) -> Bool {
        let dic: [String.Element: String.Element] = ["[": "]", "{" : "}", "(": ")"]
        let ref: Set<String.Element> = ["}", "]", ")"]
        var stack = Stack<String.Element>()
        
        for char in s {
            if let char = dic[char] {
                stack.push(char)
                continue
            }
            
            if let top = stack.top(), top == char {
                stack.pop()
                continue
            }
            // Avoid not balance case like "(})" will leak
            if ref.contains(char) {
                return false
            }
        }
        return stack.isEmpty
    }
    
    
    static func isValid2(_ s: String) -> Bool {
        let paren : [Character: Character] = [")": "(", "}": "{", "]": "["]
        var stack : [Character] = []

        for char in s {
            if let curr = paren[char] {
                
                // If curr is a close parenthesis, check that the top of the stack
                // is its open counterpart, otherwise there is a mismatch - return false
                if let last = stack.last, last == curr {
                    _ = stack.removeLast()
                } else {
                    return false
                }
            } else {
                
                // If curr is an open parenthesis, push it onto the stack
                stack.append(char)
            }
        }
        
        // Parentheses are balanced only if stack is empty
        return stack.isEmpty
    }
}


Solution.isValid("(})")
Solution.isValid("()[]{}")
Solution.isValid("(]")
Solution.isValid("([)]")
Solution.isValid("{[]}")


