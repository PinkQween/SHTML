public struct Head: HTML {
    private var attributes: [String: String]
    public let content: () -> [any HTML]

    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }

    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        let children = content().map { $0.render() }.joined()
        return "<head\(attrs)>\(children)</head>"
    }
}

public typealias head = Head
