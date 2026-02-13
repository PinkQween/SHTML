//
//  HTMLBuilder.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

@resultBuilder
public enum HTMLBuilder {
    public static func buildBlock(_ components: [any HTML]...) -> [any HTML] {
        components.flatMap { $0 }
    }

    public static func buildExpression(_ expression: any HTML) -> [any HTML] {
        [expression]
    }

    public static func buildExpression(_ expression: String) -> [any HTML] {
        [Text(expression)]
    }

    public static func buildExpression(_ expression: [any HTML]) -> [any HTML] {
        expression
    }

    public static func buildExpression(_ component: [any HTML]?) -> [any HTML] {
        component ?? []
    }

    public static func buildOptional(_ component: [any HTML]?) -> [any HTML] {
        component ?? []
    }

    public static func buildEither(first component: [any HTML]) -> [any HTML] {
        component
    }

    public static func buildEither(second component: [any HTML]) -> [any HTML] {
        component
    }

    public static func buildArray(_ components: [[any HTML]]) -> [any HTML] {
        components.flatMap { $0 }
    }

    public static func buildLimitedAvailability(_ component: [any HTML]) -> [any HTML] {
        component
    }
}
