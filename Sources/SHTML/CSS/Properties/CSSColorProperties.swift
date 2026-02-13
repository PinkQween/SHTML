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

public func background(_ value: Color) -> CSSProperty {
    CSSProperty("background", value.css)
}

public func backgroundColor(_ value: String) -> CSSProperty {
    CSSProperty("background-color", value)
}

public func backgroundColor(_ value: Color) -> CSSProperty {
    CSSProperty("background-color", value.css)
}

public func color(_ value: String) -> CSSProperty {
    CSSProperty("color", value)
}

public func color(_ value: Color) -> CSSProperty {
    CSSProperty("color", value.css)
}

public func borderColor(_ value: String) -> CSSProperty {
    CSSProperty("border-color", value)
}

public func outlineColor(_ value: String) -> CSSProperty {
    CSSProperty("outline-color", value)
}
