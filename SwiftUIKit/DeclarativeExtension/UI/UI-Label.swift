//
//  UI-Label.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 22/04/2021.
//

import UIKit

extension UI {
    
    open class Label: UILabel {
        
        /// A closure that gets called with `self` as an argument on `layoutSubviews`.
        /// Use it to configure styles that are derived from the view bounds.
        public var onLayout: (Label) -> Void = { _ in }
        
        public var layoutBag = LayoutBag()
        
        public var intrinsicContentInsets: CGSize = .zero
        
        /// Text insets. Use it to add padding to the text within the label bounds.
        public var textInsets: UIEdgeInsets = .zero
        
        public var attributes: [NSAttributedString.Key: Any] = [:] {
            didSet {
                if let text = text {
                    self.text = text
                }
            }
        }
        
        public var paragraphStyle: NSMutableParagraphStyle {
            get {
                if let paragraphStyle = attributes[.paragraphStyle] as? NSMutableParagraphStyle {
                    return paragraphStyle
                } else {
                    let paragraphStyle = NSMutableParagraphStyle()
                    attributes[.paragraphStyle] = paragraphStyle
                    return paragraphStyle
                }
            }
            set {
                attributes[.paragraphStyle] = newValue
            }
        }
        
        @objc
        public dynamic var attributedLineSpacing: CGFloat {
            get {
                return paragraphStyle.lineSpacing
            }
            set {
                paragraphStyle.lineSpacing = newValue
            }
        }
        
        open override var intrinsicContentSize: CGSize {
            var size = super.intrinsicContentSize
            size.width += textInsets.right + textInsets.left + intrinsicContentInsets.width * 2
            size.height += textInsets.top + textInsets.bottom + intrinsicContentInsets.height * 2
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
        }
        
        open override func drawText(in rect: CGRect) {
            super.drawText(in: rect.inset(by: textInsets))
        }
        
        open override var text: String? {
            get {
                return attributedText?.string ?? super.text
            }
            set {
                if let newValue = newValue, attributes.count > 0 {
                    attributedText = NSAttributedString(string: newValue, attributes: attributes)
                } else {
                    super.text = newValue
                }
            }
        }
        
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

