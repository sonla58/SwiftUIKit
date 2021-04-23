//
//  ZStackView.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 22/04/2021.
//

import UIKit

public class ZStackView: UI.View {
    public var layouts: [SomeView]
    
    required public init(_ layouts: [SomeView]) {
        self.layouts = layouts
        
        super.init(frame: .zero)
    }
    
    required public init(@LayoutBuilder _ layoutBuilder: () -> [SomeView]) {
        self.layouts = layoutBuilder()
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var subviewsLayout: SomeView {
        group(layouts)
    }
}

//public struct ZStackView {
//    public var layouts: [SomeView]
//    public var container: UIView
//
//    public init(_ container: UIView = UIView(), configure: @escaping (UIView) -> Void = {_ in}, layouts: [SomeView]) {
//        self.container = container
//        configure(container)
//        self.layouts = layouts
//    }
//
//    public init(_ container: UIView = UIView(), configure: @escaping (UIView) -> Void = {_ in}, @LayoutBuilder layoutBuilder: () -> [SomeView]) {
//        self.container = container
//        configure(container)
//        self.layouts = layoutBuilder()
//    }
//}
//
//extension ZStackView: View {
//    public func makeViewNode(_ compositeRevertable: LayoutRevertable) -> UIView {
//        group(layouts)
//            .embedding(in: container)
//            .makeViewNode(compositeRevertable)
//    }
//}
