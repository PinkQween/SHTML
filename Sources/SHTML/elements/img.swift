public struct Img: HTMLPrimitive, HTMLModifiable {
    public typealias Content = Never
    
    public var attributes: [String: String]
    
    public init(src: String, alt: String = "") {
        self.attributes = ["src": src, "alt": alt]
    }
    
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        return "<img\(attrs) />"
    }
}

public typealias img = Img
