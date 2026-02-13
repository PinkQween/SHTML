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

public func boxShadow(_ value: String) -> CSSProperty {
    CSSProperty("box-shadow", value)
}

public func cursor(_ value: Cursor) -> CSSProperty {
    CSSProperty("cursor", value.rawValue)
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

public func transition(_ value: Transition) -> CSSProperty {
    CSSProperty("transition", value.css)
}

public func transitionProperty(_ value: String) -> CSSProperty {
    CSSProperty("transition-property", value)
}

public func transitionDuration(_ value: String) -> CSSProperty {
    CSSProperty("transition-duration", value)
}

public func transitionDuration(_ value: CSSLength) -> CSSProperty {
    CSSProperty("transition-duration", value.css)
}

public func transitionTimingFunction(_ value: String) -> CSSProperty {
    CSSProperty("transition-timing-function", value)
}

public func transitionTimingFunction(_ value: TimingFunction) -> CSSProperty {
    CSSProperty("transition-timing-function", value.css)
}

public func transitionDelay(_ value: String) -> CSSProperty {
    CSSProperty("transition-delay", value)
}

public func transitionDelay(_ value: CSSLength) -> CSSProperty {
    CSSProperty("transition-delay", value.css)
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

// MARK: - Other Common Properties
public func objectFit(_ value: String) -> CSSProperty {
    CSSProperty("object-fit", value)
}

public func objectFit(_ value: ObjectFit) -> CSSProperty {
    CSSProperty("object-fit", value.rawValue)
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

public func userSelect(_ value: UserSelcet) -> CSSProperty {
    CSSProperty("user-select", value.rawValue)
}

public func pointerEvents(_ value: String) -> CSSProperty {
    CSSProperty("pointer-events", value)
}

public func resize(_ value: String) -> CSSProperty {
    CSSProperty("resize", value)
}

public func content(_ value: String) -> CSSProperty {
    CSSProperty("content", value)
}

// MARK: - Scrollbar Styling

public func scrollbarWidth(_ value: String) -> CSSProperty {
    CSSProperty("scrollbar-width", value)
}

public func scrollbarWidth(_ value: ScrollbarWidth) -> CSSProperty {
    CSSProperty("scrollbar-width", value.rawValue)
}

public func scrollbarWidth(_ value: any CSSLengthConvertible) -> CSSProperty {
    CSSProperty("scrollbar-width", value.cssLength)
}

public func scrollbarColor(_ thumbColor: Color, _ trackColor: Color) -> CSSProperty {
    CSSProperty("scrollbar-color", "\(thumbColor.css) \(trackColor.css)")
}

public func scrollbarColor(_ color: Color) -> CSSProperty {
    CSSProperty("scrollbar-color", color.css)
}

public func scrollbarColor(_ thumbColor: String, _ trackColor: String) -> CSSProperty {
    CSSProperty("scrollbar-color", "\(thumbColor) \(trackColor)")
}

public func scrollbarColor(_ value: String) -> CSSProperty {
    CSSProperty("scrollbar-color", value)
}

// Webkit scrollbar color properties
public func scrollbarTrackColor(_ value: Color) -> CSSProperty {
    CSSProperty("scrollbar-track-color", value.css)
}

public func scrollbarThumbColor(_ value: Color) -> CSSProperty {
    CSSProperty("scrollbar-thumb-color", value.css)
}

public func scrollbarArrowColor(_ value: Color) -> CSSProperty {
    CSSProperty("scrollbar-arrow-color", value.css)
}

public func scrollbarFaceColor(_ value: Color) -> CSSProperty {
    CSSProperty("scrollbar-face-color", value.css)
}

public func scrollbarShadowColor(_ value: Color) -> CSSProperty {
    CSSProperty("scrollbar-shadow-color", value.css)
}

public func scrollbarHighlightColor(_ value: Color) -> CSSProperty {
    CSSProperty("scrollbar-highlight-color", value.css)
}

public func scrollbarDarkshadowColor(_ value: Color) -> CSSProperty {
    CSSProperty("scrollbar-darkshadow-color", value.css)
}

public func scrollbar3dlightColor(_ value: Color) -> CSSProperty {
    CSSProperty("scrollbar-3dlight-color", value.css)
}

// MARK: - Blend Modes & Compositing

public func mixBlendMode(_ value: String) -> CSSProperty {
    CSSProperty("mix-blend-mode", value)
}

public func backgroundBlendMode(_ value: String) -> CSSProperty {
    CSSProperty("background-blend-mode", value)
}

public func isolation(_ value: String) -> CSSProperty {
    CSSProperty("isolation", value)
}

// MARK: - Clipping & Masking

public func mask(_ value: String) -> CSSProperty {
    CSSProperty("mask", value)
}

public func maskImage(_ value: String) -> CSSProperty {
    CSSProperty("mask-image", value)
}

public func maskSize(_ value: String) -> CSSProperty {
    CSSProperty("mask-size", value)
}

public func maskPosition(_ value: String) -> CSSProperty {
    CSSProperty("mask-position", value)
}

public func maskRepeat(_ value: String) -> CSSProperty {
    CSSProperty("mask-repeat", value)
}

// MARK: - Appearance & Interaction

public func appearance(_ value: String) -> CSSProperty {
    CSSProperty("appearance", value)
}

public func caretColor(_ value: Color) -> CSSProperty {
    CSSProperty("caret-color", value.css)
}

public func caretColor(_ value: String) -> CSSProperty {
    CSSProperty("caret-color", value)
}

public func accentColor(_ value: Color) -> CSSProperty {
    CSSProperty("accent-color", value.css)
}

public func accentColor(_ value: String) -> CSSProperty {
    CSSProperty("accent-color", value)
}

public func willChange(_ value: String) -> CSSProperty {
    CSSProperty("will-change", value)
}

public func touchAction(_ value: String) -> CSSProperty {
    CSSProperty("touch-action", value)
}
