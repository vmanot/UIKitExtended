//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

/// A `UIXView` subclass that contains a given child.
open class UIXViewContainer<Child: UIView>: UIXView {
    private let child: Child
    
    public required init(child: Child) {
        self.child = child
        
        super.init()
        
        setupChild(child)
    }
    
    public convenience init(makeChild: () -> Child) {
        self.init(child: makeChild())
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupChild(_ child: Child) {
        
    }
}
