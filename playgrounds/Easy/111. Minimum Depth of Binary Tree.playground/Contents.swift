/*
 https://leetcode.com/problems/maximum-depth-of-binary-tree/

 A binary tree's maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.

  

 Example 1:


 Input: root = [3,9,20,null,null,15,7]
 Output: 3
 Example 2:

 Input: root = [1,null,2]
 Output: 2
 Example 3:

 Input: root = []
 Output: 0
 Example 4:

 Input: root = [0]
 Output: 1
  

 Constraints:

 The number of nodes in the tree is in the range [0, 104].
 -100 <= Node.val <= 100
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
// first thought

class Solution {
    func maxDepth(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        let lDeep = maxDepth(root.left)
        let rDeep = maxDepth(root.right)
        return max(lDeep, rDeep) + 1
    }
}

let solution = Solution()

