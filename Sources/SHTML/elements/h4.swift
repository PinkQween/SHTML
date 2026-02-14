/// Heading level 4 element.
public struct H4: HTMLPrimitive, HTMLContentModifiable {
    /// Type alias.
    public typealias Content = Never

    /// Property.
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    /// Creates an ``H4`` with child HTML.
    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }

    /// Creates an ``H4`` with explicit attributes and child HTML.
    public init(attributes: [String: String], content: @escaping () -> [any HTML]) {
        self.attributes = attributes
        self.content = content
    }

    /// Renders the element into an HTML `<h4>` string.
    public func render() -> String {
        "<h4\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</h4>"
    }
}

/// Type alias for ``H4``.
public typealias h4 = H4
