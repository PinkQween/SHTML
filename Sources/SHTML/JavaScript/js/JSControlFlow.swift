//
//  JSControlFlow.swift
//  SHTML
//

public struct JSIf: JavaScript {
    private let condition: JSExpr
    private let body: () -> [any JavaScript]

    /// Creates a new instance.
    public init(
        _ condition: JSExpr,
        @JSBuilder body: @escaping () -> [any JavaScript]
    ) {
        self.condition = condition
        self.body = body
    }

    /// render function.
    public func render() -> String {
        let statements = JSRendering.renderStatements(body)
        return """
        if (\(condition.render())) {
            \(statements)
        }
        """
    }
}
