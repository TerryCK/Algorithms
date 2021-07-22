/*
 Given the root of a binary tree, return the level order traversal of its nodes' values. (i.e., from left to right, level by level).

  

 Example 1:


 Input: root = [3,9,20,null,null,15,7]
 Output: [[3],[9,20],[15,7]]
 Example 2:

 Input: root = [1]
 Output: [[1]]
 Example 3:

 Input: root = []
 Output: []
  

 Constraints:

 The number of nodes in the tree is in the range [0, 2000].
 -1000 <= Node.val <= 1000

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
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else { return [] }
        var queue = [root]
        var currentIndex = 0
        var target = [[Int]]()
        
        while currentIndex < queue.count {
            
            
            var levelTarget = [Int]()
            
            let size = queue.count - currentIndex
            
            for _ in 0..<size {
                defer { currentIndex += 1 }
                let node = queue[currentIndex]
                if node.val != .max {
                    queue.append(node.left  ?? TreeNode(.max) )
                    queue.append(node.right ?? TreeNode(.max) )
                    levelTarget.append(node.val)
                }
            }

            
            if !levelTarget.isEmpty {
                target.append(levelTarget)
            }
            
        }
        return Array(target.reversed())
    }
}

let root = TreeNode(1)
root.left = TreeNode(4)
root.right = TreeNode(2)
root.left?.right = TreeNode(3)


Solution().levelOrder(root)
