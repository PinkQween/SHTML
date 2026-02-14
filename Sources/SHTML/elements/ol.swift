/// Ordered list element.
public struct Ol: HTMLPrimitive, HTMLContentModifiable {
    /// Type alias.
    public typealias Content = Never

    /// Property.
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    /// Creates an ``Ol`` with child HTML.
    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }

    /// Creates an ``Ol`` with explicit attributes and child HTML.
    public init(attributes: [String: String], content: @escaping () -> [any HTML]) {
        self.attributes = attributes
        self.content = content
    }

    /// Renders the element into an HTML `<ol>` string.
    public func render() -> String {
        "<ol\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</ol>"
    }

    /// Sets the list's `start` attribute.
    public func start(_ value: Int) -> Self {
        var copy = self
        copy.attributes["start"] = "\(value)"
        return copy
    }
}

/// Type alias for ``Ol``.
public typealias ol = Ol
