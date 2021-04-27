//
//  ListView.swift
//  SwiftUIKit
//
//  Created by Anh Son Le on 26/04/2021.
//

import UIKit

public class ListView: UITableView {
    public var layouts: [SomeView]
    public var layoutBag = LayoutBag()
    
    required public init(_ style: UITableView.Style, layouts: [SomeView]) {
        self.layouts = layouts
        
        super.init(frame: .zero, style: style)
        
        self.setup()
        self.defineLayout()
    }
    
    required public init(_ style: UITableView.Style, @LayoutBuilder layoutBuilder: () -> [SomeView]) {
        self.layouts = layoutBuilder()
        
        super.init(frame: .zero, style: style)
        
        self.setup()
        self.defineLayout()
    }
    
    required public init<Item>(_ style: UITableView.Style, items: [Item], @LayoutBuilder layoutBuilder: (_ index: Int, _ item: Item) -> [SomeView]) {
        
        self.layouts = items.enumerated()
            .reduce([SomeView](), { (seed, next) -> [SomeView] in
                seed + layoutBuilder(next.offset, next.element)
            })
        
        super.init(frame: .zero, style: style)
        
        self.setup()
        self.defineLayout()
    }
    
    private func setup() {
        self.register(StaticCell.self, forCellReuseIdentifier: String(describing: StaticCell.self))
//        layouts
//            .compactMap { (v) -> UITableViewCell? in
//                v as? UITableViewCell
//            }
//            .forEach { (cell) in
//                self.register(type(of: cell).self, forCellReuseIdentifier: String(describing: type(of: cell).self))
//            }
        self.delegate = self
        self.dataSource = self
        self.defineLayout()
    }
    
    required init?(coder: NSCoder) {
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
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return layouts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let layout = layouts[indexPath.row]
        if let layout = layout as? UITableViewCell {
            return layout
        }
        return StaticCell(layouts[indexPath.row])
    }
}
