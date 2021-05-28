/*
 Given an integer n, return true if it is a power of two. Otherwise, return false.

 An integer n is a power of two, if there exists an integer x such that n == 2x.

  

 Example 1:

 Input: n = 1
 Output: true
 Explanation: 2^0 = 1
 Example 2:

 Input: n = 16
 Output: true
 Explanation: 2^4 = 16
 Example 3:

 Input: n = 3
 Output: false
 Example 4:

 Input: n = 4
 Output: true
 Example 5:

 Input: n = 5
 Output: false
  

 Constraints:

 -231 <= n <= 231 - 1
  

 Follow up: Could you solve it without loops/recursion?
 */

// brute

class Solution {
    func isPowerOfTwo(_ n: Int) -> Bool {
        n > 0 && (n & (n-1)) == 0
    }
}

let solution = Solution()
solution.isPowerOfTwo(16)

