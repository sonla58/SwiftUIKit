//
//  Styles.swift
//  SwiftUIKit-Example
//
//  Created by finos.son.le on 22/04/2021.
//

import UIKit
import SwiftUIKit

extension UI.ViewStyle {
    struct Card1: Stylable {
        func style(_ base: UIView) {
            base.dx.style(CornerRadius(radius: 8))
            base.dx.style(Shadow(color: .black, offset: .zero, radius: 10, opacity: 0.1))
        }
    }
    
    struct Card2: Stylable {
        func style(_ base: UIView) {
            base.dx.style(CornerRadius(radius: 12))
            base.dx.style(Shadow(color: .black, offset: .zero, radius: 8, opacity: 0.28))
        }
    }
}
