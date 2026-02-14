/// Header element.
public struct Header: HTMLPrimitive, HTMLContentModifiable {
    /// Type alias.
    public typealias Content = Never

    /// Property.
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    /// Creates a ``Header`` with child HTML.
    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }

    /// Creates a ``Header`` with explicit attributes and child HTML.
    public init(attributes: [String: String], content: @escaping () -> [any HTML]) {
        self.attributes = attributes
        self.content = content
    }

    /// Renders the element into an HTML `<header>` string.
    public func render() -> String {
        "<header\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</header>"
    }
}

/// Type alias for ``Header``.
public typealias header = Header
