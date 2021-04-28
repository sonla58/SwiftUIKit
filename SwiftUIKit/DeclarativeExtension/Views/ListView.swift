//
//  ListView.swift
//  SwiftUIKit
//
//  Created by Anh Son Le on 26/04/2021.
//

import UIKit

open class ListView: UITableView {
//    public var layouts: [SomeView]
    public var layoutBag = LayoutBag()
    public var sections: [SectionList]
    
    required public init(_ style: UITableView.Style, layouts: [SomeView]) {
        self.sections = [
            SectionList(cellBuilder: { () -> [SomeView] in
                return layouts
            })
        ]
        
        super.init(frame: .zero, style: style)
        
        self.setup()
        self.defineLayout()
    }
    
    required public init(_ style: UITableView.Style, @LayoutBuilder layoutBuilder: () -> [SomeView]) {
        let layouts = layoutBuilder()
        self.sections = [
            SectionList(cellBuilder: { () -> [SomeView] in
                return layouts
            })
        ]
        
        super.init(frame: .zero, style: style)
        
        self.setup()
        self.defineLayout()
    }
    
    required public init<Item>(_ style: UITableView.Style, items: [Item], @LayoutBuilder layoutBuilder: (_ index: Int, _ item: Item) -> [SomeView]) {
        
        let layouts = items.enumerated()
            .reduce([SomeView](), { (seed, next) -> [SomeView] in
                seed + layoutBuilder(next.offset, next.element)
            })
        self.sections = [
            SectionList(cellBuilder: { () -> [SomeView] in
                return layouts
            })
        ]
        
        super.init(frame: .zero, style: style)
        
        self.setup()
        self.defineLayout()
    }
    
    required public init(_ style: UITableView.Style, sections: [SectionList]) {
        self.sections = sections
        
        super.init(frame: .zero, style: style)
        
        self.setup()
        self.defineLayout()
    }
    
    required public init(_ style: UITableView.Style, @SectionListBuilder sectionBuilder: () -> [SectionList]) {
        self.sections = sectionBuilder()
        
        super.init(frame: .zero, style: style)
        
        self.setup()
        self.defineLayout()
    }
    
    required public init<Item>(_ style: UITableView.Style, items: [Item], @SectionListBuilder sectionBuilder: (_ index: Int, _ item: Item) -> [SectionList]) {
        
        let sections = items.enumerated()
            .reduce([SectionList](), { (seed, next) -> [SectionList] in
                seed + sectionBuilder(next.offset, next.element)
            })
        self.sections = sections
        
        super.init(frame: .zero, style: style)
        
        self.setup()
        self.defineLayout()
    }
    
    private func setup() {
        self.register(StaticCell.self, forCellReuseIdentifier: String(describing: StaticCell.self))
        self.delegate = self
        self.dataSource = self
        
        self.sectionHeaderHeight = UITableView.automaticDimension;
        self.estimatedSectionHeaderHeight = 44;
        
        self.defineLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("Not support init from coder")
    }
    
    public func defineLayout() {
//        layoutBag.append(group(layouts).layout(in: self))
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        guard let superview = superview else { return }
        
        if #available(iOS 11.0, *) {
            // safeAreaLayoutGuide is already available
        } else {
            NSLayoutConstraint.activate([
                ___safeAreaLayoutGuide.topAnchor.constraint(equalTo: superview.___safeAreaLayoutGuide.topAnchor),
                ___safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: superview.___safeAreaLayoutGuide.bottomAnchor)
            ])
        }
    }
}

public class StaticCell: UITableViewCell {
    
    var content: SomeView
    
    public required init(_ content: SomeView) {
        self.content = content
        super.init(style: .default, reuseIdentifier: String(describing: Self.self))
        
        content.layout(in: contentView)
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
}

extension ListView: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if sections[section].headerView.isEmpty {
            return nil
        }
        return ZStackView {
            group(sections[section].headerView)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if sections[section].headerView.isEmpty {
            return 0
        }
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if sections[section].footerView.isEmpty {
            return nil
        }
        return ZStackView {
            group(sections[section].footerView)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if sections[section].footerView.isEmpty {
            return 0
        }
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let layout = sections[indexPath.section].cells[indexPath.row]
        if let layout = layout as? UITableViewCell {
            return layout
        }
        return StaticCell(layout)
    }
}

public class SectionList {
    
    var headerView: [SomeView]
    var footerView: [SomeView]
    var cells: [SomeView]
    
    public init(
        @LayoutBuilder headerViewBuilder: () -> [SomeView] = { return [] },
        @LayoutBuilder footerViewBuilder: () -> [SomeView] = { return [] },
        @LayoutBuilder cellBuilder: () -> [SomeView]
    ) {
        self.headerView = headerViewBuilder()
        self.footerView = footerViewBuilder()
        self.cells = cellBuilder()
    }
    
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
