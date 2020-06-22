//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

open class UIXRelativeSizingViewContainer<Child: UIView>: UIXViewContainer<Child> {
    override open func setupChild(_ child: Child) {
        super.setupChild(child)
        
        constrainSubview(child)
    }
}

extension UIView {
    public func relativeWidth(_ multiplier: CGFloat, offset: CGFloat = 0) -> UIView {
        UIXRelativeSizingViewContainer(child: self).then {
            $0.setRelativeWidth(multiplier, offset: offset)
        }
    }
    
    public func relativeHeight(_ multiplier: CGFloat, offset: CGFloat = 0) -> UIView {
        UIXRelativeSizingViewContainer(child: self).then {
            $0.setRelativeHeight(multiplier, offset: offset)
        }
    }
    
    public func relativeSize(width: CGFloat, height: CGFloat) -> UIView {
        UIXRelativeSizingViewContainer(child: self).then {
            $0.setRelativeWidth(width)
            $0.setRelativeHeight(height)
        }
    }
}
