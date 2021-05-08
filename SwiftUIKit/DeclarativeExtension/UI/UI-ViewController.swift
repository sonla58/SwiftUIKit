//
//  UI-TextField.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 22/04/2021.
//

import UIKit

extension UI {
    
    open class ViewController: UIViewController {
        
        public var layoutBag = LayoutBag()
        
        private var layouts: [SomeView] = []
        
        public convenience init(_ layouts: [SomeView]) {
            self.init(nibName: nil, bundle: nil)
            self.layouts = layouts
            
            setup()
            defineLayout()
        }
        
        public convenience init(@LayoutBuilder _ layoutBuilder: () -> [SomeView]) {
            self.init(nibName: nil, bundle: nil)
            self.layouts = layoutBuilder()
            
            setup()
            defineLayout()
        }
        
        public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
            setup()
        }
        
        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }
        
        open override func viewDidLoad() {
            super.viewDidLoad()
            
            if #available(iOS 11.0, tvOS 11.0, *) {
                // safeAreaLayoutGuide is already available
            } else {
                setupSafeAreaLayoutGuideFallback()
            }
            
            defineLayout()
        }
        
        open func setup() {
            if #available(iOS 13.0, *) {
                self.view.backgroundColor = UIColor.systemBackground
            } else {
                self.view.backgroundColor = .white
            }
        }
        
        open func defineLayout() {
            layoutBag.append(subviewsLayout.layout(in: view))
        }
        
        open var subviewsLayout: SomeView {
            if layouts.count > 0 {
                return group(layouts)
            }
            return EmptyLayout()
        }
        
        private func setupSafeAreaLayoutGuideFallback() {
            if #available(iOS 11, tvOS 11, *) {
                // Good to go
            } else {
                NSLayoutConstraint.activate([
                    view.___safeAreaLayoutGuide.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
                    view.___safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
                ])
            }
        }
    }
}

