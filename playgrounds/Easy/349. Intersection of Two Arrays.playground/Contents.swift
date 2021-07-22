

//  The knows API is defined in the parent class VersionControl.
  
class Solution {
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        Array(Set(nums1).intersection(nums2))
    }
    
    
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var set = Set<Int>()
        let countA = nums1.count
        let countB = nums2.count
        let iterating = countA > countB ? nums2 : nums1
        let numberB = Set(countA > countB ? nums1 : nums2)
        for element in iterating where numberB.contains(element) {
            set.insert(element)
        }
       
        return Array(set)
    }
}



