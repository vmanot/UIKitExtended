//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

/// A view that expands to fill all available space along an axis.
open class UIXSpacer: UIXView {
    public init(axis: NSLayoutConstraint.Axis) {
        super.init()
        
        switch axis {
            case .horizontal:
                constrainWidth(toGreaterThanOrEqualTo: 1)
            case .vertical:
                constrainHeight(toGreaterThanOrEqualTo: 1)
            @unknown default:
                constrainWidth(toGreaterThanOrEqualTo: 1)
                constrainHeight(toGreaterThanOrEqualTo: 1)
        }
        
        setContentHuggingPriority(.defaultLow, for: axis)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func setup() {
        super.setup()
        
        isUserInteractionEnabled = false
    }
}

open class UIXHorizontalSpacer: UIXSpacer {
    public init() {
        super.init(axis: .horizontal)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

open class UIXVerticalSpacer: UIXSpacer {
    public init() {
        super.init(axis: .vertical)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
