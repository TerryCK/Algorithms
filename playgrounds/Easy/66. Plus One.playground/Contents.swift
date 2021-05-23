/*
 Given a non-empty array of decimal digits representing a non-negative integer, increment one to the integer.
 
 The digits are stored such that the most significant digit is at the head of the list, and each element in the array contains a single digit.
 
 You may assume the integer does not contain any leading zero, except the number 0 itself.
 
 
 
 Example 1:
 
 Input: digits = [1,2,3]
 Output: [1,2,4]
 Explanation: The array represents the integer 123.
 Example 2:
 
 Input: digits = [4,3,2,1]
 Output: [4,3,2,2]
 Explanation: The array represents the integer 4321.
 Example 3:
 
 Input: digits = [0]
 Output: [1]
 
 
 Constraints:
 
 1 <= digits.length <= 100
 0 <= digits[i] <= 9
 */

// T: O(n)


class Solution {
    func plusOne(_ digits: [Int]) -> [Int] {
        
        var digits = digits
        var carrie = 0
        var index = digits.count - 1
        
        while index >= 0 {
            let add =  index == digits.count - 1 || carrie != 0 ? 1 : 0
            let value = digits[index] + add
            
            if add == 1 {
                digits[index] = value % 10
                carrie = value < 10 ? 0 : 1
            } else if carrie == 0 {
                break
            }
            
            index -= 1
        }
        
        if carrie == 1 {
            digits.insert(1, at: 0)
        }
        
        return digits
    }
    
    
    func plusOne2(_ digits: [Int]) -> [Int] {
        if digits.count < 2 {
            let value = digits[0] + 1
            return value > 9 ? [1, 0] : [value]
        }
        
        var digits = digits
        var carrie = 0
        var index = digits.count - 1
        
        
        while index >= 0 {
            
            if index == digits.count - 1 {
                let value = digits[index] + 1
                if value < 10 {
                    digits[index] = value
                    return digits
                } else {
                    digits[index] = value % 10
                    carrie = 1
                }
            } else if carrie != 0 {
                let value = (digits[index] + 1)
                digits[index] = value % 10
                carrie = value < 10 ? 0 : 1
            } else {
                break
            }
            
            index -= 1
        }
        
        if carrie == 1 {
            digits.insert(1, at: 0)
        }
        
        return digits
        
    }
}

let solution = Solution()
solution.plusOne([1,2,3]) == [1,2,4]
solution.plusOne([4,3,2,1]) == [4,3,2,2]
solution.plusOne([0]) == [1]
solution.plusOne([9, 9]) == [1, 0, 0]
//let x = solution.plusOne([7,2,8,5,0,9,1,2,9,5,3,6,6,7,3,2,8,4,3,7,9,5,7,7,4,7,4,9,4,7,0,1,1,1,7,4,0,0,6])
//print(x)
