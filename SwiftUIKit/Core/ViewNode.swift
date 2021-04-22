//
//  ViewNode.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 20/04/2021.
//

import UIKit

public protocol ViewNode {
    @discardableResult
    func layout(in container: UIView) -> LayoutRevertable
}

public struct EmptyNode: ViewNode {
    public init() {}
    public func layout(in container: UIView) -> LayoutRevertable { LayoutBag() }
}

/// A decorator over child layout node that provides a way for the child to layout itself
/// with the respect to the parent it will eventually be added to.
public class ChildNode<Child: ViewNode>: ViewNode, Anchorable where Child: Anchorable {

    public let child: Child
    public let layout: (UIView) -> LayoutRevertable

    public init(_ child: Child, layout: @escaping (UIView, Child, LayoutRevertable) -> Void) {
        self.child = child
        self.layout = { container in
            let revertable = child.layout(in: container)
            layout(container, child, revertable)
            return revertable
        }
    }

    public func layout(in container: UIView) -> LayoutRevertable {
        return layout(container)
    }

    public var leadingAnchor: NSLayoutXAxisAnchor { return child.leadingAnchor }
    public var trailingAnchor: NSLayoutXAxisAnchor { return child.trailingAnchor }
    public var leftAnchor: NSLayoutXAxisAnchor { return child.leftAnchor }
    public var rightAnchor: NSLayoutXAxisAnchor { return child.rightAnchor }
    public var topAnchor: NSLayoutYAxisAnchor { return child.topAnchor }
    public var bottomAnchor: NSLayoutYAxisAnchor { return child.bottomAnchor }
    public var widthAnchor: NSLayoutDimension { return child.widthAnchor }
    public var heightAnchor: NSLayoutDimension { return child.heightAnchor }
    public var centerXAnchor: NSLayoutXAxisAnchor { return child.centerXAnchor }
    public var centerYAnchor: NSLayoutYAxisAnchor { return child.centerYAnchor }
}
