/*
 Given the root of a binary tree, return the inorder traversal of its nodes' values.

  

 Example 1:


 Input: root = [1,null,2,3]
 Output: [1,3,2]
 Example 2:

 Input: root = []
 Output: []
 Example 3:

 Input: root = [1]
 Output: [1]
 Example 4:


 Input: root = [1,2]
 Output: [2,1]
 Example 5:


 Input: root = [1,null,2]
 Output: [1,2]
  

 Constraints:

 The number of nodes in the tree is in the range [0, 100].
 -100 <= Node.val <= 100
  

 Follow up: Recursive solution is trivial, could you do it iteratively?
*/


/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */


//Definition for a binary tree node.

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



// brute

class Solution {
    // T: O(n), S: O(n) for function stack
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        guard let node = root else { return [] }
        let left = inorderTraversal(node.left)
        let right = inorderTraversal(node.right)
        return left + [node.val] + right
    }
    
    func inorderTraversal2(_ root: TreeNode?) -> [Int] {
        var stack = [TreeNode]()
        var target = [Int]()
        var current = root
        
        while !stack.isEmpty || current != nil {
            
            while let node = current {
                stack.append(node)
                current = node.left
            }
            
            let top = stack.removeLast()
            target.append(top.val)
            current = top.right
        }
        
        return target
    }
    
}


let solution = Solution()

