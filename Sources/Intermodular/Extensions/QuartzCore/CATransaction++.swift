//
// Copyright (c) Vatsal Manot
//

import QuartzCore
import Swift

extension CATransaction {
    public static func animationTransaction(_ animateBlock: (() -> Void), completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        
        animateBlock()

        CATransaction.commit()
    }

    public static func performWithoutAnimation(_ actionsWithoutAnimation: () -> Void) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)

        actionsWithoutAnimation()

        CATransaction.commit()
    }
}
