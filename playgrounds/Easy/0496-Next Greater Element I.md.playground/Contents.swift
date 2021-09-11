/*
 
 ### Next Greater Element I

 You are given two arrays __(without duplicates)__ `nums1` and `nums2` where `nums1`’s elements are subset of `nums2`.</br>
 Find all the next greater numbers for `nums1`'s elements in the corresponding places of `nums2`.

 The Next Greater Number of a number x in nums1 is the first greater number to its right in `nums2`.</br>
 If it does not exist, output -1 for this number.

 __Example 1:__
 ```
 Input: nums1 = [4,1,2], nums2 = [1,3,4,2].
 Output: [-1,3,-1]
 Explanation:
     For number 4 in the first array, you cannot find the next greater number for it in the second array, so output -1.
     For number 1 in the first array, the next greater number for it in the second array is 3.
     For number 2 in the first array, there is no next greater number for it in the second array, so output -1.
 ```
 __Example 2:__
 ```
 Input: nums1 = [2,4], nums2 = [1,2,3,4].
 Output: [3,-1]
 Explanation:
     For number 2 in the first array, the next greater number for it in the second array is 3.
     For number 4 in the first array, there is no next greater number for it in the second array, so output -1.
 ```
 __Note:__
 1. All elements in `nums1` and `nums2` are unique.
 2. The length of both `nums1` and `nums2` would not exceed 1000.

 */

class Solution {
    
    static func nextGreaterElement<T: Comparable & Hashable>(_ ar1: [T], ar2: [T]) -> [T] {
        var result = Array(repeating: -1, count: ar1.count)
        
        
        for index in 0..<ar1.count {
            for indexInner in index+1..<ar2.count {
                
            }
            
        }
    }
}
