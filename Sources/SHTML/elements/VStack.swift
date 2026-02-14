// VStack-like vertical container
public struct VStack: HTML, HTMLModifiable {
    /// Property.
    public var attributes: [String: String]
    private let spacing: String?
    /// Constant.
    public let content: () -> [any HTML]
    
    /// Creates a new instance.
    public init(alignment: AlignItems = .stretch, spacing: String? = nil, @HTMLBuilder _ content: @escaping () -> [any HTML]) {
        var attrs: [String: String] = [:]
        var style = "display: flex; flex-direction: column;"
        style += " align-items: \(alignment.rawValue);"
        if let spacing = spacing {
            style += " gap: \(spacing);"
        }
        attrs["style"] = style
        self.attributes = attrs
        self.spacing = spacing
        self.content = content
    }
    
    /// Creates a new instance.
    public init(alignment: AlignItems = .stretch, spacing: CSSLength, @HTMLBuilder _ content: @escaping () -> [any HTML]) {
        var attrs: [String: String] = [:]
        var style = "display: flex; flex-direction: column;"
        style += " align-items: \(alignment.rawValue);"
        style += " gap: \(spacing.css);"
        attrs["style"] = style
        self.attributes = attrs
        self.spacing = spacing.css
        self.content = content
    }
    
    /// render function.
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        let children = content().map { $0.render() }.joined()
        return "<div\(attrs)>\(children)</div>"
    }
    
    /// padding function.
    public func padding(_ value: String) -> Self {
        var copy = self
        var style = copy.attributes["style"] ?? ""
        style += " padding: \(value);"
        copy.attributes["style"] = style
        return copy
    }
    
    /// background function.
    public func background(_ value: String) -> Self {
        var copy = self
        var style = copy.attributes["style"] ?? ""
        style += " background: \(value);"
        copy.attributes["style"] = style
        return copy
    }
    
    /// frame function.
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
