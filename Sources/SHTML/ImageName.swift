// Type-safe image names for asset catalog
public struct ImageName: ExpressibleByStringLiteral, Sendable {
    public let name: String
    
    public init(_ name: String) {
        self.name = name
    }
    
    public init(stringLiteral value: String) {
        self.name = value
    }
    
    // Convenience accessor for path
    public var path: String {
        "Assets/Images/\(name).webp"
    }
}

// Static image names - add your images here
extension ImageName {
    public static let lily: ImageName = "lily"
}

// Convenience global function for creating images
public func Image(_ imageName: ImageName, alt: String = "") -> Img {
    Img(src: imageName.path, alt: alt)
}
