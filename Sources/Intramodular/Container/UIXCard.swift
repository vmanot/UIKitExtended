//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

open class UIXCard<Child: UIView>: UIXViewContainer<Child> {
    override open func setupChild(_ child: Child) {
        super.setupChild(child)
        
        layoutMarginsGuide.constrainSubview(child)
    }
}

