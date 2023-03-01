// swift-tools-version: 5.3

import PackageDescription

let package = Package(
    name: "SwiftUIKit",
    platforms: [.iOS(.v11)],
    swiftLanguageVersions: [.v5],
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
    ]
)
