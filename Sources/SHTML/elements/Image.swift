/// Image type.
public struct Image: HTMLPrimitive, HTMLModifiable {
    /// Type alias.
    public typealias Content = Never
    
    /// Property.
    public var attributes: [String: String] = [:]
    /// Property.
    public var styles: [String: String] = [:]
    
    /// Property.
    public var src: String
    /// Property.
    public var alt: String
    
    /// Creates a new instance.
    public init(_ imageName: ImageName, alt: String = "") {
        self.src = imageName.path
        self.alt = alt
    }
    
    /// render function.
    public func render() -> String {
        var attrs = attributes
        attrs["src"] = src
        attrs["alt"] = alt
        
        if !styles.isEmpty {
            let styleStr = styles.map { "\($0.key): \($0.value)" }.joined(separator: "; ")
            attrs["style"] = styleStr
        }
        
        let attrsString = HTMLRendering.renderAttributes(attrs)
        return "<img\(attrsString) />"
    }
}
