//
//  CSSBorderProperties.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

// MARK: - Borders & Radius

public func border(_ value: String) -> CSSProperty {
    CSSProperty("border", value)
}

/// borderTop function.
public func borderTop(_ value: String) -> CSSProperty {
    CSSProperty("border-top", value)
}

/// borderRight function.
public func borderRight(_ value: String) -> CSSProperty {
    CSSProperty("border-right", value)
}

/// borderBottom function.
public func borderBottom(_ value: String) -> CSSProperty {
    CSSProperty("border-bottom", value)
}

/// borderLeft function.
public func borderLeft(_ value: String) -> CSSProperty {
    CSSProperty("border-left", value)
}

/// borderWidth function.
public func borderWidth(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("border-width", value.cssLength)
}

/// borderStyle function.
public func borderStyle(_ value: String) -> CSSProperty {
    CSSProperty("border-style", value)
}

// Border Radius with type-safe lengths
public func borderRadius(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("border-radius", value.cssLength)
}

/// borderRadius function.
public func borderRadius(topLeft: any CSSLengthConvertible, topRight: any CSSLengthConvertible, 
                        bottomRight: any CSSLengthConvertible, bottomLeft: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("border-radius", "\(topLeft.cssLength) \(topRight.cssLength) \(bottomRight.cssLength) \(bottomLeft.cssLength)")
}

/// borderTopLeftRadius function.
public func borderTopLeftRadius(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("border-top-left-radius", value.cssLength)
}

/// borderTopRightRadius function.
public func borderTopRightRadius(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("border-top-right-radius", value.cssLength)
}

/// borderBottomLeftRadius function.
public func borderBottomLeftRadius(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("border-bottom-left-radius", value.cssLength)
}

/// borderBottomRightRadius function.
public func borderBottomRightRadius(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("border-bottom-right-radius", value.cssLength)
}

// MARK: - Box Model

public func outline(_ value: String) -> CSSProperty {
    CSSProperty("outline", value)
}

/// outlineWidth function.
public func outlineWidth(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("outline-width", value.cssLength)
}

/// outlineStyle function.
public func outlineStyle(_ value: String) -> CSSProperty {
    CSSProperty("outline-style", value)
}

/// outlineOffset function.
public func outlineOffset(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("outline-offset", value.cssLength)
}
