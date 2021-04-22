//
//  UI-Window.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 22/04/2021.
//

import UIKit

extension UI {
    
    open class Window: UIWindow {
        
        /// A closure that gets called with `self` as an argument on `layoutSubviews`.
        /// Use it to configure styles that are derived from the view bounds.
        public var onLayout: (Window) -> Void = { _ in }
        
        public var layoutBag = LayoutBag()
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
            defineLayout()
        }
        
        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
            defineLayout()
        }
        
        open override func layoutSubviews() {
            super.layoutSubviews()
            onLayout(self)
        }
        
        open func setup() {
        }
        
        open func defineLayout() {
            layoutBag.append(subviewsLayout.layout(in: self))
        }
        
        open var subviewsLayout: SomeView {
            return EmptyLayout()
        }
        
        open override func didMoveToSuperview() {
            super.didMoveToSuperview()
            
            guard let superview = superview else { return }
            
            if #available(iOS 11.0, *) {
                // safeAreaLayoutGuide is already available
            } else {
                NSLayoutConstraint.activate([
                    ___safeAreaLayoutGuide.topAnchor.constraint(equalTo: superview.___safeAreaLayoutGuide.topAnchor),
                    ___safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: superview.___safeAreaLayoutGuide.bottomAnchor)
                ])
            }
        }
        
        open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            postWindowTraitCollectionDidChangeNotification()
        }
        
        open override var frame: CGRect {
            didSet {
                postWindowTraitCollectionDidChangeNotification()
            }
        }
        
        private var previousWindowTraitCollecton: WindowTraitCollection?
        
        private func postWindowTraitCollectionDidChangeNotification() {
            guard previousWindowTraitCollecton != windowTraitCollection else { return }
            previousWindowTraitCollecton = windowTraitCollection
            NotificationCenter.default.post(name: .windowTraitCollectionDidChange, object: self)
        }
    }
}

extension Notification.Name {
    
    public static let windowTraitCollectionDidChange = Notification.Name("windowTraitCollectionDidChange")
}
