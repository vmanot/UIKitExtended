//
// Copyright (c) Vatsal Manot
//

import Swift
import UIKit

extension UIResponder {
    open func nearestResponder<Responder: UIResponder>(ofKind kind: Responder.Type) -> Responder? {
        guard !isKind(of: kind) else {
            return (self as! Responder)
        }
        
        return next?.nearestResponder(ofKind: kind)
    }
    
    private func furthestResponder<Responder: UIResponder>(ofKind kind: Responder.Type, default _default: Responder?) -> Responder? {
        return next?.furthestResponder(ofKind: kind, default: self as? Responder) ?? _default
    }
    
    open func furthestResponder<Responder: UIResponder>(ofKind kind: Responder.Type) -> Responder? {
        return furthestResponder(ofKind: kind, default: nil)
    }
}
