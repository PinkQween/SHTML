/// Footer element.
public struct Footer: HTMLPrimitive, HTMLContentModifiable {
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
        "<footer\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</footer>"
    }
}

/// Type alias for ``Footer``.
public typealias footer = Footer
