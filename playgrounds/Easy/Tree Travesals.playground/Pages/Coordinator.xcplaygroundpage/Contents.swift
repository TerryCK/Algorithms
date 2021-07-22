/*
 https://leetcode.com/problems/binary-tree-postorder-traversal/
 Given the root of a binary tree, return the postorder traversal of its nodes' values.
 Follow up: Recursive solution is trivial, could you do it iteratively?
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
 // Thought: tree's traversal basically with recursion which will travel all leaves and the order decided by visited node order, stop recurring when node is nil


class Solution {
    
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        return [root.val] + postorderTraversal(root.left) + postorderTraversal(root.right)
    }
    
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        return  postorderTraversal(root.left) + [root.val] + postorderTraversal(root.right)
    }
    
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        return postorderTraversal(root.left) + postorderTraversal(root.right) + [root.val]
    }
    
    func preorderTraversalIterative(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        var stack = [root]
        var target = [Int]()
        
        while let node = stack.popLast() {
            node.left.map { stack.append($0) }
            node.right.map { stack.append($0) }
            target.append(node.val)
        }
        return target
    }
    
    
    func inorderTraversalIterative(_ root: TreeNode?) -> [Int] {
        
        var stack = [TreeNode]()
        var target = [Int]()
        var current = root
        while !stack.isEmpty || current != nil  {
            while let node = current {
                stack.append(node)
                current = node.left
            }
            
            if let node = stack.popLast() {
                target.append(node.val)
                current = node.right
            }
        }
        
        
        return target
    }
    
    
    func postorderTraversalIterative(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        var stack = [root]
        var target = [Int]()
        
        while let node = stack.popLast() {
            node.left.map { stack.append($0) }
            node.right.map { stack.append($0) }
            target.append(node.val)
        }
        
        
        return Array(target.reversed())
    }
    
}

let root = TreeNode(1)
root.left = TreeNode(4)
root.right = TreeNode(2)
root.left?.right = TreeNode(3)



let solution = Solution()
solution.postorderTraversalA(root)
solution.postorderTraversal(root)

