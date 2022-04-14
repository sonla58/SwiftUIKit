//
//  LayoutBuilder.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 22/04/2021.
//

import Foundation

@resultBuilder
public struct LayoutBuilder {
    
    public typealias Component = [SomeView]
    
    public static func buildBlock(_ layouts: Component...) -> Component {
        layouts.flatMap { $0 }
    }
    
    public static func buildExpression(_ layout: SomeView) -> Component {
        [layout]
    }
    
    public static func buildExpression(_ layouts: Component) -> Component {
        layouts
    }
    
    public static func buildIf(_ layouts: Component?) -> Component {
        layouts ?? []
    }
    
    public static func buildOptional(_ layout: Component?) -> Component {
        layout ?? []
    }
    
    public static func buildEither(first: Component) -> Component {
        first
    }
    
    public static func buildEither(second: Component) -> Component {
        second
    }
}
