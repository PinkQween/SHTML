public struct Html: HTML {
    private var attributes: [String: String]
    public let content: () -> [any HTML]

    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }

    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        let children = content().map { $0.render() }.joined()
        return "<html\(attrs)>\(children)</html>"
    }
    
    public func lang(_ value: String) -> Self {
        var copy = self
        copy.attributes["lang"] = value
        return copy
    }
}

public typealias html = Html
