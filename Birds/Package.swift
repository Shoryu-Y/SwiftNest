// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Birds",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Nest",
            targets: ["Nest"]),
    ],
    targets: [
        .target(
            name: "Nest",
            dependencies: ["AsyncValue"]
        ),
        .target(name: "AsyncValue"),
        .testTarget(
            name: "BirdsTests",
            dependencies: ["Nest"]),
    ]
)
