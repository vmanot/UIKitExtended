//
// Copyright (c) Vatsal Manot
//

import CoreGraphics
import Swift

extension CGRect {
    public var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
    
    public var originZero: CGRect {
        return .init(origin: .zero, size: size)
    }
}
