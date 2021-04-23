//
//  HStackView.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 22/04/2021.
//

import UIKit

public class HStackView: UIStackView {
    public var configure: (UIStackView) -> Void = {_ in}
    
    public var layouts: [SomeView]
    
    public var layoutBag = LayoutBag()
    
    required public init(
        spacing: CGFloat = 0,
        distribution: UIStackView.Distribution = .fillEqually,
        alignment: UIStackView.Alignment = .fill,
        layouts: [SomeView]
    ) {
        self.layouts = layouts
        
        super.init(frame: .zero)
        
        self.axis = .horizontal
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = alignment
        
        defineLayout()
    }
    
    required public init(
        spacing: CGFloat = 0,
        distribution: UIStackView.Distribution = .fillEqually,
        alignment: UIStackView.Alignment = .fill,
        @LayoutBuilder layoutBuilder: () -> [SomeView]
    ) {
        self.layouts = layoutBuilder()
        
        super.init(frame: .zero)
        
        self.axis = .horizontal
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = alignment
        
        defineLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func defineLayout() {
        layouts.forEach { [weak self] (v) in
            guard let self = self else { return }
            self.layoutBag.append(v.layout(in: self))
        }
    }
}
