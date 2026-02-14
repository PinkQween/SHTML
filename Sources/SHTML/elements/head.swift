/// Head type.
public struct Head: HTML {
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
        return "<head\(attrs)>\(children)</head>"
    }
}

/// Type alias.
public typealias head = Head
