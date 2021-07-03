/*
 Given head which is a reference node to a singly-linked list. The value of each node in the linked list is either 0 or 1. The linked list holds the binary representation of a number.

 Return the decimal value of the number in the linked list.

  

 Example 1:


 Input: head = [1,0,1]
 Output: 5
 Explanation: (101) in base 2 = (5) in base 10
 Example 2:

 Input: head = [0]
 Output: 0
 Example 3:

 Input: head = [1]
 Output: 1
 Example 4:

 Input: head = [1,0,0,1,0,0,1,1,1,0,0,0,0,0,0]
 Output: 18880
 Example 5:

 Input: head = [0,0]
 Output: 0
  

 Constraints:

 The Linked List is not empty.
 Number of nodes will not exceed 30.
 Each node's value is either 0 or 1.

// brute
*/

// T: O(1)



// Definition for singly-linked list.
  public class ListNode {
      public var val: Int
      public var next: ListNode?
      public init() { self.val = 0; self.next = nil; }
      public init(_ val: Int) { self.val = val; self.next = nil; }
      public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
  }
 
class Solution {
    
    func getDecimalValue(_ head: ListNode?) -> Int {
        
        var currentBase = 1
        var result = 0 //head?.val ?? 0
        var currentNode = head
        var array: [Int] = [head?.val ?? 0]
        
        while let node = currentNode?.next {
            array.append(node.val)
            currentNode = node
        }
        
        for index in 0..<array.count {
            let value = array[array.count-index-1]*currentBase
            result += value
            print(index, currentBase,  array[array.count-index-1], value, result)
            currentBase *= 2
        }
        
        return result
    }
}
extension Array where Element == Int {
    func list() -> ListNode? {
        let head = ListNode(0)
        var currentNode = head
        for index in 0..<count {
            let node = ListNode(self[index], currentNode)
            currentNode.next = node
            currentNode = node
        }
        currentNode.next = nil
        return head.next
    }
}
let listNode2 = [1,0,0,1,0,0,1,1,1,0,0,0,0,0,0].list()
let listNode = [1,0,1].list()

let solution = Solution()

solution.getDecimalValue(listNode)
