public struct RouterLink: HTML, HTMLModifiable {
    public var attributes: [String: String]
    private let to: String
    private let replace: Bool
    public let content: () -> [any HTML]
    
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
        let escapedTo = to
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "'", with: "\\'")
        
        return """
        <a href="\(to)" onclick="event.preventDefault(); if (window.navigate) { window.navigate('\(escapedTo)', \(replaceParam)); } else { window.location.href = '\(escapedTo)'; }"\(attrs)>
        \(children)
        </a>
        """
    }
}
