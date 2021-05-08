Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.name         = "SwiftUIKit_pro"
  spec.version      = "1.0.0"
  spec.summary      = "SwiftUIKit combines the element of UIKit with declarative style from SwiftUI. `_pro` surface avoid conflic module name in CocoaPods."

  spec.homepage     = "https://github.com/sonla58/SwiftUIKit"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.author             = { "son.le" => "anhsonleit@gmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.platform     = :ios, "11.0"
  spec.swift_version = '5.3'
  

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.source       = { :git => "https://github.com/sonla58/SwiftUIKit.git", :tag => "#{spec.version}" }
  # spec.source       = { :git => "https://github.com/sonla58/SwiftUIKit.git", :branch => "master" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.source_files  = "SwiftUIKit/**/*.{swift}"

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.framework  = "UIKit"

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  # ――― Subspec ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.subspec 'Core' do |sub|
    sub.source_files = "SwiftUIKit/Core/**/*.{swift}"
  end

end
