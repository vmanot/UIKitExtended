//
// Copyright (c) Vatsal Manot
//

import Swift
import UIKit

extension UIViewPrintFormatter {
    public func toPDFData() -> Data {
        let renderer = UIPrintPageRenderer()
        
        renderer.addPrintFormatter(self, startingAtPageAt: 0)
        renderer.setValue(NSValue(cgRect: view.frame.originZero), forKey: "paperRect")
        renderer.setValue(NSValue(cgRect: view.frame.originZero), forKey: "printableRect")
        
        return renderer.toPDFData()
    }
}
