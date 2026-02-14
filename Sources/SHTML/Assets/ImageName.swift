// Type-safe image names for asset catalog
public struct ImageName: ExpressibleByStringLiteral, Sendable {
    /// Constant.
    public let name: String
    
    /// Creates a new instance.
    public init(_ name: String) {
        self.name = name
    }
    
    /// Creates a new instance.
    public init(stringLiteral value: String) {
        self.name = value
    }
    
    // Convenience accessor for path
    public var path: String {
        "Assets/Images/\(name).webp"
    }
}
