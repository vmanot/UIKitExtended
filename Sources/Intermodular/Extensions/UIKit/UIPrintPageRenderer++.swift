//
// Copyright (c) Vatsal Manot
//

import Swift
import UIKit

extension UIPrintPageRenderer {
    public func toPDFData() -> Data {
        let data = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(data, paperRect, nil)
        prepare(forDrawingPages: .init(location: 0, length: numberOfPages))
        
        let bounds = UIGraphicsGetPDFContextBounds()
        
        for index in 0..<numberOfPages {
            UIGraphicsBeginPDFPage()
            drawPage(at: index, in: bounds)
        }
        
        UIGraphicsEndPDFContext()
        
        return data as Data
    }
}
