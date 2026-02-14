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

/// fontFamily function.
public func fontFamily(_ value: String) -> CSSProperty {
    CSSProperty("font-family", value)
}

/// fontWeight function.
public func fontWeight(_ value: String) -> CSSProperty {
    CSSProperty("font-weight", value)
}

/// fontStyle function.
public func fontStyle(_ value: String) -> CSSProperty {
    CSSProperty("font-style", value)
}

/// fontStyle function.
public func fontStyle(_ value: FontStyle) -> CSSProperty {
    CSSProperty("font-style", value.rawValue)
}

/// lineHeight function.
public func lineHeight(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("line-height", value.cssLength)
}

/// letterSpacing function.
public func letterSpacing(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("letter-spacing", value.cssLength)
}

/// textAlign function.
public func textAlign(_ value: String) -> CSSProperty {
    CSSProperty("text-align", value)
}

/// textAlign function.
public func textAlign(_ value: TextAlign) -> CSSProperty {
    CSSProperty("text-align", value.rawValue)
}

/// textDecoration function.
public func textDecoration(_ value: String) -> CSSProperty {
    CSSProperty("text-decoration", value)
}

/// textDecoration function.
public func textDecoration(_ value: TextDecoration) -> CSSProperty {
    CSSProperty("text-decoration", value.rawValue)
}

/// textTransform function.
public func textTransform(_ value: String) -> CSSProperty {
    CSSProperty("text-transform", value)
}

/// textTransform function.
public func textTransform(_ value: TextTransform) -> CSSProperty {
    CSSProperty("text-transform", value.rawValue)
}

/// whiteSpace function.
public func whiteSpace(_ value: String) -> CSSProperty {
    CSSProperty("white-space", value)
}

/// whiteSpace function.
public func whiteSpace(_ value: WhiteSpace) -> CSSProperty {
    CSSProperty("white-space", value.rawValue)
}

/// wordSpacing function.
public func wordSpacing(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("word-spacing", value.cssLength)
}

/// textShadow function.
public func textShadow(_ value: String) -> CSSProperty {
    CSSProperty("text-shadow", value)
}

/// verticalAlign function.
public func verticalAlign(_ value: String) -> CSSProperty {
    CSSProperty("vertical-align", value)
}

/// verticalAlign function.
public func verticalAlign(_ value: VerticalAlign) -> CSSProperty {
    CSSProperty("vertical-align", value.rawValue)
}

// MARK: - Lists

public func listStyle(_ value: String) -> CSSProperty {
    CSSProperty("list-style", value)
}

/// listStyleType function.
public func listStyleType(_ value: String) -> CSSProperty {
    CSSProperty("list-style-type", value)
}

/// listStylePosition function.
public func listStylePosition(_ value: String) -> CSSProperty {
    CSSProperty("list-style-position", value)
}

/// listStyleImage function.
public func listStyleImage(_ value: String) -> CSSProperty {
    CSSProperty("list-style-image", value)
}

// MARK: - Advanced Typography

public func textOverflow(_ value: String) -> CSSProperty {
    CSSProperty("text-overflow", value)
}

/// textIndent function.
public func textIndent(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("text-indent", value.cssLength)
}

/// wordBreak function.
public func wordBreak(_ value: String) -> CSSProperty {
    CSSProperty("word-break", value)
}

/// wordWrap function.
public func wordWrap(_ value: String) -> CSSProperty {
    CSSProperty("word-wrap", value)
}

/// overflowWrap function.
public func overflowWrap(_ value: String) -> CSSProperty {
    CSSProperty("overflow-wrap", value)
}

/// hyphens function.
public func hyphens(_ value: String) -> CSSProperty {
    CSSProperty("hyphens", value)
}

/// textJustify function.
public func textJustify(_ value: String) -> CSSProperty {
    CSSProperty("text-justify", value)
}

/// writingMode function.
public func writingMode(_ value: String) -> CSSProperty {
    CSSProperty("writing-mode", value)
}

/// textOrientation function.
public func textOrientation(_ value: String) -> CSSProperty {
    CSSProperty("text-orientation", value)
}

/// direction function.
public func direction(_ value: String) -> CSSProperty {
    CSSProperty("direction", value)
}

/// unicodeBidi function.
public func unicodeBidi(_ value: String) -> CSSProperty {
    CSSProperty("unicode-bidi", value)
}
