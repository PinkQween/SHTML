/// Option element.
public struct Option: HTMLPrimitive, HTMLContentModifiable {
    /// Type alias.
    public typealias Content = Never

    /// Property.
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    /// Creates an ``Option`` with child HTML.
    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }

    /// Creates an ``Option`` with explicit attributes and child HTML.
    public init(attributes: [String: String], content: @escaping () -> [any HTML]) {
        self.attributes = attributes
        self.content = content
    }

    /// Renders the element into an HTML `<option>` string.
    public func render() -> String {
        "<option\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</option>"
    }

    /// Sets the `value` attribute.
    public func value(_ value: String) -> Self {
        var copy = self
        copy.attributes["value"] = value
        return copy
    }

    /// Enables or disables the `selected` attribute.
    public func selected(_ value: Bool = true) -> Self {
        var copy = self
        if value {
            copy.attributes["selected"] = ""
        } else {
            copy.attributes.removeValue(forKey: "selected")
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

/// Type alias for ``Option``.
public typealias option = Option
