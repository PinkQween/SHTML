/// Label element.
public struct Label: HTMLPrimitive, HTMLContentModifiable {
    /// Type alias.
    public typealias Content = Never

    /// Property.
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    /// Creates a ``Label`` with child HTML.
    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }

    /// Creates a ``Label`` with explicit attributes and child HTML.
    public init(attributes: [String: String], content: @escaping () -> [any HTML]) {
        self.attributes = attributes
        self.content = content
    }

    /// Renders the element into an HTML `<label>` string.
    public func render() -> String {
        "<label\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</label>"
    }

    /// Sets the HTML `for` attribute.
    public func `for`(_ value: String) -> Self {
        var copy = self
        copy.attributes["for"] = value
        return copy
    }
}

/// Type alias for ``Label``.
public typealias label = Label
