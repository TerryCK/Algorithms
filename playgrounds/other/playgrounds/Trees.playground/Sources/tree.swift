import Foundation

public class Node<T> {
   public var value: T
    public var children = [Node]()
    
    public init(_ value: T) {
        self.value = value
        
    }
    public func add(_ child: Node) {
        children.append(child)
    }
    
}

extension Node: CustomDebugStringConvertible {
  public var debugDescription: String {
        return String(describing: value)
    }
}

extension Node {
    public func forEachDepthFirst(visit: (Node) -> Void) {
        visit(self)
        children.forEach { $0.forEachDepthFirst(visit: visit) }
    }
}

public struct Queue<T> {
    public var array = [T]()
    
   public mutating func enqueue(_ new: T) {
        array.append(new)
    }
    
   public mutating func dequeue() -> T? {
    guard !array.isEmpty else { return nil }
        return array.removeFirst()
    }
    
}

extension Node {
    public func forEachLevelOrder(visit: (Node) -> Void) {
        var level = 0
        visit(self)
        var queue = Queue<Node>()
        children.forEach { queue.enqueue($0) }
        while let node = queue.dequeue() {
            visit(node)
            node.children.forEach { queue.enqueue($0) }
        }
    }
}


extension Node where T: Equatable {
    public func search(_ value: T) -> Node? {
        var result: Node?
        forEachLevelOrder {
            if value == $0.value {
                result = $0
            }
        }
        return result
    }
}









