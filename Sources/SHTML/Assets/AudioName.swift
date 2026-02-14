// Type-safe audio names for asset catalog
public struct AudioName: ExpressibleByStringLiteral, Sendable {
    /// Type-safe audio file format.
    public enum AudioFormat: String, Sendable {
        case mp3
        case wav
        case ogg
        case m4a
        case aac
        case flac
    }

    /// Constant.
    public let name: String
    /// Constant.
    public let format: AudioFormat?
    /// Constant.
    public let customPath: String?

    /// Creates a new instance.
    public init(_ name: String, format: AudioFormat = .mp3) {
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
        self.format = .mp3
        self.customPath = nil
    }

    /// Creates a new audio name with the provided format.
    public func withFormat(_ format: AudioFormat) -> AudioName {
        AudioName(name, format: format)
    }

    /// Creates an external audio reference.
    public static func external(_ url: String) -> AudioName {
        AudioName(path: url)
    }

    // Convenience accessor for path.
    public var path: String {
        if let customPath { return customPath }
        return "Assets/Audio/\(name).\(format?.rawValue ?? AudioFormat.mp3.rawValue)"
    }
}
