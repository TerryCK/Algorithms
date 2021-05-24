/*
 We are playing the Guess Game. The game is as follows:

 I pick a number from 1 to n. You have to guess which number I picked.

 Every time you guess wrong, I will tell you whether the number I picked is higher or lower than your guess.

 You call a pre-defined API int guess(int num), which returns 3 possible results:

 -1: The number I picked is lower than your guess (i.e. pick < num).
 1: The number I picked is higher than your guess (i.e. pick > num).
 0: The number I picked is equal to your guess (i.e. pick == num).
 Return the number that I picked.

  

 Example 1:

 Input: n = 10, pick = 6
 Output: 6
 Example 2:

 Input: n = 1, pick = 1
 Output: 1
 Example 3:

 Input: n = 2, pick = 1
 Output: 1
 Example 4:

 Input: n = 2, pick = 2
 Output: 2

 
 Constraints:

 1 <= n <= 231 - 1
 1 <= pick <= n
 */
/**
 * Forward declaration of guess API.
 * @param  num -> your guess number
 * @return          -1 if the picked number is lower than your guess number
 *                  1 if the picked number is higher than your guess number
 *               otherwise return 0
 * func guess(_ num: Int) -> Int
 */
class GuessGame {
    var answer: Int = 0
    
    func guess(_ num: Int) -> Int {
        min(max(num - answer, -1), 1)
        
    }
}

class Solution : GuessGame {
    
    func guessNumber(_ n: Int) -> Int {
        var l = 0, r = n
        
        while l + 1 < r {
        let mid = l + (r - l) / 2
            switch guess(mid) {
            case 0: return mid
            case -1: r = mid
            case 1:  l = mid
            default: fatalError()
            }
        }
        return guess(r) == 0 ? r : l
    }
}



let solution = Solution()
solution.answer = 6
solution.guessNumber(10) //== 6

solution.answer = 1
solution.guessNumber(1) == 1

solution.answer = 1
solution.guessNumber(2) == 1

solution.answer = 2
solution.guessNumber(2) == 2
