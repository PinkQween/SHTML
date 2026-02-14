/// Footer element.
public struct Footer: HTMLPrimitive, HTMLContentModifiable {
    /// Type alias.
    public typealias Content = Never

    /// Property.
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    /// Creates a ``Footer`` with child HTML.
    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }

    /// Creates a ``Footer`` with explicit attributes and child HTML.
    public init(attributes: [String: String], content: @escaping () -> [any HTML]) {
        self.attributes = attributes
        self.content = content
    }

    /// Renders the element into an HTML `<footer>` string.
    public func render() -> String {
        "<footer\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</footer>"
    }
}

/// Type alias for ``Footer``.
public typealias footer = Footer
