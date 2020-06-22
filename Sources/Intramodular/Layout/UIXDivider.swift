//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

/// A divider view.
open class UIXDivider: UIXView {
    override open func setup() {
        constrainHeight(to: 2)
        
        backgroundColor = .black
    }
}
