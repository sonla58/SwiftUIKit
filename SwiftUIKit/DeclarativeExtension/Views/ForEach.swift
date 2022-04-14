//
//  ForEach.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 22/04/2021.
//

import Foundation

public struct ForEach<Data> where Data: RandomAccessCollection {
    public var layouts: [SomeView]
    public var items: Data
    
    public init(_ items: Data, layouts: [SomeView]) {
        self.items = items
        self.layouts = layouts
    }
    
    public init(_ items: Data, @LayoutBuilder layoutBuilder: (Int, Data.Element) -> [SomeView]) {
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
