// Document builder for full HTML pages (like SwiftUI's Scene)
public struct Document: HTML {
    private let title: String
    private let styles: String?
    private let scripts: String?
    private let content: () -> [any HTML]
    
    public init(
        title: String,
        styles: String? = nil,
        scripts: String? = nil,
        @HTMLBuilder content: @escaping () -> [any HTML]
    ) {
        self.title = title
        self.styles = styles
        self.scripts = scripts
        self.content = content
    }
    
    public func render() -> String {
        var html = """
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>\(title)</title>
        """
        
        if let styles = styles {
            html += "\n<style>\(styles)</style>"
        }
        
        html += "\n</head>\n<body>"
        html += content().map { $0.render() }.joined()
        html += "</body>"
        
        if let scripts = scripts {
            html += "\n<script>\(scripts)</script>"
        }
        
        html += "\n</html>"
        return html
    }
}
