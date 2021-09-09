import Foundation

indirect enum Node<Element>: CustomStringConvertible {
    case end(Element)
    case node(Element, Self)
    
    var description: String {
        switch self {
        case .end(let element)    : return String(describing: element)
        case .node(let element, _): return String(describing: element)
        }
    }
}


extension LinkedList: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
           var elements = elements
           var tail = Node.end(elements.removeFirst())
           elements.forEach {
               tail = Node.node($0, tail)
           }
           head = tail
       }
}
 
extension LinkedList: Sequence {
    func makeIterator() -> AnyIterator<Any> {
        var head: Node<Element>? = self.head
        return AnyIterator {
            defer {
                switch head {
                case .node(_, let node): head = node
                default: head = nil
                }
            }
            return head
        }
    }
}

struct LinkedList<Element> {
     let head: Node<Element>
}

let linkList: LinkedList = [1,2,3,4,5,6]
for e in linkList {
    print(e)
}
