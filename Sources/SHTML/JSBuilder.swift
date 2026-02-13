//
//  JSBuilder.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

@resultBuilder
public enum JSBuilder {
    public static func buildBlock(_ components: [any JavaScript]...) -> [any JavaScript] {
        components.flatMap { $0 }
    }

    public static func buildExpression(_ expression: any JavaScript) -> [any JavaScript] {
        [expression]
    }

    public static func buildExpression(_ expression: String) -> [any JavaScript] {
        [JSRaw(expression)]
    }

    public static func buildExpression(_ expression: [any JavaScript]) -> [any JavaScript] {
        expression
    }

    public static func buildExpression(_ component: [any JavaScript]?) -> [any JavaScript] {
        component ?? []
    }

    public static func buildOptional(_ component: [any JavaScript]?) -> [any JavaScript] {
        component ?? []
    }

    public static func buildEither(first component: [any JavaScript]) -> [any JavaScript] {
        component
    }

    public static func buildEither(second component: [any JavaScript]) -> [any JavaScript] {
        component
    }

    public static func buildArray(_ components: [[any JavaScript]]) -> [any JavaScript] {
        components.flatMap { $0 }
    }

    public static func buildLimitedAvailability(_ component: [any JavaScript]) -> [any JavaScript] {
        component
    }
}

// Helper for rendering JS statements
public enum JSRendering {
    public static func renderStatements(_ content: () -> [any JavaScript]) -> String {
        content().map { $0.render() }.joined(separator: "\n")
    }
}
