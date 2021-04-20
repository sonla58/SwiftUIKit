//
//  Style.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 20/04/2021.
//

import Foundation

public protocol Stylable {
    associatedtype Base
    
    func style() -> Base
}
