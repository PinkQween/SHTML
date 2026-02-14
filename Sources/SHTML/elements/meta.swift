/// Meta type.
public struct Meta: HTML {
    private var attributes: [String: String]
    
    /// Creates a new instance.
    public init() {
        self.attributes = [:]
    }
    
    /// render function.
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        return "<meta\(attrs) />"
    }
    
    /// charset function.
    public func charset(_ value: String) -> Self {
        var copy = self
        copy.attributes["charset"] = value
        return copy
    }
    
    /// name function.
    public func name(_ value: String) -> Self {
        var copy = self
        copy.attributes["name"] = value
        return copy
    }
    
    /// content function.
    public func content(_ value: String) -> Self {
        var copy = self
        copy.attributes["content"] = value
        return copy
    }
    
    /// httpEquiv function.
    public func httpEquiv(_ value: String) -> Self {
        var copy = self
        copy.attributes["http-equiv"] = value
        return copy
    }
    
    /// property function.
    public func property(_ value: String) -> Self {
        var copy = self
        copy.attributes["property"] = value
        return copy
    }
}

/// Type alias.
public typealias meta = Meta
