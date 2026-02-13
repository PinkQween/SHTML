public struct Form: HTMLPrimitive {
    public typealias Body = Never
    
    private var attributes: [String: String]
    private let content: () -> [any HTML]

    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = ["method": "POST"]
        self.content = content
    }

    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        let children = content().map { $0.render() }.joined()
        return "<form\(attrs)>\(children)</form>"
    }
    
    public func action(_ value: String) -> Self {
        var copy = self
        copy.attributes["action"] = value
        return copy
    }
    
    public func method(_ value: String) -> Self {
        var copy = self
        copy.attributes["method"] = value
        return copy
    }
    
    public func `class`(_ value: String) -> Self {
        var copy = self
        copy.attributes["class"] = value
        return copy
    }
}

public typealias form = Form
