/*
 Write a function to find the longest common prefix string amongst an array of strings.

 If there is no common prefix, return an empty string "".

 Example 1:

 Input: strs = ["flower","flow","flight"]
 Output: "fl"

 Example 2:

 Input: strs = ["dog","racecar","car"]
 Output: ""
 Explanation: There is no common prefix among the input strings.
  
 Constraints:

 1 <= strs.length <= 200
 0 <= strs[i].length <= 200
 strs[i] consists of only lower-case English letters.

*/


// T: O(n^2), S: O(1)
class Solution {
    func longestCommonPrefix(_ strs: [String]) -> String {
        var minCount = Int.max
        var result = ""
        
        for element in strs {
            minCount = min(element.count, minCount)
        }
        
        let charList = strs.map(Array.init)
        
        for index in 0..<minCount {
            for innerIndex in 0..<charList.count {
                let char = charList[innerIndex][index]
                if innerIndex == 0 {
                    result.append(char)
                } else if result.last != char {
                    result.popLast()
                    return result
                }
            }
        }
        return result
    }
}


let solution = Solution()
//solution.longestCommonPrefix(["dog","racecar","car"]) == ""
solution.longestCommonPrefix(["flower","flow","flight"]) == "fl"


