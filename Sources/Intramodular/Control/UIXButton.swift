//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

/// A modern `UIButton` subclass.
///
/// This subclass provides an intrinsic content size.
open class UIXButton: UIButton, UIXViewProtocol {
    override open var intrinsicContentSize: CGSize {
        guard !isHidden else {
            return .zero
        }
        
        let labelSize = titleLabel?.sizeThatFits(
            CGSize(width: frame.width,
                   height: .greatestFiniteMagnitude)
            ) ?? .zero
        
        let desiredButtonSize = CGSize(
            width: 0
                + labelSize.width
                + titleEdgeInsets.left
                + titleEdgeInsets.right,
            height: 0
                + labelSize.height
                + titleEdgeInsets.top
                + titleEdgeInsets.bottom
        )
        
        return desiredButtonSize
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
        
    public convenience init(action: @escaping () -> ()) {
        self.init()
        
        addActionTarget(action: action)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// A customization point for subclasses.
    open func setup() {
        
    }
}
