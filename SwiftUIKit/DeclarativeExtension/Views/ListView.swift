//
//  ListView.swift
//  SwiftUIKit
//
//  Created by Anh Son Le on 26/04/2021.
//

import UIKit

open class ListView: UITableView {
    
    public var layoutBag = LayoutBag()
    public var sections: [SectionList]
    
    //========================================
    //MARK: - Set of init function to create `ListView` with cell layut
    //========================================
    
    /// Initialize a ListView (UITableView in UIKit) with a array of cell layout
    /// - Parameters:
    ///   - style: Style of UITableView, see `UITableView.Style`
    ///   - layouts: Array of layout, each element of it should be a `UIView`, `ZStackView` or a `UITableViewCell`
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
    
    /// Initialize a ListView (UITableView in UIKit) with a cell builder
    /// - Parameters:
    ///   - style: Style of UITableView, see `UITableView.Style`
    ///   - layoutBuilder: a function builder to build array of layout, each element of it should be a `UIView`, `ZStackView`, `UITableViewCell`
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
    
    /// Initialize a ListView (UITableView in UIKit) with a cell builder to build layout from datasource you provided
    /// - Parameters:
    ///   - style: Style of UITableView, see `UITableView.Style`
    ///   - items: Datasource used to build cells
    ///   - layoutBuilder:  function builder to build array of layout from datasource you provide in `items`, each element of it should be a `UIView`, `ZStackView`, `UITableViewCell`
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
    
    //========================================
    //MARK: - Set of init function to create `ListView` with section
    //========================================
    
    /// Initialize a ListView (UITableView in UIKit) with a array of section
    /// - Parameters:
    ///   - style: Style of UITableView, see `UITableView.Style`
    ///   - sections: Array of `SectionList`
    required public init(_ style: UITableView.Style, sections: [SectionList]) {
        self.sections = sections
        
        super.init(frame: .zero, style: style)
        
        self.setup()
        self.defineLayout()
    }
    
    /// Initialize a ListView (UITableView in UIKit) with a section builder
    /// - Parameters:
    ///   - style: Style of UITableView, see `UITableView.Style`
    ///   - sectionBuilder: a function builder to build array of `SectionList`
    required public init(_ style: UITableView.Style, @SectionListBuilder sectionBuilder: () -> [SectionList]) {
        self.sections = sectionBuilder()
        
        super.init(frame: .zero, style: style)
        
        self.setup()
        self.defineLayout()
    }
    
    /// Initialize a ListView (UITableView in UIKit) with a section builder
    /// - Parameters:
    ///   - style: Style of UITableView, see `UITableView.Style`
    ///   - items: Datasource used to build cells
    ///   - sectionBuilder: a function builder to build array of `SectionList` from datasource you provide in `items`
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
    
    //========================================
    //MARK: - Set of init function to create `ListView` with reuse cell
    //========================================
    
    //========================================
    //MARK: - Private func to setup and do its work
    //========================================
    
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
        //
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

//MARK: - StaticCell

public class StaticCell: UITableViewCell {
    
    var content: SomeView
    
    /// Initialize StaticCell with a `SwiftUIKit.View`.
    /// - Parameter content: Content layout view will be add to Static Cell. You should layout content to its parent like: .fillingParent()
    public required init(_ content: SomeView) {
        self.content = content
        super.init(style: .default, reuseIdentifier: String(describing: Self.self))
        
        content.layout(in: contentView)
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
}

//MARK: - Conform ListView to: `UITableViewDelegate` and `UITableViewDataSource`

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
