import UIKit
/*
 Given an array of integers, return indices of the two numbers such that they add up to a specific target.

 You may assume that each input would have exactly one solution, and you may not use the same element twice.

 Example:

 Given nums = [2, 7, 11, 15], target = 9,

 Because nums[0] + nums[1] = 2 + 7 = 9,
 return [0, 1]
 */


class Solution {

    /*
     Mindset
     
     Using dictionary as temp with key for element of numbs and value for index of numbs
     if find the diffential between target and current value, return dictionary value and current index, otherwise store to dictionary with current value as key, and index as value of dictionary.
     */
     
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dic = [Int: Int]()
        for (index, val) in nums.enumerated() {
            if let match = dic[target-val] {
                return [index, match]
            }
            dic[val] = index
        }
        return []
    }
}
Solution().twoSum([2, 7, 11, 15], 9)
