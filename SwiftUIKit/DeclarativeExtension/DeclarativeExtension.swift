//
//  DeclarativeExtension.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 22/04/2021.
//

import Foundation

@dynamicMemberLookup
public struct Declarative<Base> {
    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
    
    public subscript<T>(dynamicMember keyPath: WritableKeyPath<Base, T>) -> (T) -> Base {
        return { [base] value in
            var object = base
            object[keyPath: keyPath] = value
            return object
        }
    }
}

public protocol DeclarativeCompatible {
    associatedtype DeclarativeBase
    
    /// Declarative extension
    var dx: Declarative<DeclarativeBase> { get set }
}

extension DeclarativeCompatible {
    public var dx: Declarative<Self> {
        get {
            Declarative(self)
        }
        
        // swiftlint:disable:next unused_setter_value
        set { }
    }
}

#if canImport(Foundation)
import Foundation

extension NSObject: DeclarativeCompatible {}
#endif

extension Declarative where Base: AnyObject {
    @discardableResult
    public func storeReference(refStore: inout Base?) -> Base {
        if refStore != nil {
            return refStore!
        }
        refStore = base
        return base
    }
}
