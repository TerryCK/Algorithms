/*
 https://leetcode.com/problems/find-smallest-letter-greater-than-target/
 Given a characters array letters that is sorted in non-decreasing order and a character target, return the smallest character in the array that is larger than target.

 Note that the letters wrap around.

 For example, if target == 'z' and letters == ['a', 'b'], the answer is 'a'.
  

 Example 1:

 Input: letters = ["c","f","j"], target = "a"
 Output: "c"
 Example 2:

 Input: letters = ["c","f","j"], target = "c"
 Output: "f"
 Example 3:

 Input: letters = ["c","f","j"], target = "d"
 Output: "f"
 Example 4:

 Input: letters = ["c","f","j"], target = "g"
 Output: "j"
 Example 5:

 Input: letters = ["c","f","j"], target = "j"
 Output: "c"
  

 Constraints:

 2 <= letters.length <= 104
 letters[i] is a lowercase English letter.
 letters is sorted in non-decreasing order.
 letters contains at least two different characters.
 target is a lowercase English letter.
 */

// result is  n , where  n < target, but need smallest in the array

class Solution {
    func nextGreatestLetter(_ letters: [Character], _ target: Character) -> Character {
        if !(letters.first!...letters.last!).contains(target) {
            return letters.first!
        }
        var lower = 0
        var upper = letters.count - 1
        while lower < upper {
            let mid = lower + (upper - lower) / 2
            if letters[mid] == target {
                return letters[mid-1]
            } else if letters[mid] < target {
                lower = mid + 1
            } else {
                upper = mid
            }
        }
        return letters[lower]
    }
}
Solution().nextGreatestLetter(["c","f","j"], "j")
