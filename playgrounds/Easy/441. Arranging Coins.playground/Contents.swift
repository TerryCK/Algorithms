/*
 You have n coins and you want to build a staircase with these coins. The staircase consists of k rows where the ith row has exactly i coins. The last row of the staircase may be incomplete.
 
 Given the integer n, return the number of complete rows of the staircase you will build.
 
 
 */
import UIKit
UIImage(named: "arrangecoins1-grid.jpg")

/*
 Example 1:
 
 
 Input: n = 5
 Output: 2
 Explanation: Because the 3rd row is incomplete, we return 2.
 */

UIImage(named: "b.jpg")

/*
 Example 2:
 
 
 Input: n = 8
 Output: 3
 Explanation: Because the 4th row is incomplete, we return 3.
 
 
 Constraints:
 
 1 <= n <= 231 - 1
 
 */

class Solution {
    func arrangeCoins(_ n: Int) -> Int {
        var r = n, l = 0
        
        while l < r {
            l += 1
            r = r - l
            
        }
        return l
    }
}

let solution = Solution()
solution.arrangeCoins(1) == 1
solution.arrangeCoins(5) == 2
solution.arrangeCoins(8) == 3
