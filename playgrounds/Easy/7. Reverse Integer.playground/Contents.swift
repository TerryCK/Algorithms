/*
 Given a signed 32-bit integer x, return x with its digits reversed. If reversing x causes the value to go outside the signed 32-bit integer range [-231, 231 - 1], then return 0.

 Assume the environment does not allow you to store 64-bit integers (signed or unsigned).

  

 Example 1:

 Input: x = 123
 Output: 321
 Example 2:

 Input: x = -123
 Output: -321
 Example 3:

 Input: x = 120
 Output: 21
 Example 4:

 Input: x = 0
 Output: 0
  

 Constraints:

 -231 <= x <= 231 - 1
*/


// T: O(1), S: O(1)
class Solution {
    
    func reverse(_ x: Int) -> Int {
        let neg = x < 0
        let str = String(abs(x))
        var result = Array(repeating: Character("a"), count: str.count)
        for (offset, char) in str.enumerated() {
            result[str.count-offset-1] = char
        }
        
        let target = Int(String(result)) ?? 0
        
        guard target < Int(Int32.max) else {
            return 0
        }
        return neg ? target * -1 : target
    }
}



let solution = Solution()
solution.reverse(123) == 321

solution.reverse(-123) == -321

solution.reverse(120) == 21
solution.reverse(1534236469) == 0
