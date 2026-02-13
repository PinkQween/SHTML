public struct Link: HTML {
    private var attributes: [String: String]
    
    public init() {
        self.attributes = [:]
    }
    
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        return "<link\(attrs) />"
    }
    
    public func rel(_ value: String) -> Self {
        var copy = self
        copy.attributes["rel"] = value
        return copy
    }
    
    public func href(_ value: String) -> Self {
        var copy = self
        copy.attributes["href"] = value
        return copy
    }
    
    public func type(_ value: String) -> Self {
        var copy = self
        copy.attributes["type"] = value
        return copy
    }
    
    public func media(_ value: String) -> Self {
        var copy = self
        copy.attributes["media"] = value
        return copy
    }
    
    public func sizes(_ value: String) -> Self {
        var copy = self
        copy.attributes["sizes"] = value
        return copy
    }
}

public typealias link = Link
