//
//  UI.View.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 22/04/2021.
//

import UIKit

extension UI {
    open class View: UIView {
        
        /// A closure that gets called with `self` as an argument on `layoutSubviews`.
        /// Use it to configure styles that are derived from the view bounds.
        public var onLayout: (View) -> Void = { _ in }
        
        public var layoutBag = LayoutBag()
        
        private var layouts: [SomeView] = []
        
        public convenience init(_ layouts: [SomeView]) {
            self.init(frame: .zero)
            self.layouts = layouts
            
            setup()
            defineLayout()
        }
        
        public convenience init(@LayoutBuilder _ layoutBuilder: () -> [SomeView]) {
            self.init(frame: .zero)
            self.layouts = layoutBuilder()
            
            setup()
            defineLayout()
        }
        
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
            if layer.shadowOpacity > 0 {
                layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
            }
        }
        
        open func setup() {
        }
        
        open func defineLayout() {
            layoutBag.append(subviewsLayout.layout(in: self))
        }
        
        open var subviewsLayout: SomeView {
            if layouts.isEmpty {
                return EmptyLayout()
            }
            return group(layouts)
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
    }
}
