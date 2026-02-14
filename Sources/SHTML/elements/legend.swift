/// Fieldset legend element.
public struct Legend: HTMLPrimitive, HTMLContentModifiable {
    /// Type alias.
    public typealias Content = Never

    /// Property.
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    /// Creates a ``Legend`` with child HTML.
    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }

    /// Creates a ``Legend`` with explicit attributes and child HTML.
    public init(attributes: [String: String], content: @escaping () -> [any HTML]) {
        self.attributes = attributes
        self.content = content
    }

    /// Renders the element into an HTML `<legend>` string.
    public func render() -> String {
        "<legend\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</legend>"
    }
}

/// Type alias for ``Legend``.
public typealias legend = Legend
