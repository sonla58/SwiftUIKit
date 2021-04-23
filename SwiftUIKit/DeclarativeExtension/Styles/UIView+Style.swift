//
//  UIView+Style.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 22/04/2021.
//

import UIKit

extension UI {
    public enum ViewStyle { }
}

extension UI.ViewStyle {
    public struct CornerRadius: Stylable {
        public var radius: CGFloat
        public var masks: CACornerMask
        
        public init(radius: CGFloat,
                    masks: CACornerMask = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner]) {
            self.radius = radius
            self.masks = masks
        }
        
        public func style(_ base: UIView) {
            base.layer.cornerRadius = radius
            base.layer.maskedCorners = masks
        }
    }
    
    public struct Border: Stylable {
        public let width: CGFloat
        public let color: UIColor
        
        public init(width: CGFloat, color: UIColor) {
            self.width = width
            self.color = color
        }
        
        public func style(_ base: UIView) {
            base.layer.borderWidth = width
            base.layer.borderColor = color.cgColor
        }
    }
    
    public struct Shadow: Stylable {
        public let color: UIColor
        public let offset: CGSize
        public let radius: CGFloat
        public let opacity: Float
        public var path: CGPath? = nil
        
        public init(color: UIColor, offset: CGSize, radius: CGFloat, opacity: Float, path: CGPath? = nil) {
            self.color = color
            self.offset = offset
            self.radius = radius
            self.opacity = opacity
            self.path = path
        }
        
        public func style(_ base: UIView) {
            base.layer.shadowColor = color.cgColor
            base.layer.shadowOffset = offset
            base.layer.shadowRadius = radius
            base.layer.shadowOpacity = opacity
            base.layer.shadowPath = path
        }
    }
}
