public struct Input: HTMLPrimitive, HTMLModifiable {
    public typealias Body = Never
    
    public var attributes: [String: String]
    
    public init(type: String = "text") {
        self.attributes = ["type": type]
    }
    
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        return "<input\(attrs) />"
    }
    
    public func name(_ value: String) -> Self {
        var copy = self
        copy.attributes["name"] = value
        return copy
    }
    
    public func placeholder(_ value: String) -> Self {
        var copy = self
        copy.attributes["placeholder"] = value
        return copy
    }
    
    public func value(_ value: String) -> Self {
        var copy = self
        copy.attributes["value"] = value
        return copy
    }
    
    public func required(_ value: Bool = true) -> Self {
        var copy = self
        if value {
            copy.attributes["required"] = ""
        } else {
            copy.attributes.removeValue(forKey: "required")
        }
        return copy
    }
    
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

public typealias input = Input
