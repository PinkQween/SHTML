// Type-safe video names for asset catalog
public struct VideoName: ExpressibleByStringLiteral, Sendable {
    /// Type-safe video file format.
    public enum VideoFormat: String, Sendable {
        case mp4
        case webm
        case ogg
        case mov
        case m4v
    }

    /// Constant.
    public let name: String
    /// Constant.
    public let format: VideoFormat?
    /// Constant.
    public let customPath: String?

    /// Creates a new instance.
    public init(_ name: String, format: VideoFormat = .mp4) {
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
        self.format = .mp4
        self.customPath = nil
    }

    /// Creates a new video name with the provided format.
    public func withFormat(_ format: VideoFormat) -> VideoName {
        VideoName(name, format: format)
    }

    /// Creates an external video reference.
    public static func external(_ url: String) -> VideoName {
        VideoName(path: url)
    }

    // Convenience accessor for path.
    public var path: String {
        if let customPath { return customPath }
        return "Assets/Videos/\(name).\(format?.rawValue ?? VideoFormat.mp4.rawValue)"
    }
}
