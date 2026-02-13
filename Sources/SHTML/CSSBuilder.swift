//
//  CSSBuilder.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

@resultBuilder
public enum CSSBuilder {
    public static func buildBlock(_ components: CSSProperty...) -> [CSSProperty] {
        components
    }
    
    public static func buildExpression(_ expression: CSSProperty) -> CSSProperty {
        expression
    }
}

@resultBuilder
public enum CSSStyleBuilder {
    public static func buildBlock(_ components: CSS...) -> [CSS] {
        components
    }
    
    public static func buildExpression(_ expression: CSS) -> CSS {
        expression
    }
}

@resultBuilder
public enum CSSKeyframeBuilder {
    public static func buildBlock(_ components: CSSKeyframe...) -> [CSSKeyframe] {
        components
    }
    
    public static func buildExpression(_ expression: CSSKeyframe) -> CSSKeyframe {
        expression
    }
}

// MARK: - Generic Property Creator
public func property(_ name: String, _ value: String) -> CSSProperty {
    CSSProperty(name, value)
}

public func property(_ name: String, _ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty(name, value.cssLength)
}

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

public func padding(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("padding", value.cssLength)
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

public func borderColor(_ value: String) -> CSSProperty {
    CSSProperty("border-color", value)
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

// MARK: - Display & Position

public func display(_ value: String) -> CSSProperty {
    CSSProperty("display", value)
}

public func display(_ value: Display) -> CSSProperty {
    CSSProperty("display", value.rawValue)
}

public func position(_ value: String) -> CSSProperty {
    CSSProperty("position", value)
}

public func position(_ value: Position) -> CSSProperty {
    CSSProperty("position", value.rawValue)
}

public func top(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("top", value.cssLength)
}

public func right(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("right", value.cssLength)
}

public func bottom(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("bottom", value.cssLength)
}

public func left(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("left", value.cssLength)
}

public func zIndex(_ value: Int) -> CSSProperty {
    CSSProperty("z-index", "\(value)")
}

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

// MARK: - Visual Effects

public func opacity(_ value: Double) -> CSSProperty {
    CSSProperty("opacity", "\(value)")
}

public func boxShadow(_ value: String) -> CSSProperty {
    CSSProperty("box-shadow", value)
}

public func textShadow(_ value: String) -> CSSProperty {
    CSSProperty("text-shadow", value)
}

public func overflow(_ value: String) -> CSSProperty {
    CSSProperty("overflow", value)
}

public func overflow(_ value: Overflow) -> CSSProperty {
    CSSProperty("overflow", value.rawValue)
}

public func overflowX(_ value: String) -> CSSProperty {
    CSSProperty("overflow-x", value)
}

public func overflowX(_ value: Overflow) -> CSSProperty {
    CSSProperty("overflow-x", value.rawValue)
}

public func overflowY(_ value: String) -> CSSProperty {
    CSSProperty("overflow-y", value)
}

public func overflowY(_ value: Overflow) -> CSSProperty {
    CSSProperty("overflow-y", value.rawValue)
}

public func cursor(_ value: Cursor) -> CSSProperty {
    CSSProperty("cursor", value.rawValue)
}

public func visibility(_ value: Visibility) -> CSSProperty {
    CSSProperty("visibility", value)
}

// MARK: - Transforms & Transitions

public func transform(_ value: String) -> CSSProperty {
    CSSProperty("transform", value)
}

public func transformOrigin(_ value: String) -> CSSProperty {
    CSSProperty("transform-origin", value)
}

public func transition(_ value: String) -> CSSProperty {
    CSSProperty("transition", value)
}

public func transitionProperty(_ value: String) -> CSSProperty {
    CSSProperty("transition-property", value)
}

public func transitionDuration(_ value: String) -> CSSProperty {
    CSSProperty("transition-duration", value)
}

public func transitionTimingFunction(_ value: String) -> CSSProperty {
    CSSProperty("transition-timing-function", value)
}

public func transitionDelay(_ value: String) -> CSSProperty {
    CSSProperty("transition-delay", value)
}

// MARK: - Animations

public func animation(_ value: String) -> CSSProperty {
    CSSProperty("animation", value)
}

public func animationName(_ value: String) -> CSSProperty {
    CSSProperty("animation-name", value)
}

public func animationDuration(_ value: String) -> CSSProperty {
    CSSProperty("animation-duration", value)
}

public func animationTimingFunction(_ value: String) -> CSSProperty {
    CSSProperty("animation-timing-function", value)
}

public func animationDelay(_ value: String) -> CSSProperty {
    CSSProperty("animation-delay", value)
}

public func animationIterationCount(_ value: String) -> CSSProperty {
    CSSProperty("animation-iteration-count", value)
}

public func animationDirection(_ value: String) -> CSSProperty {
    CSSProperty("animation-direction", value)
}

public func animationFillMode(_ value: String) -> CSSProperty {
    CSSProperty("animation-fill-mode", value)
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

public func outlineColor(_ value: String) -> CSSProperty {
    CSSProperty("outline-color", value)
}

public func outlineStyle(_ value: String) -> CSSProperty {
    CSSProperty("outline-style", value)
}

public func outlineOffset(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("outline-offset", value.cssLength)
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

// MARK: - Other Common Properties

public func objectFit(_ value: String) -> CSSProperty {
    CSSProperty("object-fit", value)
}

public func objectPosition(_ value: String) -> CSSProperty {
    CSSProperty("object-position", value)
}

public func backdropFilter(_ value: String) -> CSSProperty {
    CSSProperty("backdrop-filter", value)
}

public func filter(_ value: String) -> CSSProperty {
    CSSProperty("filter", value)
}

public func clipPath(_ value: String) -> CSSProperty {
    CSSProperty("clip-path", value)
}

public func userSelect(_ value: String) -> CSSProperty {
    CSSProperty("user-select", value)
}

public func pointerEvents(_ value: String) -> CSSProperty {
    CSSProperty("pointer-events", value)
}

public func resize(_ value: String) -> CSSProperty {
    CSSProperty("resize", value)
}

public func verticalAlign(_ value: String) -> CSSProperty {
    CSSProperty("vertical-align", value)
}

public func float(_ value: String) -> CSSProperty {
    CSSProperty("float", value)
}

public func clear(_ value: String) -> CSSProperty {
    CSSProperty("clear", value)
}

public func content(_ value: String) -> CSSProperty {
    CSSProperty("content", value)
}

