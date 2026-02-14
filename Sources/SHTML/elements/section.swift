/// Section element.
public struct Section: HTMLPrimitive, HTMLContentModifiable {
    /// Type alias.
    public typealias Content = Never

    /// Property.
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    /// Creates a ``Section`` with child HTML.
    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }

    /// Creates a ``Section`` with explicit attributes and child HTML.
    public init(attributes: [String: String], content: @escaping () -> [any HTML]) {
        self.attributes = attributes
        self.content = content
    }

    /// Renders the element into an HTML `<section>` string.
    public func render() -> String {
        "<section\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</section>"
    }
}

/// Type alias for ``Section``.
public typealias section = Section
