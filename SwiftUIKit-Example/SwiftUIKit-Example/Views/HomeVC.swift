//
//  HomeVC.swift
//  SwiftUIKit-Example
//
//  Created by finos.son.le on 20/04/2021.
//

import UIKit
import SwiftUIKit

class HomeVC: UI.ViewController {
    
    var lbSwift = UILabel()
    
    //MARK: - ViewController Life
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    enum Item: CaseIterable {
        case basic
        case verticalStack
        case horizontalStack
        case scroll
        case customLayout
    }
    
    override var subviewsLayout: SomeView {
        ZStackView {
            ZStackView {
                VStackView(spacing: 20, distribution: .fill) {
                    ZStackView {
                        ZStackView {
                            ZStackView {
                                HStackView(spacing: 4, distribution: .fill, alignment: .leading) {
                                    lbSwift
                                        .dx.text("Swift")
                                        .dx.textColor(ThemeManager.shared.current.primary)
                                        .dx.font(.systemFont(ofSize: 24))
                                        .centeringVerticallyInParent()
                                    
                                    ZStackView {
                                        UILabel()
                                            .dx.text("UIKit")
                                            .dx.textColor(ThemeManager.shared.current.contrastText1)
                                            .dx.font(.systemFont(ofSize: 24))
                                            .centeringInParent()
                                            .stickingToParentEdges(left: 6, right: 6, top: 4, bottom: 4)
                                    }
                                    .dx.backgroundColor(ThemeManager.shared.current.box3)
                                    .dx.style(UI.ViewStyle.CornerRadius(radius: 6))
                                }
                                .centeringVerticallyInParent()
                                .stickingToParentEdges(left: 20)
                            }
                            .dx.style(UI.ViewStyle.Card2())
                            .dx.backgroundColor(ThemeManager.shared.current.box4)
                            .constrainingAspectRatio(ratio: 1)
                            .layout { (parent: Anchorable, it: UIView, revertable: LayoutRevertable) in
                                let widthCst = it.widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: 0.5, constant: -30)
                                widthCst.isActive = true
                                revertable.append(BlockRevertable({
                                    widthCst.isActive = false
                                }))
                            }
                            .stickingToParentEdges(left: 20, right: nil, top: 20, bottom: 20)
                        }
                        .dx.backgroundColor(ThemeManager.shared.current.box1)
                        .dx.style(UI.ViewStyle.Card1())
                        .fillingParent()
                    }
                    ZStackView {
                        ZStackView {
                            VStackView(spacing: 20, distribution: .fill) {
                                HStackView(spacing: 20) {
                                    ForEach([0,1,2]) { _, _ in
                                        UIView()
                                            .dx.backgroundColor(ThemeManager.shared.current.box2)
                                            .dx.style(UI.ViewStyle.Card2())
                                            .constrainingAspectRatio(ratio: 1)
                                    }
                                }
                                ZStackView {
                                    VStackView(spacing: 16, distribution: .fill) {
                                        ForEach(Item.allCases) { (index, item) in
                                            ZStackView {
                                                UILabel()
                                                    .dx.text(String(describing: item))
                                                    .centeringInParent()
                                            }
                                            .dx.backgroundColor(ThemeManager.shared.current.box3)
                                            .dx.style(UI.ViewStyle.CornerRadius(radius: 8))
                                            .dx.gestureOnTap { [weak self] _ in
                                                self?.present(BasicVC(), animated: true, completion: nil)
                                            }
                                            .sizing(width: nil, height: 48)
                                        }
                                        
                                        UIView()
                                    }
                                    .fillingParent(insets: 20)
                                }
                                .dx.backgroundColor(ThemeManager.shared.current.background2)
                                .dx.style(UI.ViewStyle.Card2())
                            }
                            .fillingParent(insets: 20)
                        }
                        .dx.backgroundColor(ThemeManager.shared.current.box1)
                        .dx.style(UI.ViewStyle.Card1())
                        .fillingParent()
                    }
                }
                .fillingParent(insets: 20)
            }
            .dx.backgroundColor(ThemeManager.shared.current.background2)
            .fillingParent(insets: 20, relativeToSafeArea: true)
        }
        .dx.backgroundColor(ThemeManager.shared.current.background1)
        .fillingParent()
    }
}
