



class Solution {
    
    func lengthOfLIS(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return 0 }
        var largestIncreasingSubsequence = 1
        for outside in 0..<nums.count-1 where nums[outside] < nums[outside+1] {
            var count = 0
            for inside in outside..<nums.count  {
                if nums[outside] < nums[inside] {
                    count += 1
                } else {
                    count -= 1
                }
               
            }
            largestIncreasingSubsequence = max(largestIncreasingSubsequence, count)
        }
        return largestIncreasingSubsequence
    }
}


Solution().lengthOfLIS([10,9,2,5,3,7,101,18]) // 3
Solution().lengthOfLIS([4,10,4,3,8,9]) // 3
Solution().lengthOfLIS([0,1,0,3,2,3]) // 3

