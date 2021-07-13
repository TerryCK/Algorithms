
func quickSorted<Element: Comparable>(array: [Element], order: @escaping (Element, Element) -> Bool) -> [Element] {
    guard array.count > 1 else { return array }
    let pivot = array.first!
    
    var lessThan = [Element]()
    lessThan.reserveCapacity(array.count)
    var greatThan = [Element]()
    greatThan.reserveCapacity(array.count)
    
    for element in array[1...] {
        if order(pivot, element) {
            greatThan.append(element)
            
        } else {
            lessThan.append(element)
        }
    }
    
    let less = quickSorted(array: lessThan, order: order)
    let greater = quickSorted(array: greatThan, order: order)
    
    return less + [pivot] + greater
}



let array = (1...1000).map { _ in Int.random(in: 1...100000)}
let result = quickSorted(array: Array(Set(array)), order: <)

func verifyMergeSort<Element: Comparable>(array: Array<Element>, order: @escaping (Element, Element) -> Bool) -> Bool {
    if array.count <= 1 { return true }
    return order(array[0], array[1]) && verifyMergeSort(array: Array(array[2...]), order: order)
}


verifyMergeSort(array: result, order: <)
