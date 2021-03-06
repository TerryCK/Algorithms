
### Remove All Adjacent Duplicates In String

Given a string `S` of lowercase letters, a *duplicate removal* consists of choosing two adjacent and equal letters, and removing them.

We repeatedly make duplicate removals on S until we no longer can.

Return the final string after all such duplicate removals have been made.  It is guaranteed the answer is unique.

__Example 1:__
```
Input: "abbaca"
Output: "ca"
Explanation: 
For example, in "abbaca" we could remove "bb" since the letters are adjacent and equal, and this is the only possible move.  The result of this move is that the string is "aaca", of which only "aa" is possible, so the final string is "ca".
```

__Note:__
1. `1 <= S.length <= 20000`
2. `S` consists only of English lowercase letters.

### Solution
__O(S) Time, O(S) Space:__

```Swift
class Solution {
    func removeDuplicates(_ str: String) -> String {
        var stack = [String.Element]()
        for char in str {
            if char == stack.last {
                stack.removeLast()
            } else {
                stack.append(char)
            }
        }
        return String(stack)
    }
}
```