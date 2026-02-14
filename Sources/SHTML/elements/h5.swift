/// Heading level 5 element.
public struct H5: HTMLPrimitive, HTMLContentModifiable {
    /// Type alias.
    public typealias Content = Never

    /// Property.
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    /// Creates an ``H5`` with child HTML.
    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }

    /// Creates an ``H5`` with explicit attributes and child HTML.
    public init(attributes: [String: String], content: @escaping () -> [any HTML]) {
        self.attributes = attributes
        self.content = content
    }

    /// Renders the element into an HTML `<h5>` string.
    public func render() -> String {
        "<h5\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</h5>"
    }
}

/// Type alias for ``H5``.
public typealias h5 = H5
