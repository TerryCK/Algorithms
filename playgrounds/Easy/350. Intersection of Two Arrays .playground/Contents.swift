

//  The knows API is defined in the parent class VersionControl.
  
class Solution {
    
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var hashTable = [Int : Int]()
        var result = [Int]()
        for element in nums1 {
            hashTable[element, default: 0] += 1
        }
        
        for element in nums2 where hashTable[element, default: 0] > 0 {
            result.append(element)
            hashTable[element]! -= 1
        }
        
        return result
    }
}



