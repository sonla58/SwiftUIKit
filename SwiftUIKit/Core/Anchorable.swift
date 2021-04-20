//
//  Anchorable.swift
//  SwiftUIKit
//
//  Created by son.le on 19/04/2021.
//

import UIKit

// Copyright (c) 2018 Srdan Rasic (@srdanrasic). See https://github.com/DeclarativeHub/Layoutless

/// A type whose instances provide basic layout anchors.
public protocol Anchorable {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}
