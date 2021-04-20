//
//  LayoutFunction.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 20/04/2021.
//

import UIKit

//MARK: - Hiererchy based layout

extension View where Node: Anchorable {
    public func layout(toDescendent descendent: Anchorable, maker: @escaping (Anchorable, Node) -> Void) -> Layout<Node> {
        Layout { (revertable) in
            let node = self.makeViewNode(revertable)
            maker(descendent, node)
            return node
        }
    }
    
    public func layout(inParentWithMaker maker: @escaping (Anchorable, Node, LayoutRevertable) -> Void) -> Layout<ChildNode<Node>> {
        return Layout<ChildNode<Node>>.init { (revertable) -> ChildNode<Node> in
            return ChildNode<Node>.init(self.makeViewNode(revertable), layout: maker)
        }
    }
    
    public func layout(inParentSafeArea safeArea: Bool, maker: @escaping (Anchorable, Node, LayoutRevertable) -> Void) -> Layout<ChildNode<Node>> {
            return Layout { parentRevertable in
                return ChildNode(self.makeViewNode(parentRevertable)) { parent, node, revertable in
                    parentRevertable.append(revertable)
                    if safeArea {
                        if #available(iOS 11.0, *) {
                            maker(parent.safeAreaLayoutGuide, node, revertable)
                        } else {
                            maker(parent.___safeAreaLayoutGuide, node, revertable)
                        }
                    } else {
                        maker(parent, node, revertable)
                    }
                }
            }
        }
}

//MARK: - Sizing

extension View where Node: Anchorable {
    public func sizing(width: Length? = nil, height: Length? = nil) -> Layout<Node> {
        return Layout { (revertable) in
            let node = self.makeViewNode(revertable)
            
            let cstWidth = width?.constrainToConstant(node.widthAnchor)
            let cstHeight = height?.constrainToConstant(node.heightAnchor)
            [cstWidth, cstHeight]
                .compactMap { $0 }
                .forEach { (cst) in
                    cst.isActive = true
                    revertable.append(BlockRevertable({
                        cst.isActive = false
                    }))
                }
            
            return node
        }
    }
    
    public func constrainingAspectRatio(ratio: CGFloat) -> Layout<Node> {
        return Layout { (revertable) in
            let node = self.makeViewNode(revertable)
            let constraint = node.widthAnchor.constraint(equalTo: node.heightAnchor, multiplier: ratio)
            constraint.isActive = true
            revertable.append(BlockRevertable({
                constraint.isActive = false
            }))
            return node
        }
    }
    
    public func sizing(toParentWithOffset widthOffset: Length? = 0, heightOffset: Length? = 0, relativeToSafeArea: Bool) -> Layout<ChildNode<Node>> {
        return layout(inParentSafeArea: relativeToSafeArea) { (parent, child, revertable) in
            let cstWidth = widthOffset?.constrain(child.widthAnchor, to: parent.widthAnchor)
            let cstHeight = heightOffset?.constrain(child.heightAnchor, to: parent.heightAnchor)
            [cstWidth, cstHeight]
                .compactMap { $0 }
                .forEach { (cst) in
                    cst.isActive = true
                    revertable.append(BlockRevertable({
                        cst.isActive = false
                    }))
                }
        }
    }
}

extension View where Node: Anchorable {
    public func centeringInParent(xOffset: Length? = 0, yOffset: Length? = 0, relativeToSafeArea: Bool) -> Layout<ChildNode<Node>> {
        return layout { (parent, node, revertable) in
            let cstXCenter = xOffset?.constrain(node.centerXAnchor, to: parent.centerXAnchor)
            let cstYCenter = yOffset?.constrain(node.centerYAnchor, to: parent.centerYAnchor)
            [cstXCenter, cstYCenter]
                .compactMap { $0 }
                .forEach { (cst) in
                    cst.isActive = true
                    revertable.append(BlockRevertable({
                        cst.isActive = false
                    }))
                }
        }
    }
    
    public func centeringVerticallyInParent(offset: Length = 0, relativeToSafeArea: Bool = false) -> Layout<ChildNode<Node>> {
        return centeringInParent(xOffset: nil, yOffset: offset, relativeToSafeArea: relativeToSafeArea)
    }
    
    /// Center the node horizontally within the parent using the given x-offset. Default offset is 0.
    public func centeringHorizontallyInParent(offset: Length = 0, relativeToSafeArea: Bool = false) -> Layout<ChildNode<Node>> {
        return centeringInParent(xOffset: offset, yOffset: nil, relativeToSafeArea: relativeToSafeArea)
    }
    
    /// Center the node vertically and horizontally within the parent using the given x- and y- offsets. Default offsets are 0.
    public func centeringInParent(xOffset: Length? = 0, yOffset: Length? = 0) -> Layout<ChildNode<Node>> {
        return centeringInParent(xOffset: xOffset, yOffset: yOffset, relativeToSafeArea: false)
    }
}

//MARK: - Filling and sticking to parent

extension View where Node: Anchorable {
    
    /// Constrain all four node's edges to the parent node's edges using the given insets.
    public func fillingParent(insets: CGFloat, relativeToSafeArea: Bool = false) -> Layout<ChildNode<Node>> {
        return stickingToParentEdges(left: .exactly(insets), right: .exactly(insets), top: .exactly(insets), bottom: .exactly(insets), relativeToSafeArea: relativeToSafeArea)
    }
    
    /// Constrain all four node's edges to the parent node's edges using the given insets.
    public func fillingParent(insets: UIEdgeInsets, relativeToSafeArea: Bool = false) -> Layout<ChildNode<Node>> {
        return stickingToParentEdges(left: .exactly(insets.left), right: .exactly(insets.right), top: .exactly(insets.top), bottom: .exactly(insets.bottom), relativeToSafeArea: relativeToSafeArea)
    }
    
    /// Constrain all four node's edges to the parent node's edges using the given insets. Default insets are 0.
    public func fillingParent(insets: (left: Length, right: Length, top: Length, bottom: Length) = (0, 0, 0, 0)) -> Layout<ChildNode<Node>> {
        return stickingToParentEdges(left: insets.left, right: insets.right, top: insets.top, bottom: insets.bottom, relativeToSafeArea: false)
    }
    
    /// Constrain all four node's edges to the parent node's edges using the given insets. Default insets are 0.
    public func fillingParent(insets: (left: Length, right: Length, top: Length, bottom: Length) = (0, 0, 0, 0), relativeToSafeArea: Bool) -> Layout<ChildNode<Node>> {
        return stickingToParentEdges(left: insets.left, right: insets.right, top: insets.top, bottom: insets.bottom, relativeToSafeArea: relativeToSafeArea)
    }
    
    /// Constrain node's edges to the parent node's edges using the given insets. Only edges with non-nil insets will be constrained! Default insets are nil.
    public func stickingToParentEdges(left: Length? = nil, right: Length? = nil, top: Length? = nil, bottom: Length? = nil) -> Layout<ChildNode<Node>> {
        return stickingToParentEdges(left: left, right: right, top: top, bottom: bottom, relativeToSafeArea: false)
    }
    
    /// Constrain node's edges to the parent node's edges using the given insets. Only edges with non-nil insets will be constrained! Default insets are nil.
    public func stickingToParentEdges(left: Length? = nil, right: Length? = nil, top: Length? = nil, bottom: Length? = nil, relativeToSafeArea: Bool) -> Layout<ChildNode<Node>> {
        return layout(inParentSafeArea: relativeToSafeArea) { (parent, node, revertable) in
            let l = left?.constrain(node.leftAnchor, to: parent.leftAnchor)
            let r = right?.constrain(node.rightAnchor, to: parent.rightAnchor)
            let t = top?.constrain(node.topAnchor, to: parent.topAnchor)
            let b = bottom?.constrain(node.bottomAnchor, to: parent.bottomAnchor)
            
            [l, r, t, b]
                .compactMap { $0 }
                .forEach { (cst) in
                    cst.isActive = true
                    revertable.append(BlockRevertable({
                        cst.isActive = false
                    }))
                }
        }
    }
}
