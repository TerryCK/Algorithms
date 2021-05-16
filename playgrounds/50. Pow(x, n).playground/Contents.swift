/*
 Implement pow(x, n), which calculates x raised to the power n (i.e., xn).

  

 Example 1:

 Input: x = 2.00000, n = 10
 Output: 1024.00000
 Example 2:

 Input: x = 2.10000, n = 3
 Output: 9.26100
 Example 3:

 Input: x = 2.00000, n = -2
 Output: 0.25000
 Explanation: 2-2 = 1/22 = 1/4 = 0.25
  

 Constraints:

 -100.0 < x < 100.0
 -231 <= n <= 231-1
 -104 <= xn <= 104
*/


enum Number {
    case real
    case imaginary

}

func pow(_ x: Double, n: Int) -> (Double, Number) {
    switch (x, n) {
    case (0, 0): fatalError("math not defined")
    case (0, _): return (0, .real)
    case (_, 0): return (1, .real)
    case (_, _) where x < 0:
        let value = pow(-x, n: n)
        return (value.0, .imaginary)

    case (_, _) where x > 0 && n > 0:
        let result = implement1(x, n: n)
        return (result, .real)
        
    case (_, _) where x > 0 && n < 0:
        return (1 / pow(x, n: -n).0, .real)
        
    case (_, _):
        fatalError("never execute")
    }
    
}

class Solution {
    // time complexity O(log(n))
    func myPow(_ x: Double, _ n: Int) -> Double {
        switch (x, n) {
        case (0, 0): fatalError("math not defined")
        case (0, _): return 0
        case (_, 0): return 1
        case (_, _) where x < 0:
            let result = myPow(-x, n)
            if (n & 1 == 1) {
                return -1 * result
            }
            return result

        case (_, _) where x > 0 && n > 0:
            return implement2(x, n: n)
            
        case (_, _) where x > 0 && n < 0:
            return 1 / myPow(x, -n)
            
        case (_, _):
            fatalError("never execute")
        }
        
    }
    func implement2(_ x: Double, n: Int) -> Double {
        if n == 0 { return 1 }
        if n == 1 { return x }
        if n == 2 { return x * x }
        let res = implement2(x, n: n / 2)
        let result = res * res
        return (n & 1 == 1) ? result * x : result
    }

}




func implement1(_ x: Double, n: Int) -> Double {
    var result = x
    for _ in 1..<n {
        result *= x
    }
    return result
}
//Input: x = 2.00000, n = 10
//Output: 1024.00000
//Example 2:
//
//Input: x = 2.10000, n = 3
//Output: 9.26100
//Example 3:
//
//Input: x = 2.00000, n = -2
//Output: 0.25000
//Explanation: 2-2 = 1/22 = 1/4 = 0.25

let solution = Solution()
solution.myPow(2, 10)
solution.myPow(2.1, 3)
solution.myPow(2,  -2)
solution.myPow(-3.39758,  5)
