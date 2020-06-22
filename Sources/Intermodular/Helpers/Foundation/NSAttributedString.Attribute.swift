//
// Copyright (c) Vatsal Manot
//

import Foundation
import Swift

extension NSAttributedString {
    public enum Attribute {
        case foregroundColor(UIColor)
        case font(UIFont)
        case link(URL)
        
        public var key: NSAttributedString.Key {
            switch self {
                case .font:
                    return .font
                case .foregroundColor:
                    return .foregroundColor
                case .link:
                    return .link
            }
        }
        
        public var value: Any {
            switch self {
                case .font(let value):
                    return value
                case .foregroundColor(let value):
                    return value
                case .link(let value):
                    return value
            }
        }
    }
}

extension NSMutableAttributedString {
    public func setAttributes(_ attributes: [Attribute]) {
        var _attributes: [NSAttributedString.Key: Any] = [:]
        
        for attribute in attributes {
            _attributes[attribute.key] = attribute.value
        }
        
        setAttributes(_attributes, range: NSMakeRange(0, length))
    }

    public func addAttribute(_ attribute: Attribute) {
        addAttribute(attribute.key, value: attribute.value, range: NSMakeRange(0, length))
    }
    
    @discardableResult
    public func addAttribute(_ attribute: Attribute, for text: String) -> Bool {
        let range = mutableString.range(of: text)
        
        guard range.location != NSNotFound else {
            return false
        }
        
        addAttribute(attribute.key, value: attribute.value, range: range)
        
        return true
    }
}
