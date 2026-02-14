/// ScriptTag type.
public struct ScriptTag: HTMLPrimitive {
    /// Type alias.
    public typealias Content = Never
    
    private var attributes: [String: String]
    private let content: String
    
    /// Creates a new instance.
    public init(_ content: String = "") {
        self.attributes = [:]
        self.content = content
    }
    
    /// Creates a new instance.
    public init(@JSBuilder _ builder: @escaping () -> [any JavaScript]) {
        self.attributes = [:]
        self.content = JSRendering.renderStatements(builder)
    }
    
    /// render function.
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        return "<script\(attrs)>\(content)</script>"
    }
    
    /// src function.
    public func src(_ value: String) -> Self {
        var copy = self
        copy.attributes["src"] = value
        return copy
    }
    
    /// type function.
    public func type(_ value: String) -> Self {
        var copy = self
        copy.attributes["type"] = value
        return copy
    }
    
    /// async function.
    public func async(_ value: Bool = true) -> Self {
        var copy = self
        if value {
            copy.attributes["async"] = ""
        } else {
            copy.attributes.removeValue(forKey: "async")
        }
        return copy
    }
    
    /// `defer` function.
    public func `defer`(_ value: Bool = true) -> Self {
        var copy = self
        if value {
            copy.attributes["defer"] = ""
        } else {
            copy.attributes.removeValue(forKey: "defer")
        }
        return copy
    }
}

/// Type alias.
public typealias script = ScriptTag
/// Type alias.
public typealias ScriptElement = ScriptTag
