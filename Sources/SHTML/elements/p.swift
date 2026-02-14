/// P type.
public struct P: HTMLPrimitive, HTMLContentModifiable {
    /// Type alias.
    public typealias Content = Never
    
    /// Property.
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    /// Creates a new instance.
    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
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
        return "<p\(attrs)>\(children)</p>"
    }
}

/// Type alias.
public typealias p = P
