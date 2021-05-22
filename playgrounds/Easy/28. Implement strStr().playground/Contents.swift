/*
 Implement strStr().

 Return the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.

 Clarification:

 What should we return when needle is an empty string? This is a great question to ask during an interview.

 For the purpose of this problem, we will return 0 when needle is an empty string. This is consistent to C's strstr() and Java's indexOf().

  

 Example 1:

 Input: haystack = "hello", needle = "ll"
 Output: 2
 Example 2:

 Input: haystack = "aaaaa", needle = "bba"
 Output: -1
 Example 3:

 Input: haystack = "", needle = ""
 Output: 0
  

 Constraints:

 0 <= haystack.length, needle.length <= 5 * 104
 haystack and needle consist of only lower-case English characters.
*/

// T: O(n^2), S: O(1)
class Solution {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        guard !needle.isEmpty else { return 0 }
        guard needle.count <= haystack.count else { return -1 }
        let haystack = Array(haystack)
        let needle = Array(needle)
        let hayStackCount = haystack.count
        var targetIndex = -1
        for index in 0..<hayStackCount where haystack[index] == needle.first  {
            for needleIndex in 0..<needle.count  {
                guard index+needleIndex < hayStackCount  else {
                    return -1
                }
                if haystack[index+needleIndex] != needle[needleIndex]  {
                    targetIndex = -1
                    break
                } else {
                    targetIndex = index
                }
            }
            if targetIndex != -1 {
                return targetIndex
            }
        }
        return -1
    }
}

let solution = Solution()
//solution.strStr("hello", "ll") == 2
//solution.strStr("aaaaa", "bba") == -1
//solution.strStr("", "") == 0
//solution.strStr("a", "a") == 0
//solution.strStr("a", "aaa") == 0
//
//solution.strStr("aaa", "aaaa") == -1


solution.strStr("mississippi", "issipi") // == -1
