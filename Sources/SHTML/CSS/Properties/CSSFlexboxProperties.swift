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

public func flexDirection(_ value: FlexDirection) -> CSSProperty {
    CSSProperty("flex-direction", value.rawValue)
}

public func justifyContent(_ value: String) -> CSSProperty {
    CSSProperty("justify-content", value)
}

public func justifyContent(_ value: JustifyContent) -> CSSProperty {
    CSSProperty("justify-content", value.rawValue)
}

public func alignItems(_ value: String) -> CSSProperty {
    CSSProperty("align-items", value)
}

public func alignItems(_ value: AlignItems) -> CSSProperty {
    CSSProperty("align-items", value.rawValue)
}

public func alignSelf(_ value: String) -> CSSProperty {
    CSSProperty("align-self", value)
}

public func alignSelf(_ value: AlignItems) -> CSSProperty {
    CSSProperty("align-self", value.rawValue)
}

public func alignContent(_ value: String) -> CSSProperty {
    CSSProperty("align-content", value)
}

public func alignContent(_ value: AlignItems) -> CSSProperty {
    CSSProperty("align-content", value.rawValue)
}

public func flexWrap(_ value: String) -> CSSProperty {
    CSSProperty("flex-wrap", value)
}

public func flex(_ value: String) -> CSSProperty {
    CSSProperty("flex", value)
}

public func flexGrow(_ value: Int) -> CSSProperty {
    CSSProperty("flex-grow", "\(value)")
}

public func flexShrink(_ value: Int) -> CSSProperty {
    CSSProperty("flex-shrink", "\(value)")
}

public func flexBasis(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("flex-basis", value.cssLength)
}

public func gap(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("gap", value.cssLength)
}

public func rowGap(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("row-gap", value.cssLength)
}

public func columnGap(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("column-gap", value.cssLength)
}

// MARK: - Grid

public func gridTemplateColumns(_ value: String) -> CSSProperty {
    CSSProperty("grid-template-columns", value)
}

public func gridTemplateRows(_ value: String) -> CSSProperty {
    CSSProperty("grid-template-rows", value)
}

public func gridColumn(_ value: String) -> CSSProperty {
    CSSProperty("grid-column", value)
}

public func gridRow(_ value: String) -> CSSProperty {
    CSSProperty("grid-row", value)
}

public func gridArea(_ value: String) -> CSSProperty {
    CSSProperty("grid-area", value)
}
