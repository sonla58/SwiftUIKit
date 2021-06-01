//
//  UIView+Dx.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 22/04/2021.
//

import UIKit

extension Declarative where Base: UIView {
    public func gestureOnTap(_ action: @escaping (_ gesture: UITapGestureRecognizer) -> Void) -> Base {
        base.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer()
        gesture.addAction {
            action(gesture)
        }
        
        base.addGestureRecognizer(gesture)
        return base
    }
}

class GestureActionBlocker {
    var block: () -> Void
    
    init(block: @escaping () -> Void) {
        self.block = block
    }
}

extension UIGestureRecognizer {
    private struct AssociatedKeys {
        static var actionBlock = "actionBlock"
    }
    
    private var actionBlock: GestureActionBlocker? {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.actionBlock) as? GestureActionBlocker
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.actionBlock, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc private func executeActionBlock() {
        actionBlock?.block()
    }
    
    func addAction(_ action: @escaping () -> Void) {
        self.actionBlock = GestureActionBlocker(block: action)
        self.addTarget(self, action: #selector(executeActionBlock))
    }
}
