//
//  Assets.swift
//  SHTML
//
//  Type-safe asset system similar to SwiftUI
//

import Foundation

// MARK: - Asset Protocol

public protocol Asset {
    var path: String { get }
}

// MARK: - Image Asset

public struct ImageAsset: Asset {
    public let name: String
    public let path: String
    
    public init(_ name: String, path: String? = nil) {
        self.name = name
        self.path = path ?? "Assets/Images/\(name)"
    }
    
    /// Generate an img element for this asset
    public func image(alt: String = "", width: CSSLength? = nil, height: CSSLength? = nil) -> Img {
        var img = Img(src: path, alt: alt)
        if let width = width {
            img = img.width(width.css)
        }
        if let height = height {
            img = img.height(height.css)
        }
        return img
    }
}

// MARK: - Font Asset

public struct FontAsset: Asset {
    public let name: String
    public let path: String
    public let format: FontFormat
    
    public enum FontFormat: String {
        case woff2
        case woff
        case ttf
        case otf
        case eot
    }
    
    public init(_ name: String, format: FontFormat = .woff2, path: String? = nil) {
        self.name = name
        self.format = format
        self.path = path ?? "Assets/Fonts/\(name).\(format.rawValue)"
    }
    
    /// Generate @font-face CSS rule
    public func fontFace(family: String, weight: String = "normal", style: String = "normal") -> String {
        """
        @font-face {
            font-family: '\(family)';
            src: url('\(path)') format('\(format.rawValue)');
            font-weight: \(weight);
            font-style: \(style);
        }
        """
    }
}

// MARK: - Color Asset

public struct ColorAsset {
    public let name: String
    public let light: Color
    public let dark: Color?
    
    public init(_ name: String, light: Color, dark: Color? = nil) {
        self.name = name
        self.light = light
        self.dark = dark
    }
    
    /// Generate CSS variable for this color
    public var cssVariable: String {
        "--color-\(name)"
    }
    
    /// Get CSS variable reference
    public var color: Color {
        .variable(cssVariable)
    }
}

// MARK: - Asset Catalog

public struct AssetCatalog {
    private var images: [String: ImageAsset] = [:]
    private var fonts: [String: FontAsset] = [:]
    private var colors: [String: ColorAsset] = [:]
    
    public init() {}
    
    // MARK: Images
    
    public mutating func registerImage(_ name: String, path: String? = nil) {
        images[name] = ImageAsset(name, path: path)
    }
    
    public func image(_ name: String) -> ImageAsset? {
        images[name]
    }
    
    // MARK: Fonts
    
    public mutating func registerFont(_ name: String, format: FontAsset.FontFormat = .woff2, path: String? = nil) {
        fonts[name] = FontAsset(name, format: format, path: path)
    }
    
    public func font(_ name: String) -> FontAsset? {
        fonts[name]
    }
    
    // MARK: Colors
    
    public mutating func registerColor(_ name: String, light: Color, dark: Color? = nil) {
        colors[name] = ColorAsset(name, light: light, dark: dark)
    }
    
    public func color(_ name: String) -> ColorAsset? {
        colors[name]
    }
    
    // MARK: CSS Generation
    
    /// Generate CSS with all color variables
    public func generateColorCSS() -> String {
        var css = ":root {\n"
        
        // Light mode colors
        for (_, colorAsset) in colors {
            css += "    \(colorAsset.cssVariable): \(colorAsset.light.css);\n"
        }
        
        css += "}\n\n"
        
        // Dark mode colors
        let hasDarkColors = colors.values.contains { $0.dark != nil }
        if hasDarkColors {
            css += "@media (prefers-color-scheme: dark) {\n"
            css += "    :root {\n"
            for (_, colorAsset) in colors {
                if let dark = colorAsset.dark {
                    css += "        \(colorAsset.cssVariable): \(dark.css);\n"
                }
            }
            css += "    }\n"
            css += "}\n"
        }
        
        return css
    }
    
    /// Generate CSS with all font-face declarations
    public func generateFontCSS() -> String {
        fonts.values
            .map { $0.fontFace(family: $0.name) }
            .joined(separator: "\n\n")
    }
}

// MARK: - Global Asset Catalog

/// Thread-safe global asset catalog
/// Access via `Assets.shared`
public final class AssetManager: @unchecked Sendable {
    public static let shared = AssetManager()
    
    private var catalog = AssetCatalog()
    private let lock = NSLock()
    
    private init() {}
    
    public func registerImage(_ name: String, path: String? = nil) {
        lock.lock()
        defer { lock.unlock() }
        catalog.registerImage(name, path: path)
    }
    
    public func image(_ name: String) -> ImageAsset? {
        lock.lock()
        defer { lock.unlock() }
        return catalog.image(name)
    }
    
    public func registerFont(_ name: String, format: FontAsset.FontFormat = .woff2, path: String? = nil) {
        lock.lock()
        defer { lock.unlock() }
        catalog.registerFont(name, format: format, path: path)
    }
    
    public func font(_ name: String) -> FontAsset? {
        lock.lock()
        defer { lock.unlock() }
        return catalog.font(name)
    }
    
    public func registerColor(_ name: String, light: Color, dark: Color? = nil) {
        lock.lock()
        defer { lock.unlock() }
        catalog.registerColor(name, light: light, dark: dark)
    }
    
    public func color(_ name: String) -> ColorAsset? {
        lock.lock()
        defer { lock.unlock() }
        return catalog.color(name)
    }
    
    public func generateColorCSS() -> String {
        lock.lock()
        defer { lock.unlock() }
        return catalog.generateColorCSS()
    }
    
    public func generateFontCSS() -> String {
        lock.lock()
        defer { lock.unlock() }
        return catalog.generateFontCSS()
    }
}

/// Convenience accessor
public var Assets: AssetManager { AssetManager.shared }

// MARK: - Asset Configuration DSL

@resultBuilder
public enum AssetBuilder {
    public static func buildBlock(_ components: AssetRegistration...) -> [AssetRegistration] {
        components
    }
}

public enum AssetRegistration {
    case image(String, path: String?)
    case font(String, format: FontAsset.FontFormat, path: String?)
    case color(String, light: Color, dark: Color?)
}

public func configureAssets(@AssetBuilder _ builder: () -> [AssetRegistration]) {
    let registrations = builder()
    for registration in registrations {
        switch registration {
        case .image(let name, let path):
            AssetManager.shared.registerImage(name, path: path)
        case .font(let name, let format, let path):
            AssetManager.shared.registerFont(name, format: format, path: path)
        case .color(let name, let light, let dark):
            AssetManager.shared.registerColor(name, light: light, dark: dark)
        }
    }
}

// MARK: - Convenience Functions

public func Image(_ name: String) -> AssetRegistration {
    .image(name, path: nil)
}

public func Image(_ name: String, path: String) -> AssetRegistration {
    .image(name, path: path)
}

public func Font(_ name: String, format: FontAsset.FontFormat = .woff2) -> AssetRegistration {
    .font(name, format: format, path: nil)
}

public func Font(_ name: String, format: FontAsset.FontFormat, path: String) -> AssetRegistration {
    .font(name, format: format, path: path)
}

public func ColorPair(_ name: String, light: Color, dark: Color? = nil) -> AssetRegistration {
    .color(name, light: light, dark: dark)
}
