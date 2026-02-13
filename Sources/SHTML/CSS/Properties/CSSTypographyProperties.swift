//
//  CSSTypographyProperties.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

// MARK: - Typography

public func fontSize(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("font-size", value.cssLength)
}

public func fontFamily(_ value: String) -> CSSProperty {
    CSSProperty("font-family", value)
}

public func fontWeight(_ value: String) -> CSSProperty {
    CSSProperty("font-weight", value)
}

public func fontStyle(_ value: String) -> CSSProperty {
    CSSProperty("font-style", value)
}

public func lineHeight(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("line-height", value.cssLength)
}

public func letterSpacing(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("letter-spacing", value.cssLength)
}

public func textAlign(_ value: String) -> CSSProperty {
    CSSProperty("text-align", value)
}

public func textAlign(_ value: TextAlign) -> CSSProperty {
    CSSProperty("text-align", value.rawValue)
}

public func textDecoration(_ value: String) -> CSSProperty {
    CSSProperty("text-decoration", value)
}

public func textTransform(_ value: String) -> CSSProperty {
    CSSProperty("text-transform", value)
}

public func whiteSpace(_ value: String) -> CSSProperty {
    CSSProperty("white-space", value)
}

public func wordSpacing(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("word-spacing", value.cssLength)
}

public func textShadow(_ value: String) -> CSSProperty {
    CSSProperty("text-shadow", value)
}

public func verticalAlign(_ value: String) -> CSSProperty {
    CSSProperty("vertical-align", value)
}

// MARK: - Lists

public func listStyle(_ value: String) -> CSSProperty {
    CSSProperty("list-style", value)
}

public func listStyleType(_ value: String) -> CSSProperty {
    CSSProperty("list-style-type", value)
}

public func listStylePosition(_ value: String) -> CSSProperty {
    CSSProperty("list-style-position", value)
}

public func listStyleImage(_ value: String) -> CSSProperty {
    CSSProperty("list-style-image", value)
}

// MARK: - Advanced Typography

public func textOverflow(_ value: String) -> CSSProperty {
    CSSProperty("text-overflow", value)
}

public func textIndent(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("text-indent", value.cssLength)
}

public func wordBreak(_ value: String) -> CSSProperty {
    CSSProperty("word-break", value)
}

public func wordWrap(_ value: String) -> CSSProperty {
    CSSProperty("word-wrap", value)
}

public func overflowWrap(_ value: String) -> CSSProperty {
    CSSProperty("overflow-wrap", value)
}

public func hyphens(_ value: String) -> CSSProperty {
    CSSProperty("hyphens", value)
}

public func textJustify(_ value: String) -> CSSProperty {
    CSSProperty("text-justify", value)
}

public func writingMode(_ value: String) -> CSSProperty {
    CSSProperty("writing-mode", value)
}

public func textOrientation(_ value: String) -> CSSProperty {
    CSSProperty("text-orientation", value)
}

public func direction(_ value: String) -> CSSProperty {
    CSSProperty("direction", value)
}

public func unicodeBidi(_ value: String) -> CSSProperty {
    CSSProperty("unicode-bidi", value)
}
