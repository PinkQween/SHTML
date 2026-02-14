/// Style type.
public struct Style: HTMLPrimitive {
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
    public init(@CSSStyleBuilder _ stylesheet: () -> [CSS]) {
        self.attributes = [:]
        self.content = Stylesheet(stylesheet).render()
    }
    
    /// render function.
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        return "<style\(attrs)>\(content)</style>"
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
}

/// Type alias.
public typealias style = Style
