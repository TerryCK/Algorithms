/*
 Merge two sorted linked lists and return it as a sorted list. The list should be made by splicing together the nodes of the first two lists.

  

 */
import UIKit
UIImage(named: "merge_ex1.jpg")
/*
 Example 1:

 Input: l1 = [1,2,4], l2 = [1,3,4]
 Output: [1,1,2,3,4,4]
 Example 2:

 Input: l1 = [], l2 = []
 Output: []
 Example 3:

 Input: l1 = [], l2 = [0]
 Output: [0]
  

 Constraints:

 The number of nodes in both lists is in the range [0, 50].
 -100 <= Node.val <= 100
 Both l1 and l2 are sorted in non-decreasing order.
*/

/**
 * Definition for singly-linked list.
 *
 */

public class ListNode: Equatable {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    
    convenience init(values: [Int]) {
        self.init()
        guard values.count > 0 else {
            return
        }
        
        var currentNode = self
        
        for index in 0..<values.count {
            let node = ListNode(values[index])
            currentNode.next = node
            currentNode = node as! Self
        }
        
    }
    
    public static func ==(lhs: ListNode, rhs: ListNode) -> Bool {
        var currentNode: ListNode? = lhs
        var rhsCurrent: ListNode? = rhs
        guard lhs.val == rhs.val else { return false }
    
        while case let (lhs?, rhs?) = (currentNode?.next, rhsCurrent?.next) {
            if lhs.val != rhs.val { return false }
            currentNode = lhs.next
            rhsCurrent = rhs.next
        }
        
        return true
    }
}

// T: O(m+n), S: O(1)
class Solution {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var l1 = l1, l2 = l2
        let rootNode = ListNode()
        var next = rootNode
        
        while l1 != nil || l2 != nil {
            switch (l1?.val, l2?.val) {
            case let (v1?, v2?):
                let isL1 = v1 < v2
                
                let newNode = ListNode(isL1 ? v1 : v2)
                next.next = newNode
                next = newNode
                if isL1 {
                    l1 = l1?.next
                } else {
                    l2 = l2?.next
                }
                
            case let (v1?, .none):
                let newNode = ListNode(v1)
                next.next = newNode
                next = newNode
                l1 = l1?.next
            case let (.none, v2?):
                let newNode = ListNode(v2)
                next.next = newNode
                next = newNode
                l2 = l2?.next
            case (.none, .none): break
            }
        }
        return rootNode.next
    }
}


let solution = Solution()
solution.mergeTwoLists(.init(values: [1,2,4]), .init(values: [1,3,4]))// == ListNode(values: [1,1,2,3,4,4])
var x: ListNode? = ListNode(values: [1,2,4])
while let next = x {
    print(next.val)
    x = x?.next
}
solution.mergeTwoLists(.init(values: []),  .init(values: [] ))   == ListNode(values: [])
solution.mergeTwoLists(.init(values: []), .init(values: [0]))   == ListNode(values: [0])

