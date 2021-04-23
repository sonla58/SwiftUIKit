//
//  UIView+Dx.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 22/04/2021.
//

import UIKit

public class DxGestureWrapper<Base: UIView> {
    var base: Base
    var onTap: (() -> Void)?
    private var observation: NSKeyValueObservation?
    
    private var gestures: [UIGestureRecognizer] = []
    
    public init(_ base: Base) {
        self.base = base
    }
    
    public func action(onTap: @escaping ()-> Void) -> Self {
        self.onTap = onTap
        return self
    }
    
    public func commitGesture() -> Base {
        setup()
        return base
    }
    
    private func setup() {
        gestures.forEach { (gesture) in
            self.base.removeGestureRecognizer(gesture)
        }
        gestures = []
        
        if let _ = self.onTap {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionOnTap))
            base.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc private func actionOnTap() {
        onTap?()
    }
    
    deinit {
        print("deinit")
    }
}

extension Declarative where Base: UIView {
    public var startAddGesture: DxGestureWrapper<Base> {
        let wr = DxGestureWrapper(base)
        base.gestureWrapper = wr
        return wr
    }
}

extension NSObject {
    private struct AssociatedKeys {
        static var gestureWrapper = "gestureWrapper"
    }
    
    fileprivate var gestureWrapper: AnyObject? {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.gestureWrapper) as AnyObject?
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.gestureWrapper, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
