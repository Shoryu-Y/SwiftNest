// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Birds",
    platforms: [.iOS(.v17)],
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
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            exact: "1.18.0"
        ),
        .package(
            url: "https://github.com/pixiv/charcoal-ios.git",
            exact: "2.0.0-beta2"
        ),
    ],
    targets: [
        .target(
            name: "Nest",
            dependencies: [
                "AsyncValue",
                "Diff",
                "Pencil",
                "Singleton",
                "Draggable",
                "UIKitNav",
                "CustomModifier",
                "EnvironmentRange",
            ]
        ),
        .target(name: "AsyncValue"),
        .target(name: "Diff"),
        .target(name: "WidgetSource"),
        .target(name: "Pencil"),
        .target(name: "Singleton"),
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
        .target(name: "EnvironmentRange"),
    ],
    swiftLanguageModes: [.v6]
)
