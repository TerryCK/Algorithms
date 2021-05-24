/*
 Given a positive integer num, write a function which returns True if num is a perfect square else False.

 Follow up: Do not use any built-in library function such as sqrt.


 Example 1:

 Input: num = 16
 Output: true
 Example 2:

 Input: num = 14
 Output: false
  

 Constraints:

 1 <= num <= 2^31 - 1

 */

class Solution {
    func isPerfectSquare(_ num: Int) -> Bool {
        var r = num, l = 0
        
        while l + 1 < r {
            let mid = l + (r - l) / 2
            switch mid * mid {
            case num: return true
            case let value where value > num:
                r = mid
            case let value where value < num:
                l = mid
            default:
                fatalError("never execute")
            }
        }
        
        return l * l == num || r * r == num
    }
}

let solution = Solution()
solution.isPerfectSquare(16) == true
solution.isPerfectSquare(8) == false
solution.isPerfectSquare(512*512) == true
solution.isPerfectSquare(121) == true
solution.isPerfectSquare(256*256) == true
