class Solution {
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var temp = [Int: Int]()
        
        for i in 0..<nums.count {
            temp[nums[i], default: 0] += 1
        }
        return temp.sorted(by: { $0.value > $1.value} )[0..<k].map(\.key)
    }
}
