//
//  CSSLayoutProperties.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

// MARK: - Layout & Spacing

public func margin(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("margin", value.cssLength)
}

public func marginTop(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("margin-top", value.cssLength)
}

public func marginRight(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("margin-right", value.cssLength)
}

public func marginBottom(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("margin-bottom", value.cssLength)
}

public func marginLeft(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("margin-left", value.cssLength)
}

public func padding(
    _ edges: Edge.Set = .all,
    _ value: any CSSLengthConvertible
) -> CSSProperty {
    let v = value.cssLength

    // Only safe shorthand case
    if edges == .all {
        return .init("padding", v)
    }

    var parts: [String] = []

    if edges.contains(.top) {
        parts.append("padding-top: \(v);")
    }
    if edges.contains(.bottom) {
        parts.append("padding-bottom: \(v);")
    }
    if edges.contains(.leading) {
        parts.append("padding-left: \(v);")
    }
    if edges.contains(.trailing) {
        parts.append("padding-right: \(v);")
    }

    return .init("style", parts.joined(separator: " "))
}

public func padding(
    _ value: any CSSLengthConvertible
) -> CSSProperty {
    padding(.all, value)
}

public func paddingTop(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("padding-top", value.cssLength)
}

public func paddingRight(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("padding-right", value.cssLength)
}

public func paddingBottom(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("padding-bottom", value.cssLength)
}

public func paddingLeft(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("padding-left", value.cssLength)
}

// MARK: - Sizing

public func width(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("width", value.cssLength)
}

public func height(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("height", value.cssLength)
}

public func minWidth(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("min-width", value.cssLength)
}

public func minHeight(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("min-height", value.cssLength)
}

public func maxWidth(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("max-width", value.cssLength)
}

public func maxHeight(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("max-height", value.cssLength)
}

// MARK: - Box Sizing & Aspect Ratio

public func boxSizing(_ value: String) -> CSSProperty {
    CSSProperty("box-sizing", value)
}

public func boxSizing(_ value: BoxSizing) -> CSSProperty {
    CSSProperty("box-sizing", value.rawValue)
}

public func aspectRatio(_ value: String) -> CSSProperty {
    CSSProperty("aspect-ratio", value)
}

public func aspectRatio(_ width: Double, _ height: Double) -> CSSProperty {
    CSSProperty("aspect-ratio", "\(width) / \(height)")
}

// MARK: - Inset Shorthand

public func inset(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("inset", value.cssLength)
}

public func insetBlock(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("inset-block", value.cssLength)
}

public func insetInline(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("inset-inline", value.cssLength)
}
