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
        .plugin(
            name: "SHTMLAssetNamePlugin",
            targets: ["SHTMLAssetNamePlugin"]
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

        // Asset symbol generator tool (used by build plugin)
        .executableTarget(
            name: "shtml-asset-name-gen"
        ),

        // Build tool plugin for auto-generating ImageName/FontName symbols
        .plugin(
            name: "SHTMLAssetNamePlugin",
            capability: .buildTool(),
            dependencies: ["shtml-asset-name-gen"]
        ),
        
        .testTarget(
            name: "SHTMLTests",
            dependencies: ["SHTML"]
        ),
    ]
)
