public struct Nav: HTMLPrimitive {
    public typealias Content = Never
    
    private var attributes: [String: String]
    private let content: () -> [any HTML]

    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }

    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        let children = content().map { $0.render() }.joined()
        return "<nav\(attrs)>\(children)</nav>"
    }
}

public typealias nav = Nav
