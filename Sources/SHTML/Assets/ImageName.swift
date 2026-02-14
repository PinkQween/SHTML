// Type-safe image names for asset catalog
public struct ImageName: ExpressibleByStringLiteral, Sendable {
    /// Type-safe image file format.
    public enum ImageFormat: String, Sendable {
        case webp
        case png
        case jpg
        case jpeg
        case gif
        case svg
        case avif
        case bmp
        case tif
        case tiff
    }

    /// Constant.
    public let name: String
    /// Constant.
    public let format: ImageFormat?
    /// Constant.
    public let customPath: String?
    
    /// Creates a new instance.
    public init(_ name: String, format: ImageFormat = .webp) {
        self.name = name
        self.format = format
        self.customPath = nil
    }

    /// Creates a new instance.
    public init(path: String) {
        self.name = ""
        self.format = nil
        self.customPath = path
    }
    
    /// Creates a new instance.
    public init(stringLiteral value: String) {
        self.name = value
        self.format = .webp
        self.customPath = nil
    }

    /// Creates a new image name with the provided format.
    public func withFormat(_ format: ImageFormat) -> ImageName {
        ImageName(name, format: format)
    }

    /// Creates an external image reference.
    public static func external(_ url: String) -> ImageName {
        ImageName(path: url)
    }
    
    // Convenience accessor for path
    public var path: String {
        if let customPath {
            return customPath
        }
        return "Assets/Images/\(name).\(format?.rawValue ?? ImageFormat.webp.rawValue)"
    }
}
