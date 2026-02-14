/// Nav type.
public struct Nav: HTMLPrimitive {
    /// Type alias.
    public typealias Content = Never
    
    private var attributes: [String: String]
    private let content: () -> [any HTML]

    /// Creates a new instance.
    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }

    /// render function.
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        let children = content().map { $0.render() }.joined()
        return "<nav\(attrs)>\(children)</nav>"
    }
}

/// Type alias.
public typealias nav = Nav
