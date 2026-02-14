/// Option element.
public struct Option: HTMLPrimitive, HTMLContentModifiable {
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
        "<option\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</option>"
    }

    public func value(_ value: String) -> Self {
        var copy = self
        copy.attributes["value"] = value
        return copy
    }

    public func selected(_ value: Bool = true) -> Self {
        var copy = self
        if value {
            copy.attributes["selected"] = ""
        } else {
            copy.attributes.removeValue(forKey: "selected")
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

/// Type alias for ``Option``.
public typealias option = Option
