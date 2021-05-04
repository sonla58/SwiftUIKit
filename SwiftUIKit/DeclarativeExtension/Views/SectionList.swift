//
//  SectionList.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 29/04/2021.
//

import Foundation

/// `SectionList` represent a Section in UITableView. It provide header view, footer view and its cells, all represented as `SwiftUIKit.View`
public class SectionList {
    
    var headerView: [SomeView]
    var footerView: [SomeView]
    var cells: [SomeView]
    
    /// Initialize a `SectionList` with layout builder.
    /// - Parameters:
    ///   - headerViewBuilder: a function builder build a view for header, it will wrap in a UIView before add to header of section so your layout should anchor with parent like: fillingParent()
    ///   Example:
    ///   ```swift
    ///   ZStack {
    ///     ...
    ///   }
    ///   .fillingPrarent()
    ///   ```
    ///   - footerViewBuilder: a function builder build a view for footer, it will wrap in a UIView before add to footer of section so your layout should anchor with parent like: fillingParent()
    ///   Example:
    ///   ```swift
    ///   ZStack {
    ///     ...
    ///   }
    ///   .fillingPrarent()
    ///   ```
    ///   - cellBuilder: a function builder build list of static cell in section. If element not `UITableViewCell`, we'll add this it to a Empty Cell
    public init(
        @LayoutBuilder headerViewBuilder: () -> [SomeView] = { return [] },
        @LayoutBuilder footerViewBuilder: () -> [SomeView] = { return [] },
        @LayoutBuilder cellBuilder: () -> [SomeView]
    ) {
        self.headerView = headerViewBuilder()
        self.footerView = footerViewBuilder()
        self.cells = cellBuilder()
    }
    
    /// Initialize a `SectionList` with layout builder use datasource
    /// - Parameters:
    ///   - headerViewBuilder: a function builder build a view for header, it will wrap in a UIView before add to header of section so your layout should anchor with parent like: fillingParent()
    ///   Example:
    ///   ```swift
    ///   ZStack {
    ///     ...
    ///   }
    ///   .fillingPrarent()
    ///   ```
    ///   - footerViewBuilder: a function builder build a view for footer, it will wrap in a UIView before add to footer of section so your layout should anchor with parent like: fillingParent()
    ///   Example:
    ///   ```swift
    ///   ZStack {
    ///     ...
    ///   }
    ///   .fillingPrarent()
    ///   ```
    ///   - items: A datasource used to build cell
    ///   - cellBuilder: a function builder build list of static cell in section depend on your datasource that you provide in `items`. If element not `UITableViewCell`, we'll add this it to a Empty Cell
    public init<Item>(
        @LayoutBuilder headerViewBuilder: () -> [SomeView] = { return [] },
        @LayoutBuilder footerViewBuilder: () -> [SomeView] = { return [] },
        items: [Item],
        @LayoutBuilder cellBuilder: (_ index: Int, _ item: Item) -> [SomeView]
    ) {
        self.headerView = headerViewBuilder()
        self.footerView = footerViewBuilder()
        self.cells = items.enumerated().reduce([SomeView](), { (seed, next) -> [SomeView] in
            seed + cellBuilder(next.offset, next.element)
        })
    }
}
