/*
 Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.

 You may assume that each input would have exactly one solution, and you may not use the same element twice.

 You can return the answer in any order.

  

 Example 1:

 Input: nums = [2,7,11,15], target = 9
 Output: [0,1]
 Output: Because nums[0] + nums[1] == 9, we return [0, 1].
 Example 2:

 Input: nums = [3,2,4], target = 6
 Output: [1,2]
 Example 3:

 Input: nums = [3,3], target = 6
 Output: [0,1]
  

 Constraints:

 2 <= nums.length <= 104
 -109 <= nums[i] <= 109
 -109 <= target <= 109
 Only one valid answer exists.

*/


class Solution {
    func twoSum0(_ nums: [Int], _ target: Int) -> [Int] {
        var temp = [Int: Int]()
        temp[0] = nums.first
        for index in 1..<nums.count {
            for (key, value) in temp {
                if value + nums[index] == target {
                    return [key, index]
                } else {
                    temp[index] = nums[index]
                }
            }
            
        }
        return []
    }
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var temp = [Int: Int]()
        for index in 0..<nums.count {
            
            let value = nums[index]
            
            if let key = temp[value] {
                return [key, index]
            }
            temp[target - value] = index
            
        }
        return []
    }
}



let solution = Solution()
solution.twoSum([2,7,11,15], 9) == [0, 1]

solution.twoSum([3,2,4], 6) == [1, 2]

solution.twoSum([3,2,3], 6) == [0, 2]
