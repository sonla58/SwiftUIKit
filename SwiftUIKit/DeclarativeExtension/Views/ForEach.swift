//
//  ForEach.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 22/04/2021.
//

import Foundation

public struct ForEach<Item> {
    public var layouts: [SomeView]
    public var items: [Item]
    
    public init(_ items: [Item], layouts: [SomeView]) {
        self.items = items
        self.layouts = layouts
    }
    
    public init(_ items: [Item], @LayoutBuilder layoutBuilder: (Int, Item) -> [SomeView]) {
        self.items = items
        self.layouts = items.enumerated().reduce([SomeView](), { (seed, next) -> [SomeView] in
            seed + layoutBuilder(next.offset, next.element)
        })
    }
}

extension ForEach: View {
    public func makeViewNode(_ compositeRevertable: LayoutRevertable) -> ViewGroup {
        group(layouts)
            .makeViewNode(compositeRevertable)
    }
}
