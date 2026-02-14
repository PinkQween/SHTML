/// Textarea element.
public struct Textarea: HTMLPrimitive, HTMLContentModifiable {
    /// Type alias.
    public typealias Content = Never

    /// Property.
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    /// Creates a ``Textarea`` with optional child HTML content.
    public init(@HTMLBuilder _ content: @escaping () -> [any HTML] = { [] }) {
        self.attributes = [:]
        self.content = content
    }

    /// Creates a ``Textarea`` with explicit attributes and child HTML.
    public init(attributes: [String: String], content: @escaping () -> [any HTML]) {
        self.attributes = attributes
        self.content = content
    }

    /// Renders the element into an HTML `<textarea>` string.
    public func render() -> String {
        "<textarea\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</textarea>"
    }

    /// Sets the `name` attribute.
    public func name(_ value: String) -> Self {
        var copy = self
        copy.attributes["name"] = value
        return copy
    }

    /// Sets the `placeholder` attribute.
    public func placeholder(_ value: String) -> Self {
        var copy = self
        copy.attributes["placeholder"] = value
        return copy
    }

    /// Sets the `rows` attribute.
    public func rows(_ value: Int) -> Self {
        var copy = self
        copy.attributes["rows"] = "\(value)"
        return copy
    }

    /// Sets the `cols` attribute.
    public func cols(_ value: Int) -> Self {
        var copy = self
        copy.attributes["cols"] = "\(value)"
        return copy
    }

    /// Enables or disables the `disabled` attribute.
    public func disabled(_ value: Bool = true) -> Self {
        var copy = self
        if value {
            copy.attributes["disabled"] = ""
        } else {
            copy.attributes.removeValue(forKey: "disabled")
        }
        return copy
    }
}

/// Type alias for ``Textarea``.
public typealias textarea = Textarea
