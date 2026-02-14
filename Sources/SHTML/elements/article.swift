/// Article element.
public struct Article: HTMLPrimitive, HTMLContentModifiable {
    /// Type alias.
    public typealias Content = Never

    /// Property.
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    /// Creates an ``Article`` with child HTML.
    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }

    /// Creates an ``Article`` with explicit attributes and child HTML.
    public init(attributes: [String: String], content: @escaping () -> [any HTML]) {
        self.attributes = attributes
        self.content = content
    }

    /// Renders the element into an HTML `<article>` string.
    public func render() -> String {
        "<article\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</article>"
    }
}

/// Type alias for ``Article``.
public typealias article = Article
