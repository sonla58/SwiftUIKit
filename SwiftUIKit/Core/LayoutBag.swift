//
//  LayoutBag.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 20/04/2021.
//

// Copyright (c) 2018 Srdan Rasic (@srdanrasic). See https://github.com/DeclarativeHub/Layoutless

import Foundation

public protocol LayoutRevertable {
    func append(_ revertable: LayoutRevertable)
    func revert()
}

public class LayoutBag: LayoutRevertable {
    
    private var revertables: [LayoutRevertable] = []
    
    public init() { }
    
    public func revert() {
        revertables.forEach { $0.revert() }
    }
    
    public func append(_ revertable: LayoutRevertable) {
        revertables.append(revertable)
    }
    
    public func append(_ revertables: [LayoutRevertable]) {
        self.revertables.append(contentsOf: revertables)
    }
}

public class BlockRevertable: LayoutRevertable {
    
    private var revertBlockes: [(() -> Void)] = []
    
    init(_ block: @escaping () -> Void) {
        self.revertBlockes = [block]
    }
    
    public func revert() {
        revertBlockes.forEach { $0() }
    }
    
    public func append(_ revertable: LayoutRevertable) {
        self.revertBlockes.append(revertable.revert)
    }
    
}
