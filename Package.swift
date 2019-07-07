// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Testament",
    products: [
        .library(name: "Testament", targets: ["Testament"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "Testament", dependencies: []),
        .testTarget(name: "TestamentTests", dependencies: ["Testament"]),
    ]
)
