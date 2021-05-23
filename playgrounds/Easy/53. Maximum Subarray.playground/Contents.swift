/*
 Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.

  

 Example 1:

 Input: nums = [-2,1,-3,4,-1,2,1,-5,4]
 Output: 6
 Explanation: [4,-1,2,1] has the largest sum = 6.
 Example 2:

 Input: nums = [1]
 Output: 1
 Example 3:

 Input: nums = [5,4,-1,7,8]
 Output: 23
  

 Constraints:

 1 <= nums.length <= 3 * 104
 -105 <= nums[i] <= 105
  

 Follow up: If you have figured out the O(n) solution, try coding another solution using the divide and conquer approach, which is more subtle.
*/

// T: O(log n)
class Solution {
    func maxSubArray2(_ nums: [Int]) -> Int {
        
        var currentMax = 0
        let count = nums.count
        
        for index in 0..<count {
            var foreMax = 0
            for foreIndex in 0..<index {
                foreMax = nums[foreIndex] + foreMax
            }
            var afterMax = 0
            for afterIndex in index..<count {
                afterMax = nums[afterIndex] + afterMax
            }
            currentMax = max(max(foreMax, afterMax), currentMax)
        }
        return currentMax
    }
    
    func maxSubArray(_ nums: [Int]) -> Int {
        
        var currentMax = Int.min
        var sum = 0
        for index in 0..<nums.count {
         sum += nums[index]
            sum = max(sum, nums[index])
            currentMax = max(sum, currentMax)
        }
        return currentMax
    }
}

let solution = Solution()
solution.maxSubArray([-2,1,-3,4,-1,2,1,-5,4]) //== 6
solution.maxSubArray([1]) == 1
solution.maxSubArray([5,4,-1,7,8]) == 23
