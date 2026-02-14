//
//  CSSLayoutProperties.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

// MARK: - Layout & Spacing
public func margin(
    _ edges: Edge.Set = .all,
    _ value: any CSSLengthConvertible
) -> CSS {
    let v = value.cssLength

    // Only safe shorthand case
    if edges == .all {
        return CSSProperty("margin", v)
    }

    var props: [CSSProperty] = []

    if edges.contains(.top) {
        props.append(.init("margin-top", v))
    }
    if edges.contains(.bottom) {
        props.append(.init("margin-bottom", v))
    }
    if edges.contains(.leading) {
        props.append(.init("margin-left", v))
    }
    if edges.contains(.trailing) {
        props.append(.init("margin-right", v))
    }

    return CSSPropertyGroup(props)
}

/// margin function.
public func margin(
    _ value: any CSSLengthConvertible
) -> CSS {
    margin(.all, value)
}

/// marginTop function.
public func marginTop(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("margin-top", value.cssLength)
}

/// marginRight function.
public func marginRight(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("margin-right", value.cssLength)
}

/// marginBottom function.
public func marginBottom(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("margin-bottom", value.cssLength)
}

/// marginLeft function.
public func marginLeft(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("margin-left", value.cssLength)
}

/// padding function.
public func padding(
    _ edges: Edge.Set = .all,
    _ value: any CSSLengthConvertible
) -> CSS {
    let v = value.cssLength

    // Only safe shorthand case
    if edges == .all {
        return CSSProperty("padding", v)
    }

    var props: [CSSProperty] = []

    if edges.contains(.top) {
        props.append(.init("padding-top", v))
    }
    if edges.contains(.bottom) {
        props.append(.init("padding-bottom", v))
    }
    if edges.contains(.leading) {
        props.append(.init("padding-left", v))
    }
    if edges.contains(.trailing) {
        props.append(.init("padding-right", v))
    }

    return CSSPropertyGroup(props)
}

/// padding function.
public func padding(
    _ value: any CSSLengthConvertible
) -> CSS {
    padding(.all, value)
}

/// paddingTop function.
public func paddingTop(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("padding-top", value.cssLength)
}

/// paddingRight function.
public func paddingRight(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("padding-right", value.cssLength)
}

/// paddingBottom function.
public func paddingBottom(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("padding-bottom", value.cssLength)
}

/// paddingLeft function.
public func paddingLeft(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("padding-left", value.cssLength)
}

// MARK: - Sizing

public func width(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("width", value.cssLength)
}

/// height function.
public func height(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("height", value.cssLength)
}

/// minWidth function.
public func minWidth(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("min-width", value.cssLength)
}

/// minHeight function.
public func minHeight(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("min-height", value.cssLength)
}

/// maxWidth function.
public func maxWidth(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("max-width", value.cssLength)
}

/// maxHeight function.
public func maxHeight(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("max-height", value.cssLength)
}

// MARK: - Box Sizing & Aspect Ratio

public func boxSizing(_ value: String) -> CSSProperty {
    CSSProperty("box-sizing", value)
}

/// boxSizing function.
public func boxSizing(_ value: BoxSizing) -> CSSProperty {
    CSSProperty("box-sizing", value.rawValue)
}

/// aspectRatio function.
public func aspectRatio(_ value: String) -> CSSProperty {
    CSSProperty("aspect-ratio", value)
}

/// aspectRatio function.
public func aspectRatio(_ width: Double, _ height: Double) -> CSSProperty {
    CSSProperty("aspect-ratio", "\(width) / \(height)")
}

// MARK: - Inset Shorthand

public func inset(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("inset", value.cssLength)
}

/// insetBlock function.
public func insetBlock(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("inset-block", value.cssLength)
}

/// insetInline function.
public func insetInline(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("inset-inline", value.cssLength)
}
