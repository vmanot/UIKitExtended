//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

extension NSMutableAttributedString {
    public func append(_ string: String) {
        append(NSAttributedString(string: string))
    }
}

extension NSMutableAttributedString {
    public func setFont(_ font: UIFont) {
        setAttributes([.font: font], range: NSMakeRange(0, length))
    }
    
    public func addFont(_ font: UIFont) {
        addAttributes([.font: font], range: NSMakeRange(0, length))
    }
    
    public func setForegroundColor(_ color: UIColor) {
        setAttributes([.foregroundColor: color], range: NSMakeRange(0, length))
    }
    
    public func addForegroundColor(_ color: UIColor) {
        addAttributes([.foregroundColor: color], range: NSMakeRange(0, length))
    }
    
    @discardableResult
    public func addLink(_ url: URL, for text: String) -> Bool {
        let foundRange = mutableString.range(of: text)
        
        guard foundRange.location != NSNotFound else {
            return false
        }
        
        addAttribute(.link, value: url, range: foundRange)
        
        return true
    }
}
