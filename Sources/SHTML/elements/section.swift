/// Section element.
public struct Section: HTMLPrimitive, HTMLContentModifiable {
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
        "<section\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</section>"
    }
}

/// Type alias for ``Section``.
public typealias section = Section
