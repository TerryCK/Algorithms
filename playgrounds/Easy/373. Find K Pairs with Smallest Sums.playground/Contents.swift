class Solution {
    func kSmallestPairs(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> [[Int]] {
        var hashmap = [(Int, Int)]()
        
        for index in 0..<nums1.count {
            for idx in 0..<nums2.count {
                hashmap.append((nums1[index], nums2[idx]))
            }
        }
        let k = min((nums2.count*nums1.count),k)
        return hashmap.sorted { $0.0 + $0.1 < $1.0 + $1.1 }[0..<k].map { [$0.0 ,$0.1] }
    }
}
