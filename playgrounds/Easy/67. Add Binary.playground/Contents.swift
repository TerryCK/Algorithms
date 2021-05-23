/*
 Given two binary strings a and b, return their sum as a binary string.

  

 Example 1:

 Input: a = "11", b = "1"
 Output: "100"
 Example 2:

 Input: a = "1010", b = "1011"
 Output: "10101"
  

 Constraints:

 1 <= a.length, b.length <= 104
 a and b consist only of '0' or '1' characters.
 Each string does not contain leading zeros except for the zero itself.
 */

// T: O(n), S: O(n)

class Solution {
    
    func addBinary(_ a: String, _ b: String) -> String {
        let a = Array(a)
        let b = Array(b)
        var carry = 0
        var index = max(a.count, b.count)
        var target = ""
        let aOffset = index - a.count
        let bOffset = index - b.count
        index -= 1
        
        while index >= 0 {
            var aValue = 0
            var bValue = 0
            if  (0..<a.count).contains(index-aOffset) {
                aValue = Int(String(a[index-aOffset])) ?? 0
            }
            
            if (0..<b.count).contains(index-bOffset) {
                bValue = Int(String(b[index-bOffset])) ?? 0
            }
            
            let resultValue = aValue + bValue + carry
            carry = resultValue / 2
            
            target.append("\(resultValue % 2)")

            index -= 1
        }
        
        if carry == 1 {
            target.append("1")
        }
        return String(target.reversed())
    }
}

let solution = Solution()
solution.addBinary("11", "1") //== "100"
solution.addBinary("1010", "1011") //== "10101"
