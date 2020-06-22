//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

open class UIXViewController: UIViewController, UIXViewProtocol {
    private var onDisappearAction: () -> Void = { }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        self.setup()
    }
    
    public convenience init(_ childView: () -> UIView) {
        self.init()
        
        view.constrainSubview(childView())
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// A customization point for subclasses.
    open func setup() {

    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        onDisappearAction()
    }
}

extension UIXViewController {
    public func onDisappear(perform action: @escaping () -> Void) {
        let current = self.onDisappearAction
        
        self.onDisappearAction = { current(); action() }
    }
}
