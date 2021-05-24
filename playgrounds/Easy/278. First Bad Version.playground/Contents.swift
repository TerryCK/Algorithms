/*
 You are a product manager and currently leading a team to develop a new product. Unfortunately, the latest version of your product fails the quality check. Since each version is developed based on the previous version, all the versions after a bad version are also bad.

 Suppose you have n versions [1, 2, ..., n] and you want to find out the first bad one, which causes all the following ones to be bad.

 You are given an API bool isBadVersion(version) which returns whether version is bad. Implement a function to find the first bad version. You should minimize the number of calls to the API.

  

 Example 1:

 Input: n = 5, bad = 4
 Output: 4
 Explanation:
 call isBadVersion(3) -> false
 call isBadVersion(5) -> true
 call isBadVersion(4) -> true
 Then 4 is the first bad version.
 
 Example 2:

 Input: n = 1, bad = 1
 Output: 1
  

 Constraints:

 1 <= bad <= n <= 231 - 1
 */

/**
 * The knows API is defined in the parent class VersionControl.
 *     func isBadVersion(_ version: Int) -> Bool{}
 */

class VersionControl {
    var bad: Int = 0
    func isBadVersion(_ v: Int) -> Bool {
        v >= bad
    }
}
class Solution : VersionControl {
    //T: O(logb(n)), S: O(1)
    func firstBadVersion(_ n: Int) -> Int {
        var r = n, l = 0
        while l + 1 < r {
            let mid = l + (r - l) / 2
            
            if !isBadVersion(mid) {
                l = mid 
            } else {
                r = mid
            }
        }
        
        return isBadVersion(r) ? r : l
    }
    
    // T: O(n), S: O(1)
    func firstBadVersion2(_ n: Int) -> Int {
        var count = n
        
        while count >= 0 {
            if !isBadVersion(count) {
                return count + 1
            }
            count -= 1
        }
        return count
    }
}

let solution = Solution()

//solution.bad = 4
//solution.firstBadVersion(5)
solution.bad = 2
solution.firstBadVersion(3)
//solution.bad = 1
//solution.firstBadVersion(1)
