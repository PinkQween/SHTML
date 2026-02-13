public struct Img: HTMLPrimitive {
    public typealias Body = Never
    
    private var attributes: [String: String]
    
    public init(src: String, alt: String = "") {
        self.attributes = ["src": src, "alt": alt]
    }
    
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        return "<img\(attrs) />"
    }
    
    public func width(_ value: String) -> Self {
        var copy = self
        copy.attributes["width"] = value
        return copy
    }
    
    public func height(_ value: String) -> Self {
        var copy = self
        copy.attributes["height"] = value
        return copy
    }
    
    public func `class`(_ value: String) -> Self {
        var copy = self
        copy.attributes["class"] = value
        return copy
    }
}

public typealias img = Img
