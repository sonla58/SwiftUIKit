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
        ListView(.plain) {
            SectionList(headerViewBuilder: { () -> [SomeView] in
                ZStackView {
                    UILabel()
                        .dx.text("Header")
                        .centeringVerticallyInParent()
                        .stickingToParentEdges(left: 16)
                }
                .dx.backgroundColor(.white)
                .sizing(width: nil, height: 44)
                .fillingParent()
            }, footerViewBuilder: { () -> [SomeView] in
                return []
            }, items: Array(0...100)) { (index, item) in
                UITableViewCell(style: .subtitle, reuseIdentifier: nil)
                    .dx.style { (cell) in
                        cell.textLabel?.text = "\(item)"
                    }
            }
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
