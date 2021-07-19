/*
 Given an integer array of size n, find all elements that appear more than ⌊ n/3 ⌋ times.
 
 Follow-up: Could you solve the problem in linear time and in O(1) space?
 
 
 
 Example 1:
 
 Input: nums = [3,2,3]
 Output: [3]
 Example 2:
 
 Input: nums = [1]
 Output: [1]
 Example 3:
 
 Input: nums = [1,2]
 Output: [1,2]
 
 
 Constraints:
 
 1 <= nums.length <= 5 * 104
 -109 <= nums[i] <= 109
 
 */




class Solution {
    // T: O(n), S: O(m)
    func majorityElement2(_ nums: [Int]) -> [Int] {
        var temp = [Int: Int]()
        var result = Set<Int>()
        
        let thresholdCount = nums.count/3
        for element in nums {
            temp[element, default: 0] += 1
            
            if temp[element]! > thresholdCount {
                result.insert(element)
            }
            
        }
        return Array(result)
    }
    
    
    func majorityElement(_ nums: [Int]) -> [Int] {
        var a = Int.max, b = Int.max
        var ct1 = 0, ct2 = 0
        for element in nums {
            if element == a {
                ct1 += 1
            } else if element == b {
                ct2 += 1
            } else if ct1 == 0 {
                a = element
                ct1 = 1
            } else if ct2 == 0 {
                b = element
                ct2 = 1
            }
            else {
                ct1 -= 1
                ct2 -= 1
            }
        }
        
        ct1 = 0
        ct2 = 0
        for element in nums {
            if element == a {
                ct1 += 1
            } else if element == b {
                ct2 += 1
            }
        }
        
        let threshold = nums.count/3
        var res = [Int]()
        if ct1 > threshold {
            res.append(a)
        }
        if ct2 > threshold {
            res.append(b)
        }
        return res
    }
}

let solution = Solution()

//solution.majorityElement([1,2])
solution.majorityElement([3,2,3])
//solution.majorityElement([1,2,3])
//solution.majorityElement([3,3,4])
