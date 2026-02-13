//
//  CSSDisplayProperties.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

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

public func overflowBlock(_ value: String) -> CSSProperty {
    CSSProperty("overflow-block", value)
}

public func overflowBlock(_ value: Overflow) -> CSSProperty {
    CSSProperty("overflow-block", value.rawValue)
}

public func overflowInline(_ value: String) -> CSSProperty {
    CSSProperty("overflow-inline", value)
}

public func overflowInline(_ value: Overflow) -> CSSProperty {
    CSSProperty("overflow-inline", value.rawValue)
}

public func overflowClipMargin(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("overflow-clip-margin", value.cssLength)
}

// MARK: - Scroll Properties

public func scrollBehavior(_ value: String) -> CSSProperty {
    CSSProperty("scroll-behavior", value)
}

public func scrollBehavior(_ value: ScrollBehavior) -> CSSProperty {
    CSSProperty("scroll-behavior", value.rawValue)
}

public func scrollMargin(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scroll-margin", value.cssLength)
}

public func scrollMarginTop(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scroll-margin-top", value.cssLength)
}

public func scrollMarginRight(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scroll-margin-right", value.cssLength)
}

public func scrollMarginBottom(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scroll-margin-bottom", value.cssLength)
}

public func scrollMarginLeft(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scroll-margin-left", value.cssLength)
}

public func scrollPadding(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scroll-padding", value.cssLength)
}

public func scrollPaddingTop(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scroll-padding-top", value.cssLength)
}

public func scrollPaddingRight(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scroll-padding-right", value.cssLength)
}

public func scrollPaddingBottom(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scroll-padding-bottom", value.cssLength)
}

public func scrollPaddingLeft(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scroll-padding-left", value.cssLength)
}

public func scrollSnapAlign(_ value: String) -> CSSProperty {
    CSSProperty("scroll-snap-align", value)
}

public func scrollSnapStop(_ value: String) -> CSSProperty {
    CSSProperty("scroll-snap-stop", value)
}

public func scrollSnapType(_ value: String) -> CSSProperty {
    CSSProperty("scroll-snap-type", value)
}

public func scrollbarGutter(_ value: String) -> CSSProperty {
    CSSProperty("scrollbar-gutter", value)
}

public func scrollbarGutter(_ value: ScrollbarGutter) -> CSSProperty {
    CSSProperty("scrollbar-gutter", value.rawValue)
}

public func visibility(_ value: Visibility) -> CSSProperty {
    CSSProperty("visibility", value.rawValue)
}

public func float(_ value: String) -> CSSProperty {
    CSSProperty("float", value)
}

public func clear(_ value: String) -> CSSProperty {
    CSSProperty("clear", value)
}
