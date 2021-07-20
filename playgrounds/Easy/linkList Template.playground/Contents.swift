/*
 Given the head of a sorted linked list, delete all duplicates such that each element appears only once. Return the linked list sorted as well.

  

 Example 1:


 Input: head = [1,1,2]
 Output: [1,2]
 Example 2:


 Input: head = [1,1,2,3,3]
 Output: [1,2,3]
  

 Constraints:

 The number of nodes in the list is in the range [0, 300].
 -100 <= Node.val <= 100
 The list is guaranteed to be sorted in ascending order.
*/



// first impression the linked list is sorted, so we can use a property to store current value, when iterating, to check that value and current node's one, if different, the new linked list one will link, after finish iterating, return new one as result.

// Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}
 
// test data creation


extension Array where Element == Int {
    func linkedListFactory() -> ListNode? {
        var current: ListNode? = nil
        for element in reversed() {
            current = ListNode(element, current)
        }
        return current
    }
}

/*
let list = [1,2,3,4,5].linkedListFactory()




*/

extension ListNode {
    func listLog() -> Self {
        var current: ListNode? = self
        while let node = current {
            print(node.val)
            current = current?.next
        }
        return self
    }
    
    func deleteDuplicates(_ head: ListNode? = nil) -> ListNode? {
        print("delete")
        return Solution().deleteDuplicates(self)
    }
}


class Solution {
    
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        
        let target: ListNode? = ListNode(.max)
        var targetCurrentNode : ListNode? = target
        
        var currentNode = head
        while let node = currentNode {
            if node.val != targetCurrentNode?.val {
                targetCurrentNode?.next = ListNode(node.val)
                targetCurrentNode = targetCurrentNode?.next
            }
            
            currentNode = node.next
        }
        return target?.next
    }
}


[1,1,2]
    .linkedListFactory()?
    .listLog()
    .deleteDuplicates()?
    .listLog()

[1,1,2,3,3]
    .linkedListFactory()?
    .listLog()
    .deleteDuplicates()?
    .listLog()
