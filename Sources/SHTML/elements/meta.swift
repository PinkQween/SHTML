public struct Meta: HTML {
    private var attributes: [String: String]
    
    public init() {
        self.attributes = [:]
    }
    
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        return "<meta\(attrs) />"
    }
    
    public func charset(_ value: String) -> Self {
        var copy = self
        copy.attributes["charset"] = value
        return copy
    }
    
    public func name(_ value: String) -> Self {
        var copy = self
        copy.attributes["name"] = value
        return copy
    }
    
    public func content(_ value: String) -> Self {
        var copy = self
        copy.attributes["content"] = value
        return copy
    }
    
    public func httpEquiv(_ value: String) -> Self {
        var copy = self
        copy.attributes["http-equiv"] = value
        return copy
    }
    
    public func property(_ value: String) -> Self {
        var copy = self
        copy.attributes["property"] = value
        return copy
    }
}

public typealias meta = Meta
