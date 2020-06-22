//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

open class UIXImageView: UIImageView, UIXViewProtocol {
    override open var intrinsicContentSize: CGSize {
        guard !isHidden else {
            return .zero
        }
        
        return super.intrinsicContentSize
    }
    
    public init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// A customization point for subclasses.
    open func setup() {
        
    }
}
