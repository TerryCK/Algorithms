/*
 You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

 You may assume the two numbers do not contain any leading zero, except the number 0 itself.

 Example:

 Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
 Output: 7 -> 0 -> 8
 Explanation: 342 + 465 = 807.
 */



// Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var carry = 0
        let head = ListNode(0)
        var tail = head
        var l1 = l1, l2 = l2
        while (l1 != nil || l2 != nil) {
            let sum = carry + (l1?.val ?? 0) + (l2?.val ?? 0)
            let remind =  sum % 10
            carry = sum / 10
            tail.next = ListNode(remind)
            tail = tail.next!
            (l1, l2) = (l1?.next, l2?.next)
        }
        
        if carry != 0 {
            tail.next = ListNode(carry)
        }
        return head.next
    }
}

extension Array where Element == Int {
    func linkedlist() -> ListNode? {
        let head = ListNode(Int.min)
        reduce(into: head) { (acc: inout ListNode?, val: Int) in
            acc?.next = ListNode(val)
            acc = acc?.next
        }
        return head.next
    }
}

var inputA = [2,4,3].linkedlist()
var inputB = [5,6,4].linkedlist()

let inputC = [5].linkedlist()
let inputD = [9, 8].linkedlist()
let inputE = [1].linkedlist()
var result = Solution().addTwoNumbers(inputD, inputE)


while let next = result {
    print(next.val)
    result = next.next
}
