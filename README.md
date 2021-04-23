![SwiftUIKit](./Assets/banner.png)

<br/>

[![iOS version support](https://img.shields.io/badge/platform-iOS%2011.0+-8EBEA4)](#Required)
[![latest release](https://img.shields.io/badge/pod-1.0-C9D9D6)](#Development%20Progress)
[![test](https://img.shields.io/badge/test-TODO-FFD6B2)](#Development%20Progress)

# SwiftUIKit

**SwiftUIKit** combines the element of *UIKit* with declarative style from *SwiftUI*. Take a look to see how it magically

```swift
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
            .dx.startAddGesture
            .action { [weak self] in
                self?.present(BasicVC(), animated: true, completion: nil)
            }
            .commitGesture()
            .sizing(width: nil, height: 48)
        }
        
        UIView()
    }
    .fillingParent(insets: 20)
}
.dx.backgroundColor(ThemeManager.shared.current.background2)
.dx.style(UI.ViewStyle.Card2())
```

<br/>

# Special Thanks Layoutless team

This project was strongly inspired by [Layoutless](https://github.com/DeclarativeHub/Layoutless). Most of the ideas and implementation in the core system layout was reused from Layoutless. I just made some changed for rename, made a new API style for the layout system and it enable `DeclarativeExtension`.

# Features
- [x] Build layout without interface builder with fancy declarative style.
- [x] Support layout with stack view: `VStackView`, `HStackView` and `ZStackView`.
- [x] Support `ScrollView`.
- [x] Use directly UIKit element.
- [x] Enable *declarative* way to construct and modify property of UI element.
- [x] Support styling.
- [x] Support traitQuerySet.

# Requirement

- iOS 11+
- XCode 11+
- Swift 5.3+

# Installation

## CocoaPods

Add following line to your project's Podfile
```ruby
pod 'SwiftUIKit_pro', '1.0.rc1'
```
Run `pod install` to install SwiftUIKit

## Source Code

Drop all files in folder `./SwiftUIKit` to your project or download this repo and drag `SwiftUIKit.xcodeproj` to your project with necessary files then link your app with `SwiftUIKit` framework munualy

# Usage

## Content

1. [Basic layout](#Basic%20Layout)
2. [DeclarativeExtension](#DeclarativeExtension)
3. [Base Views](#Base%20Views)
4. [Styling](#Styling)
5. [Advance](#Advance)

## Basic Layout

Updating...

## DeclarativeExtension

Updating...

## Base Views

Updating...

## Styling

Updating...

## Advance

Updating...

