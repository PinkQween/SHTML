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

public func borderTop(_ value: String) -> CSSProperty {
    CSSProperty("border-top", value)
}

public func borderRight(_ value: String) -> CSSProperty {
    CSSProperty("border-right", value)
}

public func borderBottom(_ value: String) -> CSSProperty {
    CSSProperty("border-bottom", value)
}

public func borderLeft(_ value: String) -> CSSProperty {
    CSSProperty("border-left", value)
}

public func borderWidth(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("border-width", value.cssLength)
}

public func borderStyle(_ value: String) -> CSSProperty {
    CSSProperty("border-style", value)
}

// Border Radius with type-safe lengths
public func borderRadius(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("border-radius", value.cssLength)
}

public func borderRadius(topLeft: any CSSLengthConvertible, topRight: any CSSLengthConvertible, 
                        bottomRight: any CSSLengthConvertible, bottomLeft: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("border-radius", "\(topLeft.cssLength) \(topRight.cssLength) \(bottomRight.cssLength) \(bottomLeft.cssLength)")
}

public func borderTopLeftRadius(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("border-top-left-radius", value.cssLength)
}

public func borderTopRightRadius(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("border-top-right-radius", value.cssLength)
}

public func borderBottomLeftRadius(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("border-bottom-left-radius", value.cssLength)
}

public func borderBottomRightRadius(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("border-bottom-right-radius", value.cssLength)
}

// MARK: - Box Model

public func boxSizing(_ value: String) -> CSSProperty {
    CSSProperty("box-sizing", value)
}

public func outline(_ value: String) -> CSSProperty {
    CSSProperty("outline", value)
}

public func outlineWidth(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("outline-width", value.cssLength)
}

public func outlineStyle(_ value: String) -> CSSProperty {
    CSSProperty("outline-style", value)
}

public func outlineOffset(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("outline-offset", value.cssLength)
}
