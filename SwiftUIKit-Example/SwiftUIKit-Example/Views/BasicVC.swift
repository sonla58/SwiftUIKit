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
            if false {
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
                .stickingToParentEdges(left: 0, top: 0)
            } else {
                UI.Label {
                    UIView()
                        .dx.backgroundColor(.blue)
                        .sizing(width: 100, height: 100)
                        .fillingParent(insets: 30)
                }
                .dx.backgroundColor(.yellow)
                .dx.gestureOnTap { _ in
                    print("ok")
                }
                .stickingToParentEdges(left: 0, top: 0)
            }
            
            UIView()
                .dx.backgroundColor(.black)
                .sizing(width: 50, height: 50)
                .centeringInParent()
        }
        .fillingParent()
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
