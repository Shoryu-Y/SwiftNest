// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Birds",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "Nest",
            targets: ["Nest"]),
        .library(
            name: "WidgetSource",
            targets: ["WidgetSource"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", exact: "1.18.0"),
        .package(url: "https://github.com/pixiv/charcoal-ios.git", exact: "2.1.0"),
        .package(url: "https://github.com/nonameplum/UIEnvironment", from: "1.1.0"),
    ],
    targets: [
        .target(
            name: "Nest",
            dependencies: [
                "Observe",
                "Env",
            ],
            path: "Sources/_Nest"
        ),
        .target(name: "AsyncValue"),
        .target(name: "Diff"),
        .target(name: "WidgetSource"),
        .target(name: "Pencil"),
        .target(
            name: "UIKitNav",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "Draggable",
            dependencies: [
                .product(name: "Charcoal", package: "charcoal-ios"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(name: "CustomModifier"),
        .target(
            name: "Charcomponent",
            dependencies: [
                .product(name: "Charcoal", package: "charcoal-ios"),
            ],
            resources: [.process("Resources")]
        ),
        .target(name: "Observe"),
        .target(name: "Env"),
    ],
    swiftLanguageModes: [.v6]
)
