/// Select element.
public struct Select: HTMLPrimitive, HTMLContentModifiable {
    /// Type alias.
    public typealias Content = Never

    /// Property.
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    /// Creates a ``Select`` with child HTML.
    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }

    /// Creates a ``Select`` with explicit attributes and child HTML.
    public init(attributes: [String: String], content: @escaping () -> [any HTML]) {
        self.attributes = attributes
        self.content = content
    }

    /// Renders the element into an HTML `<select>` string.
    public func render() -> String {
        "<select\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</select>"
    }

    /// Sets the `name` attribute.
    public func name(_ value: String) -> Self {
        var copy = self
        copy.attributes["name"] = value
        return copy
    }

    /// Enables or disables the `multiple` attribute.
    public func multiple(_ value: Bool = true) -> Self {
        var copy = self
        if value {
            copy.attributes["multiple"] = ""
        } else {
            copy.attributes.removeValue(forKey: "multiple")
        }
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

/// Type alias for ``Select``.
public typealias select = Select
