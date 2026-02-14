/// A route definition used by ``Router``.
public struct Route {
    let path: String
    let content: () -> [any HTML]
    
    /// Creates a route with a path pattern and HTML content builder.
    public init(path: String, @HTMLBuilder content: @escaping () -> [any HTML]) {
        self.path = path
        self.content = content
    }
}

/// Result builder used to construct route lists in ``Router``.
@resultBuilder
/// RouteBuilder type.
public enum RouteBuilder {
    /// Combines route components into an array.
    public static func buildBlock(_ components: Route...) -> [Route] {
        Array(components)
    }
    
    /// Handles a single route expression.
    public static func buildExpression(_ expression: Route) -> Route {
        expression
    }
    
    /// Handles route arrays from control-flow constructs.
    public static func buildArray(_ components: [Route]) -> [Route] {
        components
    }
}
