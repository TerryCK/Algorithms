/*
 Given a string, find the length of the longest substring without repeating characters.

 Example 1:

 Input: "abcabcbb"
 Output: 3
 Explanation: The answer is "abc", with the length of 3.
 Example 2:

 Input: "bbbbb"
 Output: 1
 Explanation: The answer is "b", with the length of 1.
 Example 3:

 Input: "pwwkew"
 Output: 3
 Explanation: The answer is "wke", with the length of 3.
              Note that the answer must be a substring, "pwke" is a subsequence and not a substring.
 */



class Solution {
    /*
     Mindset:
     using count and Set of chracter to track times of seen characters
     
     Time complex: O(n^2), space complex: O(n)
     */
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        let s = Array(s)
        var seen: Set<Character> = []
        var count = 0
        for outer in stride(from: 0, to: s.count, by: 1) {
            seen.removeAll()
            for index in stride(from: outer, through: s.count, by: 1) {
                if  index == s.count || seen.contains(s[index]) {
                    count = max(index - outer, count)
                    break
                }
                seen.insert(s[index])
            }
        }
        return count
    }
    
    /*
    Mindset:
    use indices of start and end with move index of end to iterator and insert element to Set of seen if find,
    Otherwise clear out by move index of start and calculate longest count, until index of end equal to string end.
    Time complex: O(n), space complex: O(n)
    */
    func lengthOfLongestSubstring2(_ s: String) -> Int {
        let s = Array(s)
        var start : Int = 0
        var end : Int = 0
        var seen: Set<Character> = []
        var longest: Int = 0
        
        
        while end < s.count {
            if seen.contains(s[end]) {
                seen.remove(s[start])
                start += 1
            } else {
                longest = max(longest, end - start)
                seen.insert(s[end])
                end += 1
            }
        }
        
        return max(longest, end - start)
    }
    
}

let a = "abcabcbb"
let b = "bbbbb"
let c = "pwwkew"
let d = " "
Solution().lengthOfLongestSubstring2(d)

//[a,b, c, d].map(Solution().lengthOfLongestSubstring)
