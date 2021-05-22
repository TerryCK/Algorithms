/*
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

// T: O(log n)
class Solution {
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        let count = nums.count
        guard !nums.isEmpty else { return 0 }
        let threshold = 5
        if count >= 2, target < nums.first! {
            return 0
        }
        if count >= 2, target > nums.last! {
            return count
        }
        
        let linearSearch: ([Int]) -> Int = { input in
            for (index, value) in input.enumerated() where  value >= target  {
                return index
            }
            return input.count
        }
        
       
        guard count > threshold else { return linearSearch(nums) }
        
        
        var upper = count
        var lower = 0
       
        while upper > lower {
            
            let middleIndex = (upper - lower) / 2
            print(middleIndex, nums[middleIndex], lower, upper)
            switch target {
            case nums[middleIndex]: return middleIndex
                
            case _ where target < nums[middleIndex]:
                if middleIndex < threshold {
                    return lower + linearSearch(Array(nums[lower..<middleIndex]))
                } else {
                    upper = middleIndex
                }
                
            case _ where target > nums[middleIndex]:
                if middleIndex - lower < threshold {
                    return middleIndex + linearSearch(Array(nums[middleIndex..<upper]))
                } else {
                    lower = (middleIndex + upper) / 2
                }
            default:
                return 0
            }
        }
        return 0
    }
}

let solution = Solution()
solution.searchInsert([1,3,5,6], 5) == 2
solution.searchInsert([1,3,5,6], 2) == 1
solution.searchInsert([1,3,5,6], 7) == 4
solution.searchInsert([1,3,5,6], 0) == 0
solution.searchInsert([1], 0) == 0
solution.searchInsert([1], 1) == 0

solution.searchInsert([1,3], 3) == 1


solution.searchInsert([3,4,5,6,7,8], 6) == 3


solution.searchInsert([1,2,4,6,8,9,10], 10)  == 6


solution.searchInsert([1,3,4,6,7,10], 11) == 6
solution.searchInsert(Array(-5000...5000), 1309)
