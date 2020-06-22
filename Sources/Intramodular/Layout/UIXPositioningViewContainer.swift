//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

open class UIXPositioningViewContainer<Child: UIView>: UIXViewContainer<Child> {
    override open func setup() {
        super.setup()
        
        isPassthrough = true
    }
    
    override open func setupChild(_ child: Child) {
        super.setupChild(child)
        
        addSubview(child)
    }
}

open class UIXTopLeadingPositioningViewContainer<Child: UIView>: UIXPositioningViewContainer<Child> {
    override open func setupChild(_ child: Child) {
        super.setupChild(child)
        
        child.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            child.topAnchor.constraint(equalTo: topAnchor),
            child.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}

// MARK: - Helpers -

extension UIView {
    public func positionTopLeading() -> UIView {
        UIXTopLeadingPositioningViewContainer {
            self
        }
    }
}

