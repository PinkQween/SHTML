/// Link type.
public struct Link: HTML {
    private var attributes: [String: String]
    
    /// Creates a new instance.
    public init() {
        self.attributes = [:]
    }
    
    /// render function.
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        return "<link\(attrs) />"
    }
    
    /// rel function.
    public func rel(_ value: String) -> Self {
        var copy = self
        copy.attributes["rel"] = value
        return copy
    }
    
    /// href function.
    public func href(_ value: String) -> Self {
        var copy = self
        copy.attributes["href"] = value
        return copy
    }
    
    /// type function.
    public func type(_ value: String) -> Self {
        var copy = self
        copy.attributes["type"] = value
        return copy
    }
    
    /// media function.
    public func media(_ value: String) -> Self {
        var copy = self
        copy.attributes["media"] = value
        return copy
    }
    
    /// sizes function.
    public func sizes(_ value: String) -> Self {
        var copy = self
        copy.attributes["sizes"] = value
        return copy
    }
}

/// Type alias.
public typealias link = Link
