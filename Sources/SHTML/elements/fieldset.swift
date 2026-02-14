/// Fieldset element.
public struct Fieldset: HTMLPrimitive, HTMLContentModifiable {
    /// Type alias.
    public typealias Content = Never

    /// Property.
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    /// Creates a ``Fieldset`` with child HTML.
    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }

    /// Creates a ``Fieldset`` with explicit attributes and child HTML.
    public init(attributes: [String: String], content: @escaping () -> [any HTML]) {
        self.attributes = attributes
        self.content = content
    }

    /// Renders the element into an HTML `<fieldset>` string.
    public func render() -> String {
        "<fieldset\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</fieldset>"
    }
}

/// Type alias for ``Fieldset``.
public typealias fieldset = Fieldset
