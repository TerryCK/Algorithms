/*
 Given a string s consists of some words separated by spaces, return the length of the last word in the string. If the last word does not exist, return 0.

 A word is a maximal substring consisting of non-space characters only.

  

 Example 1:

 Input: s = "Hello World"
 Output: 5
 Example 2:

 Input: s = " "
 Output: 0
  

 Constraints:

 1 <= s.length <= 104
 s consists of only English letters and spaces ' '.
*/

// T: O(n)


class Solution {
    func lengthOfLastWord(_ s: String) -> Int {
        var maxCount = 0
        let s = Array(s)
        var sum = 0
        for index in 0..<s.count {
            sum = s[index] != " " ? sum + 1 : 0
            if sum != 0 {
                maxCount = sum
            }
            
        }
        return maxCount
    }
}

let solution = Solution()
solution.lengthOfLastWord("Hello World") == 5
solution.lengthOfLastWord(" ") == 0
solution.lengthOfLastWord("a ") == 1
