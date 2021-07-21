/*
 https://leetcode.com/problems/search-insert-position/
 Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.
 
 You must write an algorithm with O(log n) runtime complexity.
 
 
 
 Example 1:
 
 Input: nums = [1,3,5,6], target = 5
 Output: 2
 Example 2:
 
 Input: nums = [1,3,5,6], target = 2
 Output: 1
 Example 3:
 
 Input: nums = [1,3,5,6], target = 7
 Output: 4
 Example 4:
 
 Input: nums = [1,3,5,6], target = 0
 Output: 0
 Example 5:
 
 Input: nums = [1], target = 0
 Output: 0
 
 
 Constraints:
 
 1 <= nums.length <= 104
 -104 <= nums[i] <= 104
 nums contains distinct values sorted in ascending order.
 -104 <= target <= 104
 
 */




class Solution {
    
    //T: O(logN), S: O(1)
//    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
//        var lowerIndex = 0
//        var upperIndex = nums.count - 1
//
//        while upperIndex > lowerIndex {
//            let  middleIndex = lowerIndex + (upperIndex - lowerIndex) / 2
//            switch nums[middleIndex] {
//            case target: return middleIndex
//            case let findValue:
//                if findValue > target {
//                    upperIndex = middleIndex - 1
//                } else {
//                    lowerIndex  = middleIndex + 1
//                }
//            }
//        }
//        if nums[lowerIndex] < target {
//            return lowerIndex + 1
//        }
//        if upperIndex > 0, nums[upperIndex] < target {
//            return upperIndex + 1
//        }
//        return lowerIndex
//    }
    
    
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var lower = 0
        var upper = nums.count - 1
        
        while lower < upper {
            let mid = (upper - lower)/2 + lower
            
            switch nums[mid] {
            case target: return mid
            case _ where nums[mid] < target:
                lower = mid
            case _ where nums[mid] > target:
                upper = mid
            default:
                return 0
            }
        }
        // target --- target --- target
        
        
        if target < nums[lower] {
            return lower
        }
        if target < nums[upper] {
            return upper
        }
        return lower + 1
    }
}
class Solution2 {
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var lower = 0
        var upper = nums.count - 1
        
        while upper > lower  + 1 {
            let mid = (upper - lower)/2 + lower
            switch nums[mid] {
            case target: return mid
            case _ where nums[mid] < target:
                lower = mid + 1
            default:
                upper = mid
            }
        }
        return upper + 1
    }
}

Solution2().searchInsert([1], 1)

let solution = Solution()
//solution.searchInsert(
//    [1,3,5,6], 7) == 4
//solution.searchInsert([1,3], 2) == 1

//solution.searchInsert([1,3,5,6], 2)


solution.searchInsert([1,3], 0)
