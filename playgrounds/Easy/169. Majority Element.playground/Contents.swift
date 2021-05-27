/*
 Given an array nums of size n, return the majority element.

 The majority element is the element that appears more than ⌊n / 2⌋ times. You may assume that the majority element always exists in the array.

  

 Example 1:

 Input: nums = [3,2,3]
 Output: 3
 Example 2:

 Input: nums = [2,2,1,1,1,2,2]
 Output: 2
  

 Constraints:

 n == nums.length
 1 <= n <= 5 * 104
 -231 <= nums[i] <= 231 - 1
  

 Follow-up: Could you solve the problem in linear time and in O(1) space?
 */

// brute
class Solution {
    // T: O(n), S: O(1)
    func majorityElement(_ nums: [Int]) -> Int {
        var majority = nums.first!
        var count = 1
        
        for n in nums {
            let op : (Int, Int) -> Int = n == majority ? (+) : (-)
            count = op(count,1)
            if count <= 0 {
                count = 1
                majority = n
            }
        }
        return majority
    }
}

let solution = Solution()
solution.majorityElement([3,2,3]) == 3
solution.majorityElement([2,2,1,1,1,2,2]) == 2
