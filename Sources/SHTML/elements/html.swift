/// Html type.
public struct Html: HTML {
    private var attributes: [String: String]
    /// Constant.
    public let content: () -> [any HTML]

    /// Creates a new instance.
    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }

    /// render function.
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        let children = content().map { $0.render() }.joined()
        return "<html\(attrs)>\(children)</html>"
    }
    
    /// lang function.
    public func lang(_ value: String) -> Self {
        var copy = self
        copy.attributes["lang"] = value
        return copy
    }
}

/// Type alias.
public typealias html = Html
