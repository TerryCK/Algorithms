import Foundation

func mergeSorted<Element: Comparable>(array: Array<Element>, order: @escaping (Element, Element) -> Bool) -> Array<Element> {
    
    if array.count <= 1 { return array }
    
    let (left, right) = split(array: array)
    
    let leftSorted = mergeSorted(array: left, order: order)
    let rightSorted = mergeSorted(array: right, order: order)
    
    
    return merge(left: leftSorted, right: rightSorted, order: order)
    
}

func merge<Element: Comparable>(left: Array<Element>, right: Array<Element>, order: @escaping (Element, Element) -> Bool) -> Array<Element> {
    var list = [Element]()
    var leftIndex = 0
    var rightIndex = 0
    
    
    while leftIndex < left.count, rightIndex < right.count {
        if order(left[leftIndex], right[rightIndex]) {
            list.append(left[leftIndex])
            leftIndex += 1
        } else {
            list.append(right[rightIndex])
            rightIndex += 1
        }
    }
    
    while leftIndex < left.count {
        list.append(left[leftIndex])
        leftIndex += 1
    }
    
    while rightIndex < right.count {
        list.append(right[rightIndex])
        rightIndex += 1
    }
    
    return list
    
}


func split<Element: Comparable>(array: Array<Element>) -> (Array<Element>, Array<Element>) {
    let mid = array.count / 2
    return (Array(array[0..<mid]), Array(array[mid...]))
}



var array = (0...100).map { _ in Int.random(in: 0...1000) }


let result = mergeSorted(array: Array(Set(array)), order: >)


func verifyMergeSort<Element: Comparable>(array: Array<Element>, order: @escaping (Element, Element) -> Bool) -> Bool {
    if array.count <= 1 { return true }
    return order(array[0], array[1]) && verifyMergeSort(array: Array(array[2...]), order: order)
}


verifyMergeSort(array: result, order: >)
