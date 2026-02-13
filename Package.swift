// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "SHTML",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "SHTML",
            targets: ["SHTML"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.0"),
    ],
    targets: [
        // Macro implementation
        .macro(
            name: "SHTMLMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        
        // Main library
        .target(
            name: "SHTML",
            dependencies: ["SHTMLMacros"]
        ),
        
        .testTarget(
            name: "SHTMLTests",
            dependencies: ["SHTML"]
        ),
    ]
)
