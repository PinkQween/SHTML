//
//  CSSFlexboxProperties.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

// MARK: - Flexbox

public func flexDirection(_ value: String) -> CSSProperty {
    CSSProperty("flex-direction", value)
}

/// flexDirection function.
public func flexDirection(_ value: FlexDirection) -> CSSProperty {
    CSSProperty("flex-direction", value.rawValue)
}

/// justifyContent function.
public func justifyContent(_ value: String) -> CSSProperty {
    CSSProperty("justify-content", value)
}

/// justifyContent function.
public func justifyContent(_ value: JustifyContent) -> CSSProperty {
    CSSProperty("justify-content", value.rawValue)
}

/// alignItems function.
public func alignItems(_ value: String) -> CSSProperty {
    CSSProperty("align-items", value)
}

/// alignItems function.
public func alignItems(_ value: AlignItems) -> CSSProperty {
    CSSProperty("align-items", value.rawValue)
}

/// alignSelf function.
public func alignSelf(_ value: String) -> CSSProperty {
    CSSProperty("align-self", value)
}

/// alignSelf function.
public func alignSelf(_ value: AlignItems) -> CSSProperty {
    CSSProperty("align-self", value.rawValue)
}

/// alignContent function.
public func alignContent(_ value: String) -> CSSProperty {
    CSSProperty("align-content", value)
}

/// alignContent function.
public func alignContent(_ value: AlignItems) -> CSSProperty {
    CSSProperty("align-content", value.rawValue)
}

/// flexWrap function.
public func flexWrap(_ value: String) -> CSSProperty {
    CSSProperty("flex-wrap", value)
}

/// flex function.
public func flex(_ value: String) -> CSSProperty {
    CSSProperty("flex", value)
}

/// flexGrow function.
public func flexGrow(_ value: Int) -> CSSProperty {
    CSSProperty("flex-grow", "\(value)")
}

/// flexShrink function.
public func flexShrink(_ value: Int) -> CSSProperty {
    CSSProperty("flex-shrink", "\(value)")
}

/// flexBasis function.
public func flexBasis(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("flex-basis", value.cssLength)
}

/// gap function.
public func gap(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("gap", value.cssLength)
}

/// rowGap function.
public func rowGap(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("row-gap", value.cssLength)
}

/// columnGap function.
public func columnGap(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("column-gap", value.cssLength)
}

// MARK: - Grid

public func gridTemplateColumns(_ value: String) -> CSSProperty {
    CSSProperty("grid-template-columns", value)
}

/// gridTemplateRows function.
public func gridTemplateRows(_ value: String) -> CSSProperty {
    CSSProperty("grid-template-rows", value)
}

/// gridColumn function.
public func gridColumn(_ value: String) -> CSSProperty {
    CSSProperty("grid-column", value)
}

/// gridRow function.
public func gridRow(_ value: String) -> CSSProperty {
    CSSProperty("grid-row", value)
}

/// gridArea function.
public func gridArea(_ value: String) -> CSSProperty {
    CSSProperty("grid-area", value)
}
