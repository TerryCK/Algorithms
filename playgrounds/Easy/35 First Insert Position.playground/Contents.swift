

//  The knows API is defined in the parent class VersionControl.
  
class Solution {
    func mySqrt(_ x: Int) -> Int {
        if x <= 1 { return x }
        var l = 0
        var r = x
        
        while l < r {
            let mid = l + (r - l) / 2
            
            if mid*mid == x {
                return mid
            } else if mid*mid < x {
                l = mid + 1
            } else {
                r = mid
            }
        }
        return l - 1
    }
}



Solution().mySqrt(50)
