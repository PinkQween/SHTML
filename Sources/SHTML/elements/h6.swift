/// Heading level 6 element.
public struct H6: HTMLPrimitive, HTMLContentModifiable {
    /// Type alias.
    public typealias Content = Never

    /// Property.
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    /// Creates an ``H6`` with child HTML.
    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }

    /// Creates an ``H6`` with explicit attributes and child HTML.
    public init(attributes: [String: String], content: @escaping () -> [any HTML]) {
        self.attributes = attributes
        self.content = content
    }

    /// Renders the element into an HTML `<h6>` string.
    public func render() -> String {
        "<h6\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</h6>"
    }
}

/// Type alias for ``H6``.
public typealias h6 = H6
