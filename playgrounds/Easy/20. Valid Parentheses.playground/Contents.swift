/*
 Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

 An input string is valid if:

 Open brackets must be closed by the same type of brackets.
 Open brackets must be closed in the correct order.
  

 Example 1:

 Input: s = "()"
 Output: true
 Example 2:

 Input: s = "()[]{}"
 Output: true
 Example 3:

 Input: s = "(]"
 Output: false
 Example 4:

 Input: s = "([)]"
 Output: false
 Example 5:

 Input: s = "{[]}"
 Output: true
  

 Constraints:

 1 <= s.length <= 104
 s consists of parentheses only '()[]{}'.

*/

class Solution {
    func isValid(_ s: String) -> Bool {
        let lookup: [Character: Character] =
            ["(" : ")",
             "[" : "]",
             "{" : "}"
            ]
        var str = ""
        for char in Array(s) {
            if let match = lookup[char] {
                str.append(match)
            } else if str.last == char {
                str.popLast()
            } else {
                return false
            }
        }
        return str.isEmpty
    }
}



let solution = Solution()
solution.isValid("()") == true
solution.isValid("()[]{}") == true
solution.isValid("(]") == false
solution.isValid("([)]") == false
solution.isValid("{[]}") == true


solution.isValid("([}}])") == false
