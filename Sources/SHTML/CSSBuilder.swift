//
//  CSSBuilder.swift
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

// Convenience functions for creating CSS properties
public func property(_ name: String, _ value: String) -> CSSProperty {
    CSSProperty(name, value)
}

// Common CSS properties
public func margin(_ value: String) -> CSSProperty {
    CSSProperty("margin", value)
}

public func padding(_ value: String) -> CSSProperty {
    CSSProperty("padding", value)
}

public func background(_ value: String) -> CSSProperty {
    CSSProperty("background", value)
}

public func color(_ value: String) -> CSSProperty {
    CSSProperty("color", value)
}

public func fontSize(_ value: String) -> CSSProperty {
    CSSProperty("font-size", value)
}

public func fontFamily(_ value: String) -> CSSProperty {
    CSSProperty("font-family", value)
}

public func fontWeight(_ value: String) -> CSSProperty {
    CSSProperty("font-weight", value)
}

public func display(_ value: String) -> CSSProperty {
    CSSProperty("display", value)
}

public func position(_ value: String) -> CSSProperty {
    CSSProperty("position", value)
}

public func width(_ value: String) -> CSSProperty {
    CSSProperty("width", value)
}

public func height(_ value: String) -> CSSProperty {
    CSSProperty("height", value)
}

public func maxWidth(_ value: String) -> CSSProperty {
    CSSProperty("max-width", value)
}

public func minHeight(_ value: String) -> CSSProperty {
    CSSProperty("min-height", value)
}

public func borderRadius(_ value: String) -> CSSProperty {
    CSSProperty("border-radius", value)
}

public func boxShadow(_ value: String) -> CSSProperty {
    CSSProperty("box-shadow", value)
}

public func border(_ value: String) -> CSSProperty {
    CSSProperty("border", value)
}

public func borderLeft(_ value: String) -> CSSProperty {
    CSSProperty("border-left", value)
}

public func textAlign(_ value: String) -> CSSProperty {
    CSSProperty("text-align", value)
}

public func textDecoration(_ value: String) -> CSSProperty {
    CSSProperty("text-decoration", value)
}

public func opacity(_ value: String) -> CSSProperty {
    CSSProperty("opacity", value)
}

public func transform(_ value: String) -> CSSProperty {
    CSSProperty("transform", value)
}

public func transition(_ value: String) -> CSSProperty {
    CSSProperty("transition", value)
}

public func animation(_ value: String) -> CSSProperty {
    CSSProperty("animation", value)
}

public func gap(_ value: String) -> CSSProperty {
    CSSProperty("gap", value)
}

public func flexDirection(_ value: String) -> CSSProperty {
    CSSProperty("flex-direction", value)
}

public func justifyContent(_ value: String) -> CSSProperty {
    CSSProperty("justify-content", value)
}

public func alignItems(_ value: String) -> CSSProperty {
    CSSProperty("align-items", value)
}

public func boxSizing(_ value: String) -> CSSProperty {
    CSSProperty("box-sizing", value)
}

public func listStylePosition(_ value: String) -> CSSProperty {
    CSSProperty("list-style-position", value)
}
