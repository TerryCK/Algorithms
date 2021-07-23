


class Solution {
    
    func findPeakElement(_ nums: [Int]) -> Int {
        var l = 0
        var r = nums.count - 1
        while l < r {
            let mid = l + (r - l) / 2
            if nums[mid] > nums[mid+1] {
                r = mid
            } else {
                l = mid + 1
            }
        }
    
        return l
    }
}


let target = [10, 1,3,5,7,8, 9]
let index = Solution().findPeakElement(target)
target.max() == target[index]
