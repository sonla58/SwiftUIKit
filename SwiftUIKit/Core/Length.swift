//
//  Length.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 20/04/2021.
//

// Copyright (c) 2018 Srdan Rasic (@srdanrasic). See https://github.com/DeclarativeHub/Layoutless

import UIKit

/// A type that represents a spatial dimension like width, height, inset, offset, etc.
/// Expressible by float or integer literal.
public enum Length: Hashable, ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {

    case exactly(CGFloat)
    case greaterThanOrEqualTo(CGFloat)
    case lessThanOrEqualTo(CGFloat)

    public init(floatLiteral value: Float) {
        self = .exactly(CGFloat(value))
    }

    public init(integerLiteral value: Int) {
        self = .exactly(CGFloat(value))
    }

    public var cgFloatValue: CGFloat {
        switch self {
        case .exactly(let value):
            return value
        case .greaterThanOrEqualTo(let value):
            return value
        case .lessThanOrEqualTo(let value):
            return value
        }
    }
}

extension Length {

    public func constrain<Type>(_ lhs: NSLayoutAnchor<Type>, to rhs: NSLayoutAnchor<Type>) -> NSLayoutConstraint {
        switch self {
        case .exactly(let value):
            return lhs.constraint(equalTo: rhs, constant: CGFloat(value))
        case .lessThanOrEqualTo(let value):
            return lhs.constraint(lessThanOrEqualTo: rhs, constant: CGFloat(value))
        case .greaterThanOrEqualTo(let value):
            return lhs.constraint(greaterThanOrEqualTo: rhs, constant: CGFloat(value))
        }
    }

    public func constrainToConstant(_ lhs: NSLayoutDimension) -> NSLayoutConstraint {
        switch self {
        case .exactly(let value):
            return lhs.constraint(equalToConstant: CGFloat(value))
        case .lessThanOrEqualTo(let value):
            return lhs.constraint(lessThanOrEqualToConstant: CGFloat(value))
        case .greaterThanOrEqualTo(let value):
            return lhs.constraint(greaterThanOrEqualToConstant: CGFloat(value))
        }
    }
}

extension Length {

    public func satisfies(_ otherValue: CGFloat) -> Bool {
        switch self {
        case .exactly(let value):
            return otherValue == value
        case .greaterThanOrEqualTo(let value):
            return otherValue >= value
        case .lessThanOrEqualTo(let value):
            return otherValue <= value
        }
    }
}
