
import Foundation


class Node {
   
    
    let value: Int
    var left, right: Node?
    
    init(_ value: Int, _ left: Node? = nil, _ right: Node? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
}

extension Node : CustomStringConvertible {
    var description: String {
        "\(left?.value) <- \(value) -> \(right?.value)"
    }
}

class Algorithm {
    func reverseBinaryTree(root: Node?) {
        guard let root = root else { return }
        reverseBinaryTree(root: root.left)
        reverseBinaryTree(root: root.right)
        (root.left, root.right) = (root.right, root.left)
    }
    
    func traversal(root: Node?) {
        guard let root = root else { return }
        traversal(root: root.left)
        print(root)
        traversal(root: root.right)
    }
}


let root = Node(0)
root.left = Node(1)
root.right = Node(2)
root.left?.left = Node(3)
root.left?.right = Node(4)
print(root)
let algorithm = Algorithm()
algorithm.traversal(root: root)

algorithm.reverseBinaryTree(root: root)

print("\n after  algorithm \n")
algorithm.traversal(root: root)

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

class Solution {
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else { return nil }
        (root.left, root.right) = (invertTree(root.right), invertTree(root.left))
        return root
    }
}
