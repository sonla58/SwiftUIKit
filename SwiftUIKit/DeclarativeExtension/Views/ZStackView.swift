//
//  ZStackView.swift
//  SwiftUIKit
//
//  Created by finos.son.le on 22/04/2021.
//

import UIKit

public class ZStackView: UI.View {
    public override init(@LayoutBuilder _ layoutBuilder: () -> [SomeView]) {
        super.init(layoutBuilder)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
