import Foundation
import UIKit



class Account : NSObject {
    @objc func btn() {
        print("123")
    }
    
}
let button = UIButton()
print(#selector(Account.btn))

let account = Account()
button.addTarget(account, action: #selector(), for: .touchDown)

button.sendActions(for: .touchDown)

