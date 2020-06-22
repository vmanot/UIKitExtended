//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

/// A modern `UITableViewCell` subclass.
open class UIXTableViewCell: UITableViewCell, UIXViewProtocol {
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// A customization point for subclasses.
    open func setup() {
        
    }
}
