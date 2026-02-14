//
//  CSSVisualProperties.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

// MARK: - Visual Effects

public func opacity(_ value: Double) -> CSSProperty {
    CSSProperty("opacity", "\(value)")
}

/// boxShadow function.
public func boxShadow(_ value: String) -> CSSProperty {
    CSSProperty("box-shadow", value)
}

/// cursor function.
public func cursor(_ value: Cursor) -> CSSProperty {
    CSSProperty("cursor", value.rawValue)
}

// MARK: - Transforms & Transitions

public func transform(_ value: String) -> CSSProperty {
    CSSProperty("transform", value)
}

/// transformOrigin function.
public func transformOrigin(_ value: String) -> CSSProperty {
    CSSProperty("transform-origin", value)
}

/// transition function.
public func transition(_ value: String) -> CSSProperty {
    CSSProperty("transition", value)
}

/// transition function.
public func transition(_ value: Transition) -> CSSProperty {
    CSSProperty("transition", value.css)
}

/// transitionProperty function.
public func transitionProperty(_ value: String) -> CSSProperty {
    CSSProperty("transition-property", value)
}

/// transitionDuration function.
public func transitionDuration(_ value: String) -> CSSProperty {
    CSSProperty("transition-duration", value)
}

/// transitionDuration function.
public func transitionDuration(_ value: CSSLength) -> CSSProperty {
    CSSProperty("transition-duration", value.css)
}

/// transitionTimingFunction function.
public func transitionTimingFunction(_ value: String) -> CSSProperty {
    CSSProperty("transition-timing-function", value)
}

/// transitionTimingFunction function.
public func transitionTimingFunction(_ value: TimingFunction) -> CSSProperty {
    CSSProperty("transition-timing-function", value.css)
}

/// transitionDelay function.
public func transitionDelay(_ value: String) -> CSSProperty {
    CSSProperty("transition-delay", value)
}

/// transitionDelay function.
public func transitionDelay(_ value: CSSLength) -> CSSProperty {
    CSSProperty("transition-delay", value.css)
}

// MARK: - Animations

public func animation(_ value: String) -> CSSProperty {
    CSSProperty("animation", value)
}

/// animationName function.
public func animationName(_ value: String) -> CSSProperty {
    CSSProperty("animation-name", value)
}

/// animationDuration function.
public func animationDuration(_ value: String) -> CSSProperty {
    CSSProperty("animation-duration", value)
}

/// animationTimingFunction function.
public func animationTimingFunction(_ value: String) -> CSSProperty {
    CSSProperty("animation-timing-function", value)
}

/// animationDelay function.
public func animationDelay(_ value: String) -> CSSProperty {
    CSSProperty("animation-delay", value)
}

/// animationIterationCount function.
public func animationIterationCount(_ value: String) -> CSSProperty {
    CSSProperty("animation-iteration-count", value)
}

/// animationDirection function.
public func animationDirection(_ value: String) -> CSSProperty {
    CSSProperty("animation-direction", value)
}

/// animationFillMode function.
public func animationFillMode(_ value: String) -> CSSProperty {
    CSSProperty("animation-fill-mode", value)
}

// MARK: - Other Common Properties
public func objectFit(_ value: String) -> CSSProperty {
    CSSProperty("object-fit", value)
}

/// objectFit function.
public func objectFit(_ value: ObjectFit) -> CSSProperty {
    CSSProperty("object-fit", value.rawValue)
}

/// userDrag function.
public func userDrag(_ value: UserDrag) -> CSSProperty {
    CSSProperty("user-drag", value.rawValue)
}

/// webkitUserDrag function.
public func webkitUserDrag(_ value: UserDrag) -> CSSProperty {
    CSSProperty("-webkit-user-drag", value.rawValue)
}

/// objectPosition function.
public func objectPosition(_ value: String) -> CSSProperty {
    CSSProperty("object-position", value)
}

/// backdropFilter function.
public func backdropFilter(_ value: String) -> CSSProperty {
    CSSProperty("backdrop-filter", value)
}

/// filter function.
public func filter(_ value: String) -> CSSProperty {
    CSSProperty("filter", value)
}

/// clipPath function.
public func clipPath(_ value: String) -> CSSProperty {
    CSSProperty("clip-path", value)
}

/// userSelect function.
public func userSelect(_ value: String) -> CSSProperty {
    CSSProperty("user-select", value)
}

/// userSelect function.
public func userSelect(_ value: UserSelcet) -> CSSProperty {
    CSSProperty("user-select", value.rawValue)
}

/// pointerEvents function.
public func pointerEvents(_ value: String) -> CSSProperty {
    CSSProperty("pointer-events", value)
}

/// resize function.
public func resize(_ value: String) -> CSSProperty {
    CSSProperty("resize", value)
}

/// content function.
public func content(_ value: String) -> CSSProperty {
    CSSProperty("content", value)
}

// MARK: - Scrollbar Styling

public func scrollbarWidth(_ value: String) -> CSSProperty {
    CSSProperty("scrollbar-width", value)
}

/// scrollbarWidth function.
public func scrollbarWidth(_ value: ScrollbarWidth) -> CSSProperty {
    CSSProperty("scrollbar-width", value.rawValue)
}

/// scrollbarWidth function.
public func scrollbarWidth(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scrollbar-width", value.cssLength)
}

/// scrollbarColor function.
public func scrollbarColor(_ thumbColor: Color, _ trackColor: Color) -> CSSProperty {
    CSSProperty("scrollbar-color", "\(thumbColor.css) \(trackColor.css)")
}

/// scrollbarColor function.
public func scrollbarColor(_ color: Color) -> CSSProperty {
    CSSProperty("scrollbar-color", color.css)
}

/// scrollbarColor function.
public func scrollbarColor(_ thumbColor: String, _ trackColor: String) -> CSSProperty {
    CSSProperty("scrollbar-color", "\(thumbColor) \(trackColor)")
}

/// scrollbarColor function.
public func scrollbarColor(_ value: String) -> CSSProperty {
    CSSProperty("scrollbar-color", value)
}

// Webkit scrollbar color properties
public func scrollbarTrackColor(_ value: Color) -> CSSProperty {
    CSSProperty("scrollbar-track-color", value.css)
}

/// scrollbarThumbColor function.
public func scrollbarThumbColor(_ value: Color) -> CSSProperty {
    CSSProperty("scrollbar-thumb-color", value.css)
}

/// scrollbarArrowColor function.
public func scrollbarArrowColor(_ value: Color) -> CSSProperty {
    CSSProperty("scrollbar-arrow-color", value.css)
}

/// scrollbarFaceColor function.
public func scrollbarFaceColor(_ value: Color) -> CSSProperty {
    CSSProperty("scrollbar-face-color", value.css)
}

/// scrollbarShadowColor function.
public func scrollbarShadowColor(_ value: Color) -> CSSProperty {
    CSSProperty("scrollbar-shadow-color", value.css)
}

/// scrollbarHighlightColor function.
public func scrollbarHighlightColor(_ value: Color) -> CSSProperty {
    CSSProperty("scrollbar-highlight-color", value.css)
}

/// scrollbarDarkshadowColor function.
public func scrollbarDarkshadowColor(_ value: Color) -> CSSProperty {
    CSSProperty("scrollbar-darkshadow-color", value.css)
}

/// scrollbar3dlightColor function.
public func scrollbar3dlightColor(_ value: Color) -> CSSProperty {
    CSSProperty("scrollbar-3dlight-color", value.css)
}

// MARK: - Blend Modes & Compositing

public func mixBlendMode(_ value: String) -> CSSProperty {
    CSSProperty("mix-blend-mode", value)
}

/// backgroundBlendMode function.
public func backgroundBlendMode(_ value: String) -> CSSProperty {
    CSSProperty("background-blend-mode", value)
}

/// isolation function.
public func isolation(_ value: String) -> CSSProperty {
    CSSProperty("isolation", value)
}

// MARK: - Clipping & Masking

public func mask(_ value: String) -> CSSProperty {
    CSSProperty("mask", value)
}

/// maskImage function.
public func maskImage(_ value: String) -> CSSProperty {
    CSSProperty("mask-image", value)
}

/// maskSize function.
public func maskSize(_ value: String) -> CSSProperty {
    CSSProperty("mask-size", value)
}

/// maskPosition function.
public func maskPosition(_ value: String) -> CSSProperty {
    CSSProperty("mask-position", value)
}

/// maskRepeat function.
public func maskRepeat(_ value: String) -> CSSProperty {
    CSSProperty("mask-repeat", value)
}

// MARK: - Appearance & Interaction

public func appearance(_ value: String) -> CSSProperty {
    CSSProperty("appearance", value)
}

/// caretColor function.
public func caretColor(_ value: Color) -> CSSProperty {
    CSSProperty("caret-color", value.css)
}

/// caretColor function.
public func caretColor(_ value: String) -> CSSProperty {
    CSSProperty("caret-color", value)
}

/// accentColor function.
public func accentColor(_ value: Color) -> CSSProperty {
    CSSProperty("accent-color", value.css)
}

/// accentColor function.
public func accentColor(_ value: String) -> CSSProperty {
    CSSProperty("accent-color", value)
}

/// willChange function.
public func willChange(_ value: String) -> CSSProperty {
    CSSProperty("will-change", value)
}

/// touchAction function.
public func touchAction(_ value: String) -> CSSProperty {
    CSSProperty("touch-action", value)
}
