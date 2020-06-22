//
// Copyright (c) Vatsal Manot
//

import Swift
import UIKit

extension UIImage {
    public enum FileIconSize {
        case smallest
        case largest
    }
    
    public static func icons(for url: URL) -> [UIImage] {
        return UIDocumentInteractionController(url: url).icons
    }
    
    public static func icon(for url: URL, preferredSize: FileIconSize = .smallest) -> UIImage {
        switch preferredSize {
            case .smallest:
                return icons(for: url).first!
            case .largest:
                return icons(for: url).last!
        }
    }
    
    public static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        
        UIGraphicsBeginImageContext(rect.size)
        defer {
            UIGraphicsEndImageContext()
        }
        color.setFill()
        UIRectFill(rect)
        
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}

extension UIImage {
    public func resized(to newSize: CGSize) -> UIImage {
        guard size != newSize else {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        
        defer {
            UIGraphicsEndImageContext()
        }
        
        draw(in: .init(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    
    public func resizedWithin(_ rectSize: CGSize) -> UIImage {
        let widthFactor = size.width / rectSize.width
        let heightFactor = size.height / rectSize.height
        
        var resizeFactor = widthFactor
        
        if size.height > size.width {
            resizeFactor = heightFactor
        }
        
        let newSize = CGSize(width: size.width / resizeFactor, height: size.height / resizeFactor)
        
        return resized(to: newSize)
    }
    
    public func resizedWithin(
        width: CGFloat = .greatestFiniteMagnitude,
        height: CGFloat = .greatestFiniteMagnitude
    ) -> UIImage {
        resizedWithin(.init(width: width, height: height))
    }
}
