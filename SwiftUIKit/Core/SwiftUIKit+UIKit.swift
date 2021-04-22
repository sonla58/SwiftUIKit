//
//  SwiftUIKit+UIKit.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 20/04/2021.
//

import Foundation

import UIKit

// MARK: Protocol conformances

extension UIView: Anchorable {

    // Conforms automatically
}

extension UILayoutGuide: Anchorable {

    // Conforms automatically
}

extension UIView: View {

    /// UIView's layout node is the view itself. Returns `self`.
    public func makeViewNode(_ compositeRevertable: LayoutRevertable) -> UIView {
        return self
    }
}

extension UIView: ViewNode {

    /// Makes the receiver a subview of the container.
    @discardableResult
    public func layout(in container: UIView) -> LayoutRevertable {
        let revertable = LayoutBag()
        translatesAutoresizingMaskIntoConstraints = false
        if let container = container as? UIStackView {
            container.addArrangedSubview(self)
        } else {
            container.addSubview(self)
        }
        revertable.append(BlockRevertable({
            self.removeFromSuperview()
        }))
        return revertable
    }
}

extension UIView {

    private struct AssociatedKeys {
        static var safeAreaLayoutGuide = "safeAreaLayoutGuide"
        static var associatedObjects = "associatedObjects"
    }

    internal var ___safeAreaLayoutGuide: UILayoutGuide {
        get {
            let layoutGuide = objc_getAssociatedObject(self, &AssociatedKeys.safeAreaLayoutGuide) as? UILayoutGuide
            if let layoutGuide = layoutGuide {
                return layoutGuide
            } else {
                let layoutGuide = UILayoutGuide()
                addLayoutGuide(layoutGuide)
                NSLayoutConstraint.activate([
                    layoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
                    layoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor)
                ])
                objc_setAssociatedObject(self, &AssociatedKeys.safeAreaLayoutGuide, layoutGuide, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return layoutGuide
            }
        }
    }

    internal var ___associatedObjects: [AnyObject] {
        get {
            let associatedObjects = objc_getAssociatedObject(self, &AssociatedKeys.associatedObjects) as? [AnyObject]
            if let associatedObjects = associatedObjects {
                return associatedObjects
            } else {
                let associatedObjects = [AnyObject]()
                objc_setAssociatedObject(self, &AssociatedKeys.associatedObjects, associatedObjects, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return associatedObjects
            }
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.associatedObjects, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
