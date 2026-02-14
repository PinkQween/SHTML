/// Button type.
public struct Button: HTMLPrimitive, HTMLModifiable {
    /// Type alias.
    public typealias Content = Never
    
    /// Property.
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    /// Creates a new instance.
    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }

    /// render function.
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        let children = content().map { $0.render() }.joined()
        return "<button\(attrs)>\(children)</button>"
    }
    
    /// type function.
    public func type(_ value: String) -> Self {
        var copy = self
        copy.attributes["type"] = value
        return copy
    }
    
    /// disabled function.
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

/// Type alias.
public typealias button = Button
