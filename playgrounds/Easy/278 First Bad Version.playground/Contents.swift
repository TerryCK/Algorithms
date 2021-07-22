

//  The knows API is defined in the parent class VersionControl.
  
class VersionControl {
    func isBadVersion(_ version: Int) -> Bool{ return version >= 5 }
}


 

class Solution : VersionControl {
    func firstBadVersion(_ n: Int) -> Int {
        var l = 0
        var r = n
        
        
        while l < r {
            let mid = l + (r - l) / 2
            // --- good | bad ---
            if !isBadVersion(mid) {
                l = mid + 1
            } else {
                r = mid
            }
        }
        return l
    }
}



Solution().firstBadVersion(6)
