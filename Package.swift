// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "UIKitExtended",
    platforms: [
        .iOS(.v11),
        .tvOS(.v11),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "UIKitExtended",
            type: .dynamic,
            targets: ["UIKitExtended"]
        )
    ],
    targets: [
        .target(name: "UIKitExtended", dependencies: [], path: "Sources")
    ],
    swiftLanguageVersions: [
        .version("5.1")
    ]
)
