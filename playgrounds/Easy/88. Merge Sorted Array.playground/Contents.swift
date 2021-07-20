/*
 You are given two integer arrays nums1 and nums2, sorted in non-decreasing order, and two integers m and n, representing the number of elements in nums1 and nums2 respectively.

 Merge nums1 and nums2 into a single array sorted in non-decreasing order.

 The final sorted array should not be returned by the function, but instead be stored inside the array nums1. To accommodate this, nums1 has a length of m + n, where the first m elements denote the elements that should be merged, and the last n elements are set to 0 and should be ignored. nums2 has a length of n.

  

 Example 1:

 Input: nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
 Output: [1,2,2,3,5,6]
 Explanation: The arrays we are merging are [1,2,3] and [2,5,6].
 The result of the merge is [1,2,2,3,5,6] with the underlined elements coming from nums1.
 Example 2:

 Input: nums1 = [1], m = 1, nums2 = [], n = 0
 Output: [1]
 Explanation: The arrays we are merging are [1] and [].
 The result of the merge is [1].
 Example 3:

 Input: nums1 = [0], m = 0, nums2 = [1], n = 1
 Output: [1]
 Explanation: The arrays we are merging are [] and [1].
 The result of the merge is [1].
 Note that because m = 0, there are no elements in nums1. The 0 is only there to ensure the merge result can fit in nums1.
  

 Constraints:

 nums1.length == m + n
 nums2.length == n
 0 <= m, n <= 200
 1 <= m + n <= 200
 -109 <= nums1[i], nums2[j] <= 109
  

 Follow up: Can you come up with an algorithm that runs in O(m + n) time?
*/



// use two property to store status for current element

// brute, use two pointers to indicate arrays which is current element respectively, use a target array to store after marge results.
// use a optional property to bind array element when idx not reach the array bounds, else will leave an nil on that value. and if get the value from array, will be compare and store in small one in the target array and move that idx of array by add 1, until two array be iterated over.

class Solution {
    // T: O(n+m), S: n+m
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var target = [Int]()
        target.reserveCapacity(m+n)
        
        var idx1 = 0
        var idx2 = 0
        
        for _ in 0..<m+n {
            var a, b: Int?
        
            if idx1 < m {
                a = nums1[idx1]
            }
            if idx2 < n {
                b = nums2[idx2]
            }
            
            switch (a, b) {
            
            case let (a?, b?):
                    target.append( a < b ? a : b)
                
                
                if a < b {
                    idx1 += 1
                } else {
                    idx2 += 1
                }
                
            case let (a?, _):
                target.append(a)
                idx1 += 1
            case let (_, b?):
                target.append(b)
                idx2 += 1
                
            default: break
            }
            
        }
        nums1 = target
    }
}

