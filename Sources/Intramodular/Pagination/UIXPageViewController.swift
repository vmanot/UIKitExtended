//
// Copyright (c) Vatsal Manot
//

import Swift
import UIKit

open class UIXPageViewController: UIPageViewController, UIXViewProtocol, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    open private(set) var currentPageIndex: Int = 0
    
    open var isCyclical: Bool = false
    
    open var navigationDirection: UIPageViewController.NavigationDirection = .forward {
        didSet {
            reloadData()
        }
    }
    
    open var pages: [UIViewController] = [] {
        didSet {
            reloadData()
        }
    }
    
    override public required init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
        
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open func setup() {
        dataSource = self
        delegate = self
    }
    
    open func reloadData() {
        setViewControllers(
            [pages[currentPageIndex]],
            direction: .forward,
            animated: true
        )
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for page in pages {
            page.view.frame = view.frame
        }
    }
    
    // MARK: - Data Source -
    
    open func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        pages
            .firstIndex(of: viewController)
            .flatMap({
                $0 == 0
                    ? (isCyclical ? pages.last : nil)
                    : pages[$0 - 1]
            })
    }
    
    open func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        pages
            .firstIndex(of: viewController)
            .flatMap({
                $0 + 1 == pages.count
                    ? (isCyclical ? pages.first : nil)
                    : pages[$0 + 1]
            })
    }
    
    
    // MARK: - Delegate
    
    open func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating _: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard completed else {
            return
        }
        
        if let controller = viewControllers?.first {
            pages
                .firstIndex(of: controller)
                .map({
                    currentPageIndex = $0
                })
        }
    }
}

extension UIXPageViewController {
    public class func horizontal(
        transitionStyle: UIXPageViewController.TransitionStyle = .scroll,
        @ArrayBuilder<UIViewController> pages: () -> [UIViewController]
    ) -> Self {
        Self(
            transitionStyle: transitionStyle,
            navigationOrientation: .horizontal,
            options: [:]
        ).then {
            $0.pages = pages()
        }
    }
    
    public class func vertical(
        transitionStyle: UIXPageViewController.TransitionStyle = .scroll,
        @ArrayBuilder<UIViewController> pages: () -> [UIViewController]
    ) -> Self {
        Self(
            transitionStyle: transitionStyle,
            navigationOrientation: .vertical,
            options: [:]
        ).then {
            $0.pages = pages()
        }
    }
}
