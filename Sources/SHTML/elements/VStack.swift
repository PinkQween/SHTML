// VStack-like vertical container
public struct VStack: HTML, HTMLModifiable {
    public var attributes: [String: String]
    private let spacing: String?
    private let content: () -> [any HTML]
    
    public init(spacing: String? = nil, @HTMLBuilder _ content: @escaping () -> [any HTML]) {
        var attrs: [String: String] = [:]
        var style = "display: flex; flex-direction: column;"
        if let spacing = spacing {
            style += " gap: \(spacing);"
        }
        attrs["style"] = style
        self.attributes = attrs
        self.spacing = spacing
        self.content = content
    }
    
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        let children = content().map { $0.render() }.joined()
        return "<div\(attrs)>\(children)</div>"
    }
    
    public func padding(_ value: String) -> Self {
        var copy = self
        var style = copy.attributes["style"] ?? ""
        style += " padding: \(value);"
        copy.attributes["style"] = style
        return copy
    }
    
    public func background(_ value: String) -> Self {
        var copy = self
        var style = copy.attributes["style"] ?? ""
        style += " background: \(value);"
        copy.attributes["style"] = style
        return copy
    }
    
    public func frame(width: String? = nil, height: String? = nil) -> Self {
        var copy = self
        var style = copy.attributes["style"] ?? ""
        if let width = width {
            style += " width: \(width);"
        }
        if let height = height {
            style += " height: \(height);"
        }
        copy.attributes["style"] = style
        return copy
    }
}
