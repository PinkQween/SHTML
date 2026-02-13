public struct Image: HTMLPrimitive, HTMLModifiable {
    public typealias Body = Never
    
    public var attributes: [String: String] = [:]
    public var styles: [String: String] = [:]
    
    public var src: String
    public var alt: String
    
    public init(_ imageName: ImageName, alt: String = "") {
        self.src = imageName.path
        self.alt = alt
    }
    
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
