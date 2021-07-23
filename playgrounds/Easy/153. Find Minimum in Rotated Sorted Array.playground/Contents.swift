

class Solution {
    func findMin(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return .max }
        if isSorted(nums: nums) { return nums.first! }
        let mid = nums.count/2
        let find = [findMin(Array(nums[0..<mid])), findMin(Array(nums[(mid)...]))]
        return isSorted(nums: find) ? find.first! : find.last!
    }
    
    func isSorted(nums: [Int]) -> Bool {
        guard nums.count > 1 else { return true }
        return nums.first! < nums.last!
    }
}



Solution().findMin(
    [11,13,15,17])
//Solution().findMin([2,3,4,5,1]) == 1
//Solution().findMin([1,2,3,4,5]) == 1

































// given an sorted array and target, find the position for insert.
class BinarySearch {
    
    // T: O(log(n)), S: O(1)
    func searchInsertPosition(_ nums: [Int], _ target: Int) -> Int {
        // use a range for [lower,upper), which means close lower bound, and open upper bound
        var lowerIndex = 0
        var upperIndex = nums.count
        
        while lowerIndex < upperIndex {
            
            // this formula has considered out of bounds.
            
            let midIndex = lowerIndex + (upperIndex - lowerIndex) / 2
            /*
             if find target, return index,
             if target on the right side of mid, the lower bound will move to m + 1, to filter first part,
             otherwise the upper bound will move to mid, the lower bound is crucial in that considering range.
             */
            if nums[midIndex] == target {
                return midIndex
                
            } else if nums[midIndex] < target {
                lowerIndex = midIndex + 1
            } else {
                upperIndex = midIndex
            }
        }
        
        // in this template, the lower bound is designed to include considering target
        return lowerIndex
    }
}

