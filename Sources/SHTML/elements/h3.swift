public struct H3: HTMLPrimitive, HTMLContentModifiable {
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
        let attrs = HTMLRendering.renderAttributes(attributes)
        let children = content().map { $0.render() }.joined()
        return "<h3\(attrs)>\(children)</h3>"
    }
}

public typealias h3 = H3
