//
//  UI-TextField.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 22/04/2021.
//

import UIKit

extension UI {
    
    open class TextField: UITextField {
        
        /// A closure that gets called with `self` as an argument on `layoutSubviews`.
        /// Use it to configure styles that are derived from the view bounds.
        public var onLayout: (TextField) -> Void = { _ in }
        
        public var layoutBag = LayoutBag()
        
        public var textInsets: UIEdgeInsets = .zero
        
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
        
        open override var intrinsicContentSize: CGSize {
            var size = super.intrinsicContentSize
            size.width += textInsets.right + textInsets.left
            size.height += textInsets.top + textInsets.bottom
            return size
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
        
        open override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return super.editingRect(forBounds: bounds).inset(by: textInsets)
        }
        
        open override func textRect(forBounds bounds: CGRect) -> CGRect {
            return super.textRect(forBounds: bounds).inset(by: textInsets)
        }
        
        open func setup() {
        }
        
        open func defineLayout() {
            layoutBag.append(subviewsLayout.layout(in: self))
        }
        
        open var subviewsLayout: SomeView {
            return EmptyLayout()
        }
    }
}
