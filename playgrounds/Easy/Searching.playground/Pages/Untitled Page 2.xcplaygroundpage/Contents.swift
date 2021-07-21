protocol AProtocol {
    
}
enum A: AProtocol {
    case x, y, z
}
enum B: AProtocol {
    case x, y
}


struct Object<Type: AProtocol> {
    let x: AProtocol
}

extension Object where Type == A {
    init(_ input: Type) {
        x = input
    }
}
