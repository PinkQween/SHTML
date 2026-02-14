/// Input type.
public struct Input: HTMLPrimitive, HTMLModifiable {
    /// Type alias.
    public typealias Content = Never
    
    /// Property.
    public var attributes: [String: String]
    
    /// Creates a new instance.
    public init(type: String = "text") {
        self.attributes = ["type": type]
    }
    
    /// render function.
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        return "<input\(attrs) />"
    }
    
    /// name function.
    public func name(_ value: String) -> Self {
        var copy = self
        copy.attributes["name"] = value
        return copy
    }
    
    /// placeholder function.
    public func placeholder(_ value: String) -> Self {
        var copy = self
        copy.attributes["placeholder"] = value
        return copy
    }
    
    /// value function.
    public func value(_ value: String) -> Self {
        var copy = self
        copy.attributes["value"] = value
        return copy
    }
    
    /// required function.
    public func required(_ value: Bool = true) -> Self {
        var copy = self
        if value {
            copy.attributes["required"] = ""
        } else {
            copy.attributes.removeValue(forKey: "required")
        }
        return copy
    }
    
    /// disabled function.
    public func disabled(_ value: Bool = true) -> Self {
        var copy = self
        if value {
            copy.attributes["disabled"] = ""
        } else {
            copy.attributes.removeValue(forKey: "disabled")
        }
        return copy
    }
}

/// Type alias.
public typealias input = Input
