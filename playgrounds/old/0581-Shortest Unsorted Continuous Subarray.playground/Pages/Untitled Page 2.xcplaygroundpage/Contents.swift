/*

 ### Shortest Unsorted Continuous Subarray

 Given an integer array, you need to find one __continuous subarray__ that if you only sort this subarray in ascending order, then the whole array will be sorted in ascending order, too.

 You need to find the __shortest__ such subarray and output its length.

 __Example 1:__
 ```
 Input: [2, 6, 4, 8, 10, 9, 15]
 Output: 5
 Explanation: You need to sort [6, 4, 8, 10, 9] in ascending order to make the whole array sorted in ascending order.
 ```

 __Note:__
 1. Then length of the input array is in range `[1, 10,000]`.
 2. The input array may contain duplicates, so ascending order here means __<=__.

 */


class Solution {
    func findUnsortedSubarray(_ nums: [Int]) -> Int {
        var sorted = nums.sorted()
        var f = Int.min, e = Int.max
        
        for index in 0..<nums.count {
            let indexFromEnd = nums.count-1-index
            if nums[index] != sorted[index], f == .min {
                f = index
            }
            if nums[indexFromEnd] != sorted[indexFromEnd], e == .max {
                e = indexFromEnd
            }
            if e != .max, f != .min {
                break
            }
        }
        
        return f == e ? 0 : e-f+1
    }
}


Solution().findUnsortedSubarray([2,6,4,8,10,9,15])
