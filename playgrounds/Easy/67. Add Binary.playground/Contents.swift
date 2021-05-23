/*
 Given a non-negative integer x, compute and return the square root of x.

 Since the return type is an integer, the decimal digits are truncated, and only the integer part of the result is returned.

 Note: You are not allowed to use any built-in exponent function or operator, such as pow(x, 0.5) or x ** 0.5.

  

 Example 1:

 Input: x = 4
 Output: 2
 Example 2:

 Input: x = 8
 Output: 2
 Explanation: The square root of 8 is 2.82842..., and since the decimal part is truncated, 2 is returned.
 */

// T: O(n), S: O(n)
class Solution {
    func mySqrt(_ x: Int) -> Int {
        guard x > 0 else {
            return 0
        }
        var index = 1
        var target = 1
        while true {
            if index * index > x {
                return target
            } else {
                target = index
            }
            index += 1
        }
        return target
    }
}

let solution = Solution()
solution.mySqrt(4) == 2
solution.mySqrt(8) == 2
