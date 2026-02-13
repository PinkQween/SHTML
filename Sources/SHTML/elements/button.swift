public struct Button: HTMLPrimitive, HTMLModifiable {
    public typealias Content = Never
    
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }

    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        let children = content().map { $0.render() }.joined()
        return "<button\(attrs)>\(children)</button>"
    }
    
    public func type(_ value: String) -> Self {
        var copy = self
        copy.attributes["type"] = value
        return copy
    }
    
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

public typealias button = Button
