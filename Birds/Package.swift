// swift-tools-version: 5.9

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
    targets: [
        .target(
            name: "Nest",
            dependencies: [
                "AsyncValue",
                "Pencil",
                "Singleton"
            ]
        ),
        .target(name: "AsyncValue"),
        .target(name: "WidgetSource"),
        .target(name: "Pencil"),
        .target(name: "Singleton"),
        .testTarget(
            name: "BirdsTests",
            dependencies: ["Nest"]),
    ]
)
