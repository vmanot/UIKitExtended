//
// Copyright (c) Vatsal Manot
//

import Swift
import UIKit

extension UILabel {
    /// A height of the label.
    open var boundingHeight: CGFloat {
        guard let font = font else {
            return 0
        }
        
        return "Sphinx".size(withAttributes: [.font: font]).height * CGFloat(numberOfLines)
    }
}
