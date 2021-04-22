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
        ZStackView {
            UILabel()
                .dx.text("Start")
                .centeringInParent()
        }
        .dx.backgroundColor(ThemeManager.shared.current.box1)
        .dx.startAddGesture
        .action {
            print("something")
        }
        .commitGesture()
        .sizing(width: 300, height: 58)
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
