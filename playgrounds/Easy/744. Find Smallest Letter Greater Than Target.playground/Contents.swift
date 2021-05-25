/*
 Given a list of sorted characters letters containing only lowercase letters, and given a target letter target, find the smallest element in the list that is larger than the given target.

 Letters also wrap around. For example, if the target is target = 'z' and letters = ['a', 'b'], the answer is 'a'.

 Examples:

 Input:
 letters = ["c", "f", "j"]
 target = "a"
 Output: "c"

 Input:
 letters = ["c", "f", "j"]
 target = "c"
 Output: "f"

 Input:
 letters = ["c", "f", "j"]
 target = "d"
 Output: "f"

 Input:
 letters = ["c", "f", "j"]
 target = "g"
 Output: "j"

 Input:
 letters = ["c", "f", "j"]
 target = "j"
 Output: "c"

 Input:
 letters = ["c", "f", "j"]
 target = "k"
 Output: "c"
 Note:

 letters has a length in range [2, 10000].
 letters consists of lowercase letters, and contains at least 2 unique letters.
 target is a lowercase letter.

 */

class Solution {
    func nextGreatestLetter(_ letters: [Character], _ target: Character) -> Character {
        var l = 0, r = letters.count - 1
        while l + 1 < r {
            let mid = l + (r - l) / 2
            switch letters[mid] {
            case let value where target >= value:
                l = mid
            case let value where target < value:
                r = mid
            default: break
            }
        }
        let low = min(l, r)
        let up = max(l, r)
        if target < letters[low] {
            return letters[low]
        } else if target < letters[up] {
            return letters[up]
        } else {
            return letters.first!
        }
    }
}


let solution = Solution()
let input = ["c", "f", "j"].map(Character.init)

solution.nextGreatestLetter(input, Character("c"))

let input2 = ["e","e","e","e","e","e","n","n","n","n"].map(Character.init)
solution.nextGreatestLetter(input2, Character("e"))
