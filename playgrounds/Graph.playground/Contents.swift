
struct Edge<T> {
    let source: Vertex<T>
    let destination: Vertex<T>
    let weight: Double?
}
enum EdgeType {
    case directed, undirected
}
struct Vertex<T> {
    let index: Int
    let value: T
}
extension Vertex: Equatable where T: Equatable {}
extension Vertex: Hashable where T: Hashable { }

protocol Graph {
    associatedtype Element
    
    func createVertex(data: Element) -> Vertex<Element>
    func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
    func addUndirectedEdge(between source: Vertex<Element>, and destination: Vertex<Element>, weight: Double?)
    func add(_ edge: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
    func edges(from source: Vertex<Element>, to destination: Vertex<Element>) -> [Edge<Element>]
    func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double?
}

class AdjacencyList<Element: Hashable>: Graph {
    
    typealias EdgeList = [Edge<Element>]
    private var storage = [Vertex<Element>: EdgeList]()
    
    
    
    
    func createVertex(data: Element) -> Vertex<Element> {
        let vertex = Vertex(index: storage.count, value: data)
        storage[vertex] = []
        return vertex
    }
    
    func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        storage[source]?.append(edge)
    }

    func addUndirectedEdge(between source: Vertex<Element>, and destination: Vertex<Element>, weight: Double?) {
        
    }
    
    func add(_ edge: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        
    }
    
    func edges(from source: Vertex<Element>, to destination: Vertex<Element>) -> [Edge<Element>] {
        <#code#>
    }
    
    func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double? {
        <#code#>
    }
    
    
    
    
    
    init() {
        
    }
}
