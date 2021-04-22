//
//  TraitQueryLayoutSet.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 22/04/2021.
//

import Foundation
import UIKit

public class TraitQueryLayoutSet: ViewNode {

    public let layouts: [TraitQuery: SomeView]

    private weak var container: UIView?
    private var revertable: LayoutRevertable?
    private var parentRevertable: LayoutRevertable
    private var previousLayoutKey: TraitQuery?

    public init(_ layouts: [TraitQuery: SomeView], revertable: LayoutRevertable) {
        self.layouts = layouts
        self.parentRevertable = revertable
    }

    public func layout(in container: UIView) -> LayoutRevertable {
        self.container = container
        container.___associatedObjects.append(self)
        updateLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeTraitCollection), name: .windowTraitCollectionDidChange, object: nil)
        let revertable = LayoutBag()
        revertable.append(BlockRevertable({ [weak self] in
            guard let self = self else { return }
            self.container = nil
            self.revertable?.revert()
            NotificationCenter.default.removeObserver(self)
        }))
        parentRevertable.append(revertable)
        return revertable
    }

    @objc func didChangeTraitCollection() {
        updateLayout()
    }

    private func updateLayout() {
        guard let container = container else { return }
        let window = (container.window ?? UIApplication.shared.keyWindow)
        let windowTraitCollection = window?.windowTraitCollection ?? WindowTraitCollection(traitCollection: UIScreen.main.traitCollection, size: UIScreen.main.bounds.size)
        if let layout = layouts.first(where: { windowTraitCollection.matches($0.key) }) {
            guard previousLayoutKey != layout.key else { return }
            previousLayoutKey = layout.key
            revertable?.revert()
            revertable = layout.value.layout(in: container)
        }
    }
}

/// Define a set of layouts based on trait queries.
public func layoutSet(_ layouts: [TraitQuery: SomeView]) -> Layout<TraitQueryLayoutSet> {
    return Layout { revertable in
        return TraitQueryLayoutSet(layouts, revertable: revertable)
    }
}

public func layoutSet(_ layouts: (TraitQuery, SomeView)...) -> Layout<TraitQueryLayoutSet> {
    return Layout { revertable in
        return TraitQueryLayoutSet(Dictionary(layouts, uniquingKeysWith: { a, _ in a }), revertable: revertable)
    }
}

public func traitQuery(width: Length, layout: () -> SomeView) -> (TraitQuery, SomeView) {
    return (TraitQuery(width: width), layout())
}

public func traitQuery(height: Length, layout: () -> SomeView) -> (TraitQuery, SomeView) {
    return (TraitQuery(height: height), layout())
}

public func traitQuery(width: Length, height: Length, layout: () -> SomeView) -> (TraitQuery, SomeView) {
    return (TraitQuery(width: width, height: height), layout())
}

public func traitQuery(traitCollection: UITraitCollection, width: Length? = nil, height: Length? = nil, layout: @escaping () -> SomeView) -> (TraitQuery, SomeView) {
    return (TraitQuery(traitCollection: traitCollection, width: width, height: height), layout())
}
