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
            let r = right?.constrain(parent.rightAnchor, to: node.rightAnchor)
            let t = top?.constrain(node.topAnchor, to: parent.topAnchor)
            let b = bottom?.constrain(parent.bottomAnchor, to: node.bottomAnchor)
            
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

extension View where Node: Anchorable {

    public func scrolling<ScrollView: UIScrollView>(scrollViewType: ScrollView.Type, layoutToScrollViewParent: @escaping (Layout<Node>) -> Layout<ChildNode<Node>>, configure: @escaping (ScrollView) -> Void = { _ in }) -> Layout<ChildNode<ScrollView>> {
        return Layout { revertable in
            return ChildNode(ScrollView()) { container, scrollView, childRevertable in
                revertable.append(childRevertable)
                scrollView.delaysContentTouches = true
                configure(scrollView)
                let layoutNode = self.fillingParent().makeViewNode(revertable)
                childRevertable.append(
                    layoutToScrollViewParent(Layout.just(layoutNode.child)).makeViewNode(childRevertable)
                        .layout(in: container)
                )
                childRevertable.append(
                    layoutNode.layout(in: scrollView)
                )
            }
        }
    }

    /// Embed the node in a custom scroll view that should scroll in the given direction. Optionally pass in the closure to setup the scroll view.
    public func scrolling<ScrollView: UIScrollView>(scrollViewType: ScrollView.Type, direction: NSLayoutConstraint.Axis, configure: @escaping (UIScrollView) -> Void = { _ in }) -> Layout<ChildNode<ScrollView>> {
        switch direction {
        case .vertical:
            return scrolling(
                scrollViewType: scrollViewType,
                layoutToScrollViewParent: { $0.stickingToParentEdges(left: 0, right: 0) },
                configure: configure
            )
        case .horizontal:
            return scrolling(
                scrollViewType: scrollViewType,
                layoutToScrollViewParent: { $0.stickingToParentEdges(top: 0, bottom: 0) },
                configure: configure
            )
        @unknown default:
            fatalError("Layoutless supports only vertical or horizontal scrolling.")
        }
    }

    /// Embed the node in a scroll view that should scroll in the given direction. Optionally pass in the closure to setup the scroll view.
    public func scrolling(_ direction: NSLayoutConstraint.Axis, configure: @escaping (UIScrollView) -> Void = { _ in }) -> Layout<ChildNode<UIScrollView>> {
        return scrolling(scrollViewType: UIScrollView.self, direction: direction, configure: configure)
    }
}

// MARK: Embedding

extension View {

    /// Embed the node in the given view and return the layout that has the given view as a root node.
    public func embedding<Embed: UIView>(in view: Embed) -> Layout<Embed> {
        return Layout { revertable in
            revertable.append(self.makeViewNode(revertable).layout(in: view))
            return view
        }
    }
}

extension View where Node: UIView {

    /// Add the given view as a subview of the node and return the layout that has the node as a root node.
    public func addingSubview(_ subview: Node) -> Layout<Node> {
        return Layout { revertable in
            let node = self.makeViewNode(revertable)
            revertable.append(subview.layout(in: node))
            return node
        }
    }

    /// Layout the given layout within the node and return the layout that has the node as a root node.
    public func addingLayout(_ layout: SomeView) -> Layout<Node> {
        return Layout { revertable in
            let node = self.makeViewNode(revertable)
            revertable.append(layout.makeSomeViewNode(revertable).layout(in: node))
            return node
        }
    }
}

// MARK: Stacking

/// Stack an array of views in a stack view.
public func stack(_ views: [SomeView], axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0, distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill, configure: @escaping (UIStackView) -> Void = { _ in }) -> Layout<UIStackView> {
    return Layout { revertable in
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.distribution = distribution
        stackView.alignment = alignment
        views.forEach {
            revertable.append($0.layout(in: stackView))
        }
        configure(stackView)
        return stackView
    }
}

/// Stack an array of views in a stack view.
public func stack(_ axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0, distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill, configure: @escaping (UIStackView) -> Void = { _ in }) -> ((SomeView...) -> Layout<UIStackView>) {
    return { (views: SomeView...) -> Layout<UIStackView> in
        return stack(views, axis: axis, spacing: spacing, distribution: distribution, alignment: alignment, configure: configure)
    }
}

// MARK: Grouping

public class ViewGroup: ViewNode {

    private let layouts: [SomeView]

    public init(_ layouts: [SomeView]) {
        self.layouts = layouts
    }

    public func layout(in container: UIView) -> LayoutRevertable {
        let revertable = LayoutBag()
        layouts.forEach { revertable.append($0.layout(in: container)) }
        return revertable
    }
}

/// Group an array of layouts that should be laid out in the same container.
public func group(_ layouts: [SomeView]) -> Layout<ViewGroup> {
    return Layout { revertable in
        return ViewGroup(layouts)
    }
}

/// Group an array of layouts that should be laid out in the same container.
public func group(_ layouts: SomeView...) -> Layout<ViewGroup> {
    return group(layouts)
}

// MARK: Configuring intrinsic size behaviour

extension View where Node: UIView {

    /// Modify the node's hugging priority for the given axis.
    public func settingHugging(_ priority: UILayoutPriority, axis: NSLayoutConstraint.Axis) -> Layout<Node> {
        return Layout { revertable in
            let node = self.makeViewNode(revertable)
            let oldValue = node.contentHuggingPriority(for: axis)
            node.setContentHuggingPriority(priority, for: axis)
            revertable.append(BlockRevertable({
                node.setContentHuggingPriority(oldValue, for: axis)
            }))
            return node
        }
    }

    /// Modify the node's compression resistance priority for the given axis.
    public func settingCompressionResistance(_ priority: UILayoutPriority, axis: NSLayoutConstraint.Axis) -> Layout<Node> {
        return Layout { revertable in
            let node = self.makeViewNode(revertable)
            let oldValue = node.contentCompressionResistancePriority(for: axis)
            node.setContentCompressionResistancePriority(priority, for: axis)
            revertable.append(BlockRevertable({
                node.setContentCompressionResistancePriority(oldValue, for: axis)
            }))
            return node
        }
    }
}
