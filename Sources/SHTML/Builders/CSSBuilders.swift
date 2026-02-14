//
//  CSSBuilders.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

@resultBuilder
/// CSSBuilder type.
public enum CSSBuilder {
    public static func buildBlock(_ components: CSS...) -> [CSS] {
        components
    }
    
    public static func buildExpression(_ expression: CSS) -> CSS {
        expression
    }
    
    public static func buildArray(_ components: [[CSS]]) -> [CSS] {
        components.flatMap { $0 }
    }
}

@resultBuilder
/// CSSStyleBuilder type.
public enum CSSStyleBuilder {
    public static func buildBlock(_ components: CSS...) -> [CSS] {
        components
    }
    
    public static func buildExpression(_ expression: CSS) -> CSS {
        expression
    }
}

@resultBuilder
/// CSSKeyframeBuilder type.
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

/// property function.
public func property(_ name: String, _ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty(name, value.cssLength)
}
