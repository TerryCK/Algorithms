


class Solution {
//    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
//        nums.sorted(by: >)[k]
//    }
//
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        _quickSort(nums)[k-1]
    }
    func _quickSort(_ nums: [Int]) -> [Int] {
        guard !nums.isEmpty else { return [] }
        let pivot = nums.last!
        var large = [Int]()
        large.reserveCapacity(nums.count)
        for index in 0..<nums.count - 1 where nums[index] >= pivot{
            
                large.append(nums[index])
        }
        return quickSort(large) + [pivot]
    }
    
    func quickSort(_ nums: [Int]) -> [Int] {
        guard !nums.isEmpty else { return [] }
        let pivot = nums.last!
        var small = [Int]()
        small.reserveCapacity(nums.count)
        var large = [Int]()
        large.reserveCapacity(nums.count)
        for index in 0..<nums.count - 1 {
            if nums[index] >= pivot {
                large.append(nums[index])
            } else {
                small.append(nums[index])
            }
        }
        return quickSort(large) + [pivot] + quickSort(small)
    }
}


