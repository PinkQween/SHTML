/// Div type.
public struct Div: HTMLPrimitive, HTMLContentModifiable {
    /// Type alias.
    public typealias Content = Never
    
    /// Property.
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    /// Creates a new instance.
    public init(id: String? = nil, @HTMLBuilder _ content: @escaping () -> [any HTML] = { [] }) {
        var attrs: [String: String] = [:]
        if let id = id { attrs["id"] = id }
        self.attributes = attrs
        self.content = content
    }
    
    /// Creates a new instance.
    public init(attributes: [String: String], content: @escaping () -> [any HTML]) {
        self.attributes = attributes
        self.content = content
    }

    /// render function.
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        let children = content().map { $0.render() }.joined()
        return "<div\(attrs)>\(children)</div>"
    }
}

/// Type alias.
public typealias div = Div
