//
//  LayoutBuilder.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 22/04/2021.
//

import Foundation

@resultBuilder
public struct LayoutBuilder {
    
    public typealias Expression = SomeView
    public typealias Component = [SomeView]
    
    public static func buildBlock(_ layouts: Component...) -> Component {
        layouts.flatMap { $0 }
    }
    
    public static func buildExpression(_ layout: Expression) -> Component {
        [layout]
    }
    
    public static func buildExpression(_ layouts: Component) -> Component {
        layouts
    }
    
    public static func buildIf(_ layouts: Component?) -> Component {
        layouts ?? []
    }
    
    public static func buildEither(first layout: Component) -> Component {
        layout
    }
    
    public static func buildEither(second layout: Component) -> Component {
        layout
    }
}
