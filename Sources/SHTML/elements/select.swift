/// Select element.
public struct Select: HTMLPrimitive, HTMLContentModifiable {
    public typealias Content = Never

    public var attributes: [String: String]
    private let content: () -> [any HTML]

    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }

    public init(attributes: [String: String], content: @escaping () -> [any HTML]) {
        self.attributes = attributes
        self.content = content
    }

    public func render() -> String {
        "<select\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</select>"
    }

    public func name(_ value: String) -> Self {
        var copy = self
        copy.attributes["name"] = value
        return copy
    }

    public func multiple(_ value: Bool = true) -> Self {
        var copy = self
        if value {
            copy.attributes["multiple"] = ""
        } else {
            copy.attributes.removeValue(forKey: "multiple")
        }
        return copy
    }

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
