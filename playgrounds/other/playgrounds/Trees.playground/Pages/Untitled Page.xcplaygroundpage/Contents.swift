import Foundation



example(of: "creating a tree") {
    let beverages = Node("Beverages")
    
    let hot = Node("Hot")
    let cold = Node("cold")
    
    beverages.add(hot)
    beverages.add(cold)
    print(beverages)
}




example(of: "search") {
     let bevergesTree: Node<String> = {
        let beverages = Node("Beverages")
        let hot = Node("Hot")
        let cold = Node("cold")
        
        let tea = Node("Tea")
        
        let coffee = Node("Green")
        let black = Node("Black")
        
        let green = Node("Green")
        let chocolate = Node("Cocoa")
        let chai = Node("Chai")
        let soda = Node("Soda")
        let ginger = Node("Ginger ale")
        let bitter = Node("Bitter lemon")
        let milk = Node("Milk")
        beverages.add(hot)
        beverages.add(cold)
        [tea, coffee, chocolate].forEach(hot.add)
        [soda, milk].forEach(cold.add)
        [black, green, chai].forEach(tea.add)
        [ginger, bitter].forEach(soda.add)
        return beverages
     }()
    
    
  
    
    if let result = bevergesTree.search("Ginger ale") {
        print(result)
    }
}


enum X: Int {
    case a, b = 2, c
}

X.c.rawValue
