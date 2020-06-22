//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

/// A modern `UISwitchView` subclass.
open class UIXSwitch: UISwitch, UIXViewProtocol {
    override open var intrinsicContentSize: CGSize {
        guard !isHidden else {
            return .zero
        }
        
        return super.intrinsicContentSize
    }
    
    override open var isHidden: Bool {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    public init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// A customization point for subclasses.
    open func setup() {
        
    }
}
