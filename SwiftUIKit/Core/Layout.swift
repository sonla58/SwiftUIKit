//
//  Layout.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 20/04/2021.
//

import UIKit

public struct Layout<Node: ViewNode>: View {
    private let nodeGenerator: (LayoutRevertable) -> Node
    
    public init(_ generate: @escaping (LayoutRevertable) -> Node) {
        nodeGenerator = generate
    }
    
    public func makeViewNode(_ compositteRevertable: LayoutRevertable) -> Node {
        nodeGenerator(compositteRevertable)
    }
    
    public static func just(_ node: Node) -> Layout<Node> {
        return Layout { _ in node }
    }
}

public struct EmptyLayout: View {
    public init() { }
    
    public func makeViewNode(_ compositteRevertable: LayoutRevertable) -> Layout<EmptyNode> {
        return Layout.just(EmptyNode())
    }
}
