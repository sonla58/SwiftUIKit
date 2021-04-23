//
//  UI-ImageView.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 22/04/2021.
//

import UIKit

extension UI {
    
    open class ImageView: UIImageView {
        
        /// A closure that gets called with `self` as an argument on `layoutSubviews`.
        /// Use it to configure styles that are derived from the view bounds.
        public var onLayout: (ImageView) -> Void = { _ in }
        
        public var layoutBag = LayoutBag()
        
        public override init(image: UIImage? = nil) {
            super.init(image: image)
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
            return EmptyLayout()
        }
    }
}

