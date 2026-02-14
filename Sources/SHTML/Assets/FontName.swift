// Type-safe font names for asset catalog
public struct FontName: ExpressibleByStringLiteral, Sendable {
    /// Constant.
    public let name: String

    /// Creates a new instance.
    public init(_ name: String) {
        self.name = name
    }

    /// Creates a new instance.
    public init(stringLiteral value: StringLiteralType) {
        self.name = value
    }

    /// Convenience accessor for default font file path.
    public func path(format: FontAsset.FontFormat = .woff2) -> String {
        "Assets/Fonts/\(name).\(format.rawValue)"
    }

    /// Convenience accessor for CSS font-family.
    public var family: FontFamily {
        .custom(name)
    }
}

// Static font names - add your fonts here
extension FontName {
    public static let assetFont: FontName = "assetFont"
}
