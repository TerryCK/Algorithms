import Foundation


class Solution {
    func largestOddNumber(_ num: String) -> String {
        var index = num.count - 1
        let num = Array(num)
        
        while index >= 0 {
            
            let number = Int(String(num[index])) ?? 0
            if number % 2 != 0 {
                return String(num[0...index])
            }
            
            index -= 1
        }
        return ""
    }
}
