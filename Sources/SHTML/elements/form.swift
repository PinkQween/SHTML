/// Form type.
public struct Form: HTMLPrimitive, HTMLContentModifiable {
    /// Type alias.
    public typealias Content = Never
    
    /// Property.
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    /// Creates a new instance.
    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = ["method": "POST"]
        self.content = content
    }
    
    /// Creates a new instance.
    public init(attributes: [String: String], content: @escaping () -> [any HTML]) {
        self.attributes = attributes
        self.content = content
    }

    /// render function.
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        let children = content().map { $0.render() }.joined()
        return "<form\(attrs)>\(children)</form>"
    }
    
    /// action function.
    public func action(_ value: String) -> Self {
        var copy = self
        copy.attributes["action"] = value
        return copy
    }
    
    /// method function.
    public func method(_ value: String) -> Self {
        var copy = self
        copy.attributes["method"] = value
        return copy
    }
}

/// Type alias.
public typealias form = Form
