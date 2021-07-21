import Foundation


class TreeNode {
    var left: TreeNode?
    var right: TreeNode?
    
    let value: Int
    
    init(value: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.left = left
        self.right = right
        self.value = value
    }
}

extension Array where Element == Int {
    func binarySearchTree() -> TreeNode? {
        guard !isEmpty else { return nil }
        
        let middle = count / 2
        let root = TreeNode(value: self[middle])
         root.left = Array(self[0..<middle]).binarySearchTree()
         root.right = Array(self[(middle+1)...]).binarySearchTree()
        return root
    }
}

let binarySearchTree = Array(1...10).binarySearchTree()


class Algorithm {
    
    static func breathFirstSearch(root: TreeNode?) {
        guard let root = root else { return }
        var queue = [root]
        
        while !queue.isEmpty {
            let node = queue.removeFirst()
            if let childNode = node.left {
                queue.append(childNode)
            }
            if let childNode = node.right {
                queue.append(childNode)
            }
            
            print(node.value)
        }
    }
    
    static func depthFirstSearch(root: TreeNode?) {
        guard let root = root else { return }
        depthFirstSearch(root: root.left)
        print(root.value)
        depthFirstSearch(root: root.right)
        
    }
}



func benchmark(_ label: String, task: () -> Void) {
    let date = Date()
    task()
    print(label, Date().timeIntervalSince(date), "\n")
}

benchmark("BFS") {
    Algorithm.breathFirstSearch(root: binarySearchTree)
}

benchmark("DFS") {
    Algorithm.depthFirstSearch(root: binarySearchTree)
}

