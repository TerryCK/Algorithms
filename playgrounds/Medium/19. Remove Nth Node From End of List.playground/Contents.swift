
// Definition for singly-linked list.
 public class ListNode {
     public var val: Int
     public var next: ListNode?
     public init() { self.val = 0; self.next = nil; }
     public init(_ val: Int) { self.val = val; self.next = nil; }
     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 }
 
class Solution {
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        var currentNode = head
        var array: [ListNode?] = []
        
        while let node = currentNode {
            array.append(node)
            currentNode = node.next
        }
        
        let removeIndex = array.count-n
        
        if removeIndex == 0 {
            return array[0]?.next
        }
        
        if removeIndex > 0 {
            array[removeIndex-1]?.next = array[removeIndex]?.next
        } else  {
            return nil
        }
        return head
        
    }
}
