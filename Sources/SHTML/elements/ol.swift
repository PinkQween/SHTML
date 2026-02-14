/// Ordered list element.
public struct Ol: HTMLPrimitive, HTMLContentModifiable {
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
        "<ol\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</ol>"
    }

    public func start(_ value: Int) -> Self {
        var copy = self
        copy.attributes["start"] = "\(value)"
        return copy
    }
}

/// Type alias for ``Ol``.
public typealias ol = Ol
