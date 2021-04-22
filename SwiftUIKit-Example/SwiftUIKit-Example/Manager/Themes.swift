//
//  Themes.swift
//  SwiftUIKit-Example
//
//  Created by finos.son.le on 22/04/2021.
//

import UIKit

class Theme {
    var background1 = UIColor(hex: "FFFFFF")
    var background2 = UIColor(hex: "F8F9FA")
    
    var text1 = UIColor(hex: "343A40")
    var text2 = UIColor(hex: "868E96")
    
    var contrastText1 = UIColor(hex: "FFFFFF")
    var contrastText2 = UIColor(hex: "FFFCF9")
    
    var secondary2 = UIColor(hex: "FFD6B2")
    var secondary = UIColor(hex: "FFB16E")
    var primary = UIColor(hex: "7C4737")
    
    var box1 = UIColor(hex: "8EBEA4")
    var box2 = UIColor(hex: "DDDBAA")
    var box3 = UIColor(hex: "F5C137")
    var box4 = UIColor(hex: "AFB3D5")
}

class ThemeManager {
    static var shared = ThemeManager()
    
    private init() { }
    
    private(set) var current: Theme = Theme()
    
    func active(theme: Theme) {
        self.current = theme
        // TODO: - notify to reload UI
    }
}

extension UIColor {
    convenience init(hex: String) {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0
        var hex: String = hex

        if hex.hasPrefix("#") {
            let index = hex.index(hex.startIndex, offsetBy: 1)
            hex = String(hex[index...])
        }

        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch (hex.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                //"Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8
                break
            }
        }
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
