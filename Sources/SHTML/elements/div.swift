public struct Div: HTMLPrimitive, HTMLContentModifiable {
    public typealias Content = Never
    
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    public init(id: String? = nil, @HTMLBuilder _ content: @escaping () -> [any HTML] = { [] }) {
        var attrs: [String: String] = [:]
        if let id = id { attrs["id"] = id }
        self.attributes = attrs
        self.content = content
    }
    
    public init(attributes: [String: String], content: @escaping () -> [any HTML]) {
        self.attributes = attributes
        self.content = content
    }

    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        let children = content().map { $0.render() }.joined()
        return "<div\(attrs)>\(children)</div>"
    }
}

public typealias div = Div
