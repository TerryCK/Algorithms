/*
 Given two sorted arrays nums1 and nums2 of size m and n respectively, return the median of the two sorted arrays.

 The overall run time complexity should be O(log (m+n)).

  

 Example 1:

 Input: nums1 = [1,3], nums2 = [2]
 Output: 2.00000
 Explanation: merged array = [1,2,3] and median is 2.
 Example 2:

 Input: nums1 = [1,2], nums2 = [3,4]
 Output: 2.50000
 Explanation: merged array = [1,2,3,4] and median is (2 + 3) / 2 = 2.5.
 Example 3:

 Input: nums1 = [0,0], nums2 = [0,0]
 Output: 0.00000
 Example 4:

 Input: nums1 = [], nums2 = [1]
 Output: 1.00000
 Example 5:

 Input: nums1 = [2], nums2 = []
 Output: 2.00000
  
 Constraints:

 nums1.length == m
 nums2.length == n
 0 <= m <= 1000
 0 <= n <= 1000
 1 <= m + n <= 2000
 -106 <= nums1[i], nums2[i] <= 106
*/


class Solution {
    
    // credit https://zxi.mytechroad.com/blog/algorithms/binary-search/leetcode-4-median-of-two-sorted-arrays/
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let n1 = nums1.count, n2 = nums2.count
        if n1 > n2 {
            return findMedianSortedArrays(nums2, nums1)
        }
        let k = (n1 + n2 + 1) / 2
        var l = 0, r = n1
        
        while l < r {
         let m1 = l + (r - l)/2
         let m2 = k - m1
            if nums1[m1] < nums2[m2 - 1] {
                l = m1 + 1
            } else {
                r = m1
            }
        }
        
        let m1 = l
        let m2 = k - l
        
        let c1 = max(m1 <= 0 ? .min : nums1[m1 - 1], m2 <= 0 ? .min : nums2[m2-1])
        
        if (n1 + n2) % 2 == 1 {
            return Double(c1)
        }
        
        let c2 = min(m1 >= n1 ? .max : nums1[m1], m2 >= n2 ? .max : nums2[m2])
        
        return Double(c1 + c2) / 2
        
    }
    
    
    // T: O(n+m)
    func findMedianSortedArrays2(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let targetArrayCount = nums1.count + nums2.count
        var merged = [Int]()
        merged.reserveCapacity(targetArrayCount)
        var pointer1 = 0, pointer2 = 0
        while pointer1 < nums1.count || pointer2 < nums2.count {
            
            if pointer2 >= nums2.count {
                merged.append(contentsOf: Array(nums1[pointer1..<nums1.count]))
                break
            }
            
            if pointer1 >= nums1.count {
                merged.append(contentsOf: Array(nums2[pointer2..<nums2.count]))
                break
            }
            if nums2[pointer2] < nums1[pointer1] {
                merged.append(nums2[pointer2])
                pointer2 += 1
            } else {
                merged.append(nums1[pointer1])
                pointer1 += 1
            }
        }
        
        let middle = targetArrayCount/2
        
        if targetArrayCount % 2 != 0 {
            return Double(merged[middle])
        } else {
            return Double((merged[middle] + merged[middle - 1])) / 2
        }
    }
    
}



let solution = Solution()
solution.findMedianSortedArrays([1,3], [2]) == 2
solution.findMedianSortedArrays([1,2], [3,4]) == 2.5
solution.findMedianSortedArrays([0,0], [0,0]) == 0
solution.findMedianSortedArrays([], [1]) == 1
solution.findMedianSortedArrays([2], []) == 2
