/*
 leetcode
 
 14. Longest Common Prefix
 Write a function to find the longest common prefix string amongst an array of strings.

 If there is no common prefix, return an empty string "".
 */

var input = [String]()

func findLongestCommonPrefix(strs: [String]) -> String {
    
    switch strs.count {
    case 0: return ""
    case 1: return strs.first!
    default: break
    }
    
    var minLength = Int.max
    for element in strs where element.count < minLength {
        minLength = element.count
    }
    
    let compare = strs.first!.map(Character.init)
//    O(strs + count of first + minLength * strs) k is minLength of count
    
    for curr in 0..<minLength {
        for index in 1..<strs.count {
            let string = strs[index]
            let char = string[String.Index(utf16Offset: curr, in: string)]
            if compare[curr] != char {
                return String(compare[0..<curr])
            }
        }
    }
    return String(compare[0..<minLength])
    
}


let test1 = ["NSB", "NSC", "NSA"]



findLongestCommonPrefix(strs: test1)


// O(strs * k)
func findLongestCommonPrefix2(strs: [String]) -> String {

    var result: String = ""
    var index: Int = 0
    
    while true {
        var curr: Character?
        
        for str in strs {
            guard index < str.count else { return result }
            
            switch curr {
            case .none:
                curr = str[String.Index(utf16Offset: index, in: str)]
                
            case .some(let char)
                    where char == str[String.Index(utf16Offset: index, in: str)]:
                break
            default: return result
            }
        }
        if let curr = curr {
            result.append(curr)
        } else {
            return result
        }
        
        index += 1
    }
    return result
}



["NSB",
 "NSC",
 "NSA"]


findLongestCommonPrefix2(strs: test1)
