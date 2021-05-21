/*
 Given an integer x, return true if x is palindrome integer.

 An integer is a palindrome when it reads the same backward as forward. For example, 121 is palindrome while 123 is not.

  

 Example 1:

 Input: x = 121
 Output: true
 Example 2:

 Input: x = -121
 Output: false
 Explanation: From left to right, it reads -121. From right to left, it becomes 121-. Therefore it is not a palindrome.
 Example 3:

 Input: x = 10
 Output: false
 Explanation: Reads 01 from right to left. Therefore it is not a palindrome.
 Example 4:

 Input: x = -101
 Output: false
  

 Constraints:

 -231 <= x <= 231 - 1
  

 Follow up: Could you solve it without converting the integer to a string?
*/

/*
        1 0 0   elements count: 3
 index: 0 1 2
 
        middle index = 1
        
 
        1 0   elements count: 2
 index: 0 1

 middle index =
 

 */
// T: O(n/2), S: O(1)
class Solution {
    func isPalindrome(_ x: Int) -> Bool {
        guard x >= 0 else { return false }
        let str = Array(String(x))
        let count = str.count
        let isOdd = count % 2 != 0
        let middleIndex = count/2  + (isOdd ? 0 : -1)
        
        for index in middleIndex..<count where str[index] != str[count - 1 - index] {
            return false
        }
        
        return true
    }
}


let solution = Solution()
solution.isPalindrome(121) == true

solution.isPalindrome(-121) == false

solution.isPalindrome(10) == false

solution.isPalindrome(-101) == false

solution.isPalindrome(100) == false

import Foundation

// 1 - 5
// 0001 - 0101
// input = 4   0100
// output = 4  0100
extension Comparable where Self: BinaryInteger {
    
    func clamped(range: ClosedRange<Self>) -> Self {
        let upper = range.upperBound
        let lower = range.lowerBound
        
        return self & upper
        
    }
}
