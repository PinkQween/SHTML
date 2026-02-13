public struct RouterLink: HTML, HTMLModifiable {
    public var attributes: [String: String]
    private let to: String
    private let replace: Bool
    private let content: () -> [any HTML]
    
    public init(
        to: String,
        replace: Bool = false,
        @HTMLBuilder content: @escaping () -> [any HTML]
    ) {
        self.to = to
        self.replace = replace
        self.content = content
        self.attributes = [:]
    }
    
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        let children = content().map { $0.render() }.joined()
        let replaceParam = replace ? "true" : "false"
        
        return """
        <a href="\(to)" onclick="event.preventDefault(); window.navigate('\(to)', \(replaceParam));"\(attrs)>
        \(children)
        </a>
        """
    }
}
