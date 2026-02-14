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
    /// Constant.
    public let name: String
    /// Constant.
    public let path: String
    
    /// Creates a new instance.
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
    /// Constant.
    public let name: String
    /// Constant.
    public let path: String
    /// Constant.
    public let format: FontFormat
    /// Constant.
    public let family: String
    /// Constant.
    public let weight: String
    /// Constant.
    public let style: String
    /// Constant.
    public let display: FontDisplay?
    
    /// FontFormat type.
    public enum FontFormat: String {
        case woff2
        case woff
        case ttf
        case otf
        case eot
    }

    /// Type alias.
    public typealias FontType = FontFormat

    /// FontDisplay type.
    public enum FontDisplay: String {
        case auto
        case block
        case swap
        case fallback
        case optional
    }
    
    /// Creates a new instance.
    public init(
        _ name: String,
        format: FontFormat = .woff2,
        path: String? = nil,
        family: String? = nil,
        weight: String = "normal",
        style: String = "normal",
        display: FontDisplay? = .swap
    ) {
        self.name = name
        self.format = format
        self.path = path ?? "Assets/Fonts/\(name).\(format.rawValue)"
        self.family = family ?? name
        self.weight = weight
        self.style = style
        self.display = display
    }

    /// Creates an external font asset from a URL.
    public static func external(
        family: String,
        url: String,
        format: FontFormat = .woff2,
        weight: String = "normal",
        style: String = "normal",
        display: FontDisplay? = .swap
    ) -> FontAsset {
        FontAsset(
            family,
            format: format,
            path: url,
            family: family,
            weight: weight,
            style: style,
            display: display
        )
    }
    
    /// Generate @font-face CSS rule
    public func fontFace(family: String, weight: String = "normal", style: String = "normal") -> String {
        let displayLine: String
        if let display {
            displayLine = "\n    font-display: \(display.rawValue);"
        } else {
            displayLine = ""
        }
        return """
        @font-face {
            font-family: '\(family)';
            src: url('\(path)') format('\(format.rawValue)');
            font-weight: \(weight);
            font-style: \(style);\(displayLine)
        }
        """
    }

    /// Generate @font-face CSS rule using this asset's configured values.
    public func fontFace() -> String {
        fontFace(family: family, weight: weight, style: style)
    }
}

/// Type alias.
public typealias FontType = FontAsset.FontFormat

// MARK: - Color Asset

public struct ColorAsset {
    /// Constant.
    public let name: String
    /// Constant.
    public let light: Color
    /// Constant.
    public let dark: Color?
    
    /// Creates a new instance.
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
    private var externalFontStylesheets: [String] = []
    
    /// Creates a new instance.
    public init() {}
    
    // MARK: Images
    
    public mutating func registerImage(_ name: String, path: String? = nil) {
        images[name] = ImageAsset(name, path: path)
    }
    
    /// image function.
    public func image(_ name: String) -> ImageAsset? {
        images[name]
    }
    
    // MARK: Fonts
    
    public mutating func registerFont(_ name: String, format: FontAsset.FontFormat = .woff2, path: String? = nil) {
        fonts[name] = FontAsset(name, format: format, path: path)
    }

    /// registerFont function.
    public mutating func registerFont(_ fontName: FontName, format: FontAsset.FontFormat = .woff2, path: String? = nil) {
        registerFont(fontName.name, format: format, path: path ?? fontName.path(format: format))
    }

    /// registerExternalFont function.
    public mutating func registerExternalFont(
        family: String,
        url: String,
        format: FontAsset.FontFormat = .woff2,
        weight: String = "normal",
        style: String = "normal",
        display: FontAsset.FontDisplay? = .swap
    ) {
        fonts[family] = .external(
            family: family,
            url: url,
            format: format,
            weight: weight,
            style: style,
            display: display
        )
    }

    /// registerExternalFontStylesheet function.
    public mutating func registerExternalFontStylesheet(_ url: String) {
        if !externalFontStylesheets.contains(url) {
            externalFontStylesheets.append(url)
        }
    }
    
    /// font function.
    public func font(_ name: String) -> FontAsset? {
        fonts[name]
    }

    /// font function.
    public func font(_ fontName: FontName) -> FontAsset? {
        font(fontName.name)
    }
    
    // MARK: Colors
    
    public mutating func registerColor(_ name: String, light: Color, dark: Color? = nil) {
        colors[name] = ColorAsset(name, light: light, dark: dark)
    }
    
    /// color function.
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
        let imports = externalFontStylesheets
            .map { "@import url('\($0)');" }
            .joined(separator: "\n")

        let fontFaces = fonts.values
            .map { $0.fontFace() }
            .joined(separator: "\n\n")

        if imports.isEmpty { return fontFaces }
        if fontFaces.isEmpty { return imports }
        return "\(imports)\n\n\(fontFaces)"
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
    
    /// registerImage function.
    public func registerImage(_ name: String, path: String? = nil) {
        lock.lock()
        defer { lock.unlock() }
        catalog.registerImage(name, path: path)
    }
    
    /// image function.
    public func image(_ name: String) -> ImageAsset? {
        lock.lock()
        defer { lock.unlock() }
        return catalog.image(name)
    }
    
    /// registerFont function.
    public func registerFont(_ name: String, format: FontAsset.FontFormat = .woff2, path: String? = nil) {
        lock.lock()
        defer { lock.unlock() }
        catalog.registerFont(name, format: format, path: path)
    }

    /// registerFont function.
    public func registerFont(_ fontName: FontName, format: FontAsset.FontFormat = .woff2, path: String? = nil) {
        lock.lock()
        defer { lock.unlock() }
        catalog.registerFont(fontName, format: format, path: path)
    }

    /// registerExternalFont function.
    public func registerExternalFont(
        family: String,
        url: String,
        format: FontAsset.FontFormat = .woff2,
        weight: String = "normal",
        style: String = "normal",
        display: FontAsset.FontDisplay? = .swap
    ) {
        lock.lock()
        defer { lock.unlock() }
        catalog.registerExternalFont(
            family: family,
            url: url,
            format: format,
            weight: weight,
            style: style,
            display: display
        )
    }

    /// registerExternalFontStylesheet function.
    public func registerExternalFontStylesheet(_ url: String) {
        lock.lock()
        defer { lock.unlock() }
        catalog.registerExternalFontStylesheet(url)
    }
    
    /// font function.
    public func font(_ name: String) -> FontAsset? {
        lock.lock()
        defer { lock.unlock() }
        return catalog.font(name)
    }

    /// font function.
    public func font(_ fontName: FontName) -> FontAsset? {
        font(fontName.name)
    }
    
    /// registerColor function.
    public func registerColor(_ name: String, light: Color, dark: Color? = nil) {
        lock.lock()
        defer { lock.unlock() }
        catalog.registerColor(name, light: light, dark: dark)
    }
    
    /// color function.
    public func color(_ name: String) -> ColorAsset? {
        lock.lock()
        defer { lock.unlock() }
        return catalog.color(name)
    }
    
    /// generateColorCSS function.
    public func generateColorCSS() -> String {
        lock.lock()
        defer { lock.unlock() }
        return catalog.generateColorCSS()
    }
    
    /// generateFontCSS function.
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
/// AssetBuilder type.
public enum AssetBuilder {
    public static func buildBlock(_ components: AssetRegistration...) -> [AssetRegistration] {
        components
    }
}

/// AssetRegistration type.
public enum AssetRegistration {
    case image(String, path: String?)
    case font(String, format: FontAsset.FontFormat, path: String?)
    case externalFont(
        family: String,
        url: String,
        format: FontAsset.FontFormat,
        weight: String,
        style: String,
        display: FontAsset.FontDisplay?
    )
    case externalFontStylesheet(String)
    case color(String, light: Color, dark: Color?)
}

/// configureAssets function.
public func configureAssets(@AssetBuilder _ builder: () -> [AssetRegistration]) {
    let registrations = builder()
    for registration in registrations {
        switch registration {
        case .image(let name, let path):
            AssetManager.shared.registerImage(name, path: path)
        case .font(let name, let format, let path):
            AssetManager.shared.registerFont(name, format: format, path: path)
        case .externalFont(let family, let url, let format, let weight, let style, let display):
            AssetManager.shared.registerExternalFont(
                family: family,
                url: url,
                format: format,
                weight: weight,
                style: style,
                display: display
            )
        case .externalFontStylesheet(let url):
            AssetManager.shared.registerExternalFontStylesheet(url)
        case .color(let name, let light, let dark):
            AssetManager.shared.registerColor(name, light: light, dark: dark)
        }
    }
}

// MARK: - Convenience Functions

// Image() moved to ImageName.swift for type-safe asset references

public func Font(_ name: String, format: FontAsset.FontFormat = .woff2) -> AssetRegistration {
    .font(name, format: format, path: nil)
}

/// Font function.
public func Font(_ fontName: FontName, format: FontAsset.FontFormat = .woff2) -> AssetRegistration {
    .font(fontName.name, format: format, path: fontName.path(format: format))
}

/// Font function.
public func Font(_ name: String, format: FontAsset.FontFormat, path: String) -> AssetRegistration {
    .font(name, format: format, path: path)
}

/// ExternalFont function.
public func ExternalFont(
    family: String,
    url: String,
    format: FontAsset.FontFormat = .woff2,
    weight: String = "normal",
    style: String = "normal",
    display: FontAsset.FontDisplay? = .swap
) -> AssetRegistration {
    .externalFont(
        family: family,
        url: url,
        format: format,
        weight: weight,
        style: style,
        display: display
    )
}

/// ExternalFontStylesheet function.
public func ExternalFontStylesheet(_ url: String) -> AssetRegistration {
    .externalFontStylesheet(url)
}

/// ColorPair function.
public func ColorPair(_ name: String, light: Color, dark: Color? = nil) -> AssetRegistration {
    .color(name, light: light, dark: dark)
}
