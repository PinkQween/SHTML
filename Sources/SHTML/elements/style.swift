public struct Style: HTMLPrimitive {
    public typealias Body = Never
    
    private var attributes: [String: String]
    private let content: String
    
    public init(_ content: String = "") {
        self.attributes = [:]
        self.content = content
    }
    
    public init(@CSSStyleBuilder _ stylesheet: () -> [CSS]) {
        self.attributes = [:]
        self.content = Stylesheet(stylesheet).render()
    }
    
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        return "<style\(attrs)>\(content)</style>"
    }
    
    public func type(_ value: String) -> Self {
        var copy = self
        copy.attributes["type"] = value
        return copy
    }
    
    public func media(_ value: String) -> Self {
        var copy = self
        copy.attributes["media"] = value
        return copy
    }
}

public typealias style = Style
