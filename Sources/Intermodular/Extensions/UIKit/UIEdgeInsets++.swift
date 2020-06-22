//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

extension UIEdgeInsets {
    public var horizontal: CGFloat {
        return left + right
    }
    
    public var vertical: CGFloat {
        return top + bottom
    }
    
    public static prefix func - (_ inset: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: -inset.top,
            left: -inset.left,
            bottom: -inset.bottom,
            right: -inset.right
        )
    }
    
    public init(all offset: CGFloat) {
        self.init(top: offset, left: offset, bottom: offset, right: offset)
    }
}
