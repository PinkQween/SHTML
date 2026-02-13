// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SHTML",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "SHTML",
            targets: ["SHTML"]
        ),
    ],
    targets: [
        .target(
            name: "SHTML"
        ),
        .testTarget(
            name: "SHTMLTests",
            dependencies: ["SHTML"]
        ),
    ]
)
