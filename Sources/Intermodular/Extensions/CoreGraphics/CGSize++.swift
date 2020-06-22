//
// Copyright (c) Vatsal Manot
//

import CoreGraphics
import Swift
import UIKit

extension CGSize {
    public var widthAsUIViewIntrinsicMetric: CGFloat? {
        guard width != UIView.noIntrinsicMetric else {
            return nil
        }
        
        return width
    }
    
    public var heightAsUIViewIntrinsicMetric: CGFloat? {
        guard height != UIView.noIntrinsicMetric else {
            return nil
        }
        
        return height
    }
    
    public func inset(by insets: UIEdgeInsets) -> CGSize {
        return .init(width: width + insets.horizontal, height: height + insets.horizontal)
    }
}
