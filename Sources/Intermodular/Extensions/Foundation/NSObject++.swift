//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

extension NSObjectProtocol {
    func then(_ mutate: (Self) -> ()) -> Self {
        mutate(self)
        
        return self
    }
}

extension NSObjectProtocol where Self: UIView {
    func then(_ mutate: (Self) -> ()) -> Self {
        mutate(self)
        
        return self
    }
}
