// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SHTML",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SHTML",
            targets: ["SHTML"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SHTML"
        ),
        .testTarget(
            name: "SHTMLTests",
            dependencies: ["SHTML"]
        ),
    ]
)
