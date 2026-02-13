public struct Route {
    let path: String
    let content: () -> [any HTML]
    
    public init(path: String, @HTMLBuilder content: @escaping () -> [any HTML]) {
        self.path = path
        self.content = content
    }
}

@resultBuilder
public enum RouteBuilder {
    public static func buildBlock(_ components: Route...) -> [Route] {
        Array(components)
    }
    
    public static func buildExpression(_ expression: Route) -> Route {
        expression
    }
    
    public static func buildArray(_ components: [Route]) -> [Route] {
        components
    }
}
