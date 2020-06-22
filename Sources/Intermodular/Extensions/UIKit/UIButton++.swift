//
// Copyright (c) Vatsal Manot
//

import Swift
import UIKit

extension UIButton {
    public var normalTitle: String? {
        get {
            return title(for: .normal)
        } set {
            setTitle(newValue, for: .normal)
        }
    }
    
    public var normalTitleColor: UIColor? {
        get {
            return titleColor(for: .normal)
        } set {
            setTitleColor(newValue, for: .normal)
        }
    }
    
    
    public func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        setBackgroundImage(UIImage.from(color: color), for: state)
    }
}
