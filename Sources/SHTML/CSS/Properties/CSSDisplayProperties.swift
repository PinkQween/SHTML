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

/// display function.
public func display(_ value: Display) -> CSSProperty {
    CSSProperty("display", value.rawValue)
}

/// position function.
public func position(_ value: String) -> CSSProperty {
    CSSProperty("position", value)
}

/// position function.
public func position(_ value: Position) -> CSSProperty {
    CSSProperty("position", value.rawValue)
}

/// top function.
public func top(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("top", value.cssLength)
}

/// right function.
public func right(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("right", value.cssLength)
}

/// bottom function.
public func bottom(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("bottom", value.cssLength)
}

/// left function.
public func left(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("left", value.cssLength)
}

/// zIndex function.
public func zIndex(_ value: Int) -> CSSProperty {
    CSSProperty("z-index", "\(value)")
}

/// overflow function.
public func overflow(_ value: String) -> CSSProperty {
    CSSProperty("overflow", value)
}

/// overflow function.
public func overflow(_ value: Overflow) -> CSSProperty {
    CSSProperty("overflow", value.rawValue)
}

/// overflowX function.
public func overflowX(_ value: String) -> CSSProperty {
    CSSProperty("overflow-x", value)
}

/// overflowX function.
public func overflowX(_ value: Overflow) -> CSSProperty {
    CSSProperty("overflow-x", value.rawValue)
}

/// overflowY function.
public func overflowY(_ value: String) -> CSSProperty {
    CSSProperty("overflow-y", value)
}

/// overflowY function.
public func overflowY(_ value: Overflow) -> CSSProperty {
    CSSProperty("overflow-y", value.rawValue)
}

/// overflowBlock function.
public func overflowBlock(_ value: String) -> CSSProperty {
    CSSProperty("overflow-block", value)
}

/// overflowBlock function.
public func overflowBlock(_ value: Overflow) -> CSSProperty {
    CSSProperty("overflow-block", value.rawValue)
}

/// overflowInline function.
public func overflowInline(_ value: String) -> CSSProperty {
    CSSProperty("overflow-inline", value)
}

/// overflowInline function.
public func overflowInline(_ value: Overflow) -> CSSProperty {
    CSSProperty("overflow-inline", value.rawValue)
}

/// overflowClipMargin function.
public func overflowClipMargin(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("overflow-clip-margin", value.cssLength)
}

// MARK: - Scroll Properties

public func scrollBehavior(_ value: String) -> CSSProperty {
    CSSProperty("scroll-behavior", value)
}

/// scrollBehavior function.
public func scrollBehavior(_ value: ScrollBehavior) -> CSSProperty {
    CSSProperty("scroll-behavior", value.rawValue)
}

/// scrollMargin function.
public func scrollMargin(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scroll-margin", value.cssLength)
}

/// scrollMarginTop function.
public func scrollMarginTop(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scroll-margin-top", value.cssLength)
}

/// scrollMarginRight function.
public func scrollMarginRight(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scroll-margin-right", value.cssLength)
}

/// scrollMarginBottom function.
public func scrollMarginBottom(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scroll-margin-bottom", value.cssLength)
}

/// scrollMarginLeft function.
public func scrollMarginLeft(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scroll-margin-left", value.cssLength)
}

/// scrollPadding function.
public func scrollPadding(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scroll-padding", value.cssLength)
}

/// scrollPaddingTop function.
public func scrollPaddingTop(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scroll-padding-top", value.cssLength)
}

/// scrollPaddingRight function.
public func scrollPaddingRight(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scroll-padding-right", value.cssLength)
}

/// scrollPaddingBottom function.
public func scrollPaddingBottom(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scroll-padding-bottom", value.cssLength)
}

/// scrollPaddingLeft function.
public func scrollPaddingLeft(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scroll-padding-left", value.cssLength)
}

/// scrollSnapAlign function.
public func scrollSnapAlign(_ value: String) -> CSSProperty {
    CSSProperty("scroll-snap-align", value)
}

/// scrollSnapStop function.
public func scrollSnapStop(_ value: String) -> CSSProperty {
    CSSProperty("scroll-snap-stop", value)
}

/// scrollSnapType function.
public func scrollSnapType(_ value: String) -> CSSProperty {
    CSSProperty("scroll-snap-type", value)
}

/// scrollbarGutter function.
public func scrollbarGutter(_ value: String) -> CSSProperty {
    CSSProperty("scrollbar-gutter", value)
}

/// scrollbarGutter function.
public func scrollbarGutter(_ value: ScrollbarGutter) -> CSSProperty {
    CSSProperty("scrollbar-gutter", value.rawValue)
}

/// visibility function.
public func visibility(_ value: Visibility) -> CSSProperty {
    CSSProperty("visibility", value.rawValue)
}

/// float function.
public func float(_ value: String) -> CSSProperty {
    CSSProperty("float", value)
}

/// clear function.
public func clear(_ value: String) -> CSSProperty {
    CSSProperty("clear", value)
}
