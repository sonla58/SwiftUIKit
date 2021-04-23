//
//  Style.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 20/04/2021.
//

import Foundation

public protocol Stylable {
    associatedtype Base
    func style(_ base: Base)
}

extension Declarative {
    @discardableResult
    public func style(_ styleBlock: (Base) -> Void) -> Base {
        styleBlock(base)
        return base
    }
    
    @discardableResult
    public func style<StyleType: Stylable>(_ style: StyleType...) -> Base {
        style.forEach { (e) in
            if let base = base as? StyleType.Base {
                e.style(base)
            }
        }
        return base
    }
}
