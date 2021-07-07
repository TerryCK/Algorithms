/*
 Given the root of a binary tree, check whether it is a mirror of itself (i.e., symmetric around its center).

  

 Example 1:


 Input: root = [1,2,2,3,4,4,3]
 Output: true
 Example 2:


 Input: root = [1,2,2,null,3,null,3]
 Output: false
  

 Constraints:

 The number of nodes in the tree is in the range [1, 1000].
 -100 <= Node.val <= 100
  

 Follow up: Could you solve it both recursively and iteratively?
*/


//  Definition for a binary tree node.

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
    func isSymmetric(_ root: TreeNode?) -> Bool {
        isMirror(left: root?.left, right: root?.right)
    }
    
    func isMirror(left: TreeNode?, right: TreeNode?) -> Bool {
        switch (left?.val, right?.val) {
        case (nil, nil): return true
        case let (leftV?, rightV?) where leftV == rightV:
            return isMirror(left: left?.left, right: right?.right) && isMirror(left: left?.right, right: right?.left)
        default: return false
        }
    }
}


let solution = Solution()
