//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

open class UIXModelView<Model>: UIXView {
    /// The model currently backing the receiver.
    open private(set) var model: Model?
    
    open func configure(with model: Model) {
        self.model = model
    }
}
