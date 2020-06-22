//
// Copyright (c) Vatsal Manot
//

import Swift
import UIKit

extension UITextField {
    open var placeholderLabel: UILabel? {
        return value(forKey: "_placeholderLabel") as? UILabel
    }
}

extension UITextField {
    @discardableResult
    open override func resignFirstResponder() -> Bool {
        defer {
            layoutIfNeeded()
        }
        
        return super.resignFirstResponder()
    }
}
