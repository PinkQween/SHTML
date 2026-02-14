//
//  CSSColorProperties.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

// MARK: - Colors

public func background(_ value: String) -> CSSProperty {
    CSSProperty("background", value)
}

/// background function.
public func background(_ value: Color) -> CSSProperty {
    CSSProperty("background", value.css)
}

/// backgroundColor function.
public func backgroundColor(_ value: String) -> CSSProperty {
    CSSProperty("background-color", value)
}

/// backgroundColor function.
public func backgroundColor(_ value: Color) -> CSSProperty {
    CSSProperty("background-color", value.css)
}

/// color function.
public func color(_ value: String) -> CSSProperty {
    CSSProperty("color", value)
}

/// color function.
public func color(_ value: Color) -> CSSProperty {
    CSSProperty("color", value.css)
}

/// borderColor function.
public func borderColor(_ value: String) -> CSSProperty {
    CSSProperty("border-color", value)
}

/// outlineColor function.
public func outlineColor(_ value: String) -> CSSProperty {
    CSSProperty("outline-color", value)
}
