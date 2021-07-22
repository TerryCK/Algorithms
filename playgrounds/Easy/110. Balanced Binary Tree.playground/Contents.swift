/*
 Given a binary tree, determine if it is height-balanced.

 For this problem, a height-balanced binary tree is defined as:

 a binary tree in which the left and right subtrees of every node differ in height by no more than 1.

  

 Example 1:


 Input: root = [3,9,20,null,null,15,7]
 Output: true
 Example 2:


 Input: root = [1,2,2,3,3,null,null,4,4]
 Output: false
 Example 3:

 Input: root = []
 Output: true
  

 Constraints:

 The number of nodes in the tree is in the range [0, 5000].
 -104 <= Node.val <= 104
 */

// Definition for a binary tree node.
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}
class Solution {
    // O(m)
    func isBalanced(_ root: TreeNode?) -> Bool {
        guard let root = root else { return true }
        countB += 1
        return abs(maxHeight(root.left) - maxHeight(root.right)) <= 1 && isBalanced(root.left) && isBalanced(root.right)
    }
    
//    O(n)
    var countMax = 0
    var countB = 0
    
    func maxHeight(_ root: TreeNode?) -> Int {
        guard let node = root else { return 0 }
        countMax += 1
        return max(maxHeight(node.left), maxHeight(node.right)) + 1
    }
    
    
    
    
    
    
    func _isBalanced(_ root: TreeNode?) -> Bool {
        _maxHeight(root) != -1
        
    }
    
    
    func _maxHeight(_ root: TreeNode?) -> Int {
        guard let node = root else { return 0 }
        let left = _maxHeight(node.left)
        if left == -1 {
            return -1
        }
        let right = _maxHeight(node.right)
        if right == -1 {
            return -1
        }
        
        if abs(left - right) > 1 {
            return -1
        }
        
        return max(left, right) + 1
    }
    
    
    
}


let root = TreeNode(1)
root.left = TreeNode(4)
root.right = TreeNode(2)
root.left?.right = TreeNode(3)
root.left?.left = TreeNode(3)
let solution = Solution()
solution.isBalanced(root)

solution.countB
solution.countMax
