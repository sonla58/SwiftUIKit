//
//  ViewProtocol.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 20/04/2021.
//

import UIKit

public protocol SomeView: ViewNode {
    func makeSomeViewNode(_ compositeRevertable: LayoutRevertable) -> ViewNode
}

public protocol View: SomeView {
    associatedtype Node: ViewNode
    
    func makeViewNode(_ compositteRevertable: LayoutRevertable) -> Node
}

extension View {
    public func makeSomeViewNode(_ compositeRevertable: LayoutRevertable) -> ViewNode {
        return makeViewNode(compositeRevertable)
    }
}

extension SomeView {
    @discardableResult
    public func layout(in container: UIView) -> LayoutRevertable {
        let bag = LayoutBag()
        bag.append(makeSomeViewNode(bag).layout(in: container))
        return bag
    }
}
