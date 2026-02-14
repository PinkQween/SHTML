/// Img type.
public struct Img: HTMLPrimitive, HTMLModifiable {
    /// Type alias.
    public typealias Content = Never
    
    /// Property.
    public var attributes: [String: String]
    
    /// Creates a new instance.
    public init(src: String, alt: String = "") {
        self.attributes = ["src": src, "alt": alt]
    }
    
    /// render function.
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        return "<img\(attrs) />"
    }
}

/// Type alias.
public typealias img = Img
