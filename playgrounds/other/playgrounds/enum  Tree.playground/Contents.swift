import Foundation


indirect enum Node<Element>: CustomStringConvertible {
    case leaf(Element)
    case child(left: Self?, element: Element, right: Self?)
    var description: String {
        switch self {
        case let .child(left: _, element: element, right: _): return String(describing: element)
        case let .leaf(element)                             : return String(describing: element)
        }
    }
    
}


let left1 = Node.leaf(1)
let left2 = Node.leaf(2)
let leaf = Node.leaf(4)
let node1 = Node.child(left: left1, element: 3, right: left2)
let root = Node.child(left: node1, element: 10, right: leaf)


struct Tree<Element> {
    let root: Node<Element>
    func preOrderTravesal(node: Node<Element>) {
        switch node {
        case let .child(left: left, element: element, right: right):
            if let left = left {
                preOrderTravesal(node: left)
            }
            
            print(element)
            
            if let right = right {
                preOrderTravesal(node: right)
            }
            
            
        case .leaf(let element):
            print(element)
        }
        
    }
}


let binaryTree = Tree(root: root)
binaryTree.preOrderTravesal(node: binaryTree.root)
