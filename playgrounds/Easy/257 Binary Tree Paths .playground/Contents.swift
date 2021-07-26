
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
    private func dfs(node: TreeNode?, currentPath: String = "", result: inout [String]) {
        guard let node = node else { return }
        let path = currentPath + "->" + String(node.val)
        if node.left == nil , node.right == nil {
            result.append(path)
            return
        }
        dfs(node: node.left, currentPath: path, result: &result)
        dfs(node: node.right, currentPath: path, result: &result)
    }
    

    func binaryTreePaths(_ root: TreeNode?) -> [String] {
        guard let root = root else { return [] }
        var result = [String]()
        let currentPath = "\(root.val)"
        dfs(node: root.left, currentPath: currentPath, result: &result)
        dfs(node: root.right, currentPath: currentPath, result: &result)
        return result.isEmpty ?  ["\(root.val)"] : result
    }
}


