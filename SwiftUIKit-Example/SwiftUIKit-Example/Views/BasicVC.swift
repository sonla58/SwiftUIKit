//
//  BasicVC.swift
//  SwiftUIKit-Example
//
//  Created by finos.son.le on 22/04/2021.
//
import UIKit

import SwiftUIKit

class BasicVC: UI.ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ThemeManager.shared.current.background1
    }
    
    override var subviewsLayout: SomeView {
        UI.Label {
            UIView()
                .dx.backgroundColor(.red)
                .sizing(width: 100, height: 100)
                .fillingParent(insets: 30)
        }
        .dx.backgroundColor(.green)
        .dx.gestureOnTap { _ in
            print("ok")
        }
        .centeringInParent()
    }
    
    deinit {
        print("\(String(describing: self)) deinit")
    }
}

class AwesomeView: UI.View {
    override var subviewsLayout: SomeView {
        ZStackView {
            
        }
        .dx.backgroundColor(.white)
        .fillingParent()
    }
}
