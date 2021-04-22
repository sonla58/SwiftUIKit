//
//  UI-TableViewCell.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 22/04/2021.
//

import UIKit

extension UI {
    
    open class TableViewCell: UITableViewCell {
        
        /// A closure that gets called with `self` as an argument on `layoutSubviews`.
        /// Use it to configure styles that are derived from the view bounds.
        public var onLayout: (TableViewCell) -> Void = { _ in }
        
        public var layoutBag = LayoutBag()
        
        public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            layoutBag.append(subviewsLayout.layout(in: contentView))
        }
        
        open var subviewsLayout: SomeView {
            return EmptyLayout()
        }
    }
}

