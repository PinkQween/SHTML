//
//  CSSBuilders.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

@resultBuilder
public enum CSSBuilder {
    public static func buildBlock(_ components: CSSProperty...) -> [CSSProperty] {
        components
    }
    
    public static func buildExpression(_ expression: CSSProperty) -> CSSProperty {
        expression
    }
    
    public static func buildExpression(_ expression: [CSSProperty]) -> [CSSProperty] {
        expression
    }
    
    public static func buildArray(_ components: [[CSSProperty]]) -> [CSSProperty] {
        components.flatMap { $0 }
    }
}

@resultBuilder
public enum CSSStyleBuilder {
    public static func buildBlock(_ components: CSS...) -> [CSS] {
        components
    }
    
    public static func buildExpression(_ expression: CSS) -> CSS {
        expression
    }
}

@resultBuilder
public enum CSSKeyframeBuilder {
    public static func buildBlock(_ components: CSSKeyframe...) -> [CSSKeyframe] {
        components
    }
    
    public static func buildExpression(_ expression: CSSKeyframe) -> CSSKeyframe {
        expression
    }
}

// MARK: - Generic Property Creator
public func property(_ name: String, _ value: String) -> CSSProperty {
    CSSProperty(name, value)
}

public func property(_ name: String, _ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty(name, value.cssLength)
}
