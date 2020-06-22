//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

open class UIXModelCollectionViewCell<Model>: UIXCollectionViewCell {
    private var isSetUp: Bool = false
    private var isReuseDirty: Bool = false
    
    /// The model currently backing the receiver.
    open private(set) var model: Model?
    
    open internal(set) var indexPath: IndexPath?
    
    open override func setup() {
        isSetUp = true
    }
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        
        isReuseDirty = true
    }
    
    /// Perform post-reuse set-up.
    open func setUpPostReuse() {
        isReuseDirty = false
    }
    
    /// Configure this cell with the given model.
    open func configure(with model: Model) {
        if !isSetUp {
            setup()
        }
        
        if isReuseDirty {
            setUpPostReuse()
        }
        
        self.model = model
    }
}
