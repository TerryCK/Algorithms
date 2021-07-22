

//  The knows API is defined in the parent class VersionControl.
  
class Solution {
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var l = 0
        var r = nums.count
        
        while l < r {
            let mid = l + (r - l) / 2
            if nums[mid] == target {
                return mid
            } else if nums[mid] < target {
                l = mid + 1
            } else {
                r = mid
            }
        }
        
        return l
    }
}
    
Solution().searchInsert([1,3,5,6], 5)

Solution().searchInsert([1,3,5,6], 3)
