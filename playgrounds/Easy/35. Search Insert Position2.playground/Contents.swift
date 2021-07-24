class Solution {
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var l = 0
        var r = nums.count
        
        while l < r {
            let m = l + (r - l) / 2
            
            if nums[m] == target {
                return m
            } else if nums[m] < target {
                l = m + 1
            } else {
                r = m
            }
        }
        
        return l
    }
}
Solution().searchInsert([1,2,4,5,6,7], 4)
Solution().searchInsert([1,2,4,5,6,7], 1)
Solution().searchInsert([1,2,4,5,6,7], 7)
