/*
 Given an array of integers nums which is sorted in ascending order, and an integer target, write a function to search target in nums. If target exists, then return its index. Otherwise, return -1.

 You must write an algorithm with O(log n) runtime complexity.

  

 Example 1:

 Input: nums = [-1,0,3,5,9,12], target = 9
 Output: 4
 Explanation: 9 exists in nums and its index is 4
 Example 2:

 Input: nums = [-1,0,3,5,9,12], target = 2
 Output: -1
 Explanation: 2 does not exist in nums so return -1
  

 Constraints:

 1 <= nums.length <= 104
 -9999 <= nums[i], target <= 9999
 All the integers in nums are unique.
 nums is sorted in an ascending order.

 */


class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        var l = 0, r = nums.count - 1
        while l + 1 < r {
            let mid = l + (r - l) / 2
            
            switch nums[mid] {
            case target: return mid
            case let value where value > target:
                r = mid
            case let value where value < target:
                l = mid
            default:
                fatalError()
            }
        }
        return nums[l] == target ? l : nums[r] == target ? r : -1
    }
}

let solution = Solution()
solution.search([-1,0,3,5,9,12], 9) //== 4
//solution.search([-1,0,3,5,9,12], 2) == -1
