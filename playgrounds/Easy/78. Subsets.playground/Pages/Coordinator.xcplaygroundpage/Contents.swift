/*
 https://leetcode.com/problems/subsets/
 Given an integer array nums of unique elements, return all possible subsets (the power set).

 The solution set must not contain duplicate subsets. Return the solution in any order.

 Example 1:

 Input: nums = [1,2,3]
 Output: [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]
 Example 2:

 Input: nums = [0]
 Output: [[],[0]]
  

 Constraints:

 1 <= nums.length <= 10
 -10 <= nums[i] <= 10
 All the numbers of nums are unique.
 */

// result is  n , where  n < target, but need smallest in the array

class Solution {
    func nextGreatestLetter(_ letters: [Character], _ target: Character) -> Character {
        var lower = 0
        var upper = letters.count - 1
        
        while lower < upper - 1 {
            let mid = lower + (upper - lower) / 2
            if letters[mid] <= target {
                lower = mid
            } else {
                upper = mid
            }
        }

        
        print(target, lower, upper)
        if target < letters[lower] {
            return letters[lower]
        }
        
        if target < letters[upper] {
            return letters[upper]
        }
        
        return letters[lower]
    }
}
Solution().nextGreatestLetter(["c","f","j"], "c")
Solution().nextGreatestLetter(["c","f","j"], "d")
Solution().nextGreatestLetter(["c","f","j"], "g")
Solution().nextGreatestLetter(["c","f","j"], "j")
Solution().nextGreatestLetter(["c","f","j"], "a")
