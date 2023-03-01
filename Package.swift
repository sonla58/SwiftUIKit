// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "SwiftUIKit",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "SwiftUIKit",
            targets: ["SwiftUIKit"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftUIKit",
            path: "SwiftUIKit"
        )
    ],
    swiftLanguageVersions: [.v5]
)
