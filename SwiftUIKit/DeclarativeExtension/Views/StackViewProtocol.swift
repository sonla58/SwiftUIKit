//
//  StackViewProtocol.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 22/04/2021.
//

import UIKit

public protocol StackViewProtocol: View {
    var axis: NSLayoutConstraint.Axis { get set }
    var distribution: UIStackView.Distribution { get set }
    var spacing: CGFloat { get set }
    var alignment: UIStackView.Alignment { get set }
    var configure: (UIStackView) -> Void { get set }
    var layouts: [SomeView] { get set }
}

public extension StackViewProtocol {
    func makeViewNode(_ compositeRevertable: LayoutRevertable) -> UIStackView {
        stack(layouts, axis: axis, spacing: spacing, distribution: distribution, alignment: alignment, configure: configure)
            .makeViewNode(compositeRevertable)
    }
}
