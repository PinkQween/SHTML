//
//  Circle.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/13/26.
//

/// A circular shape for use in SVG graphics.
/// Defaults to filling its container.
///
/// ## Example
///
/// ```swift
/// Circle()
///     .fill("#007AFF")
///     .r(50.px)
/// ```
public struct Circle: Shape, HTML {
    public typealias Body = Never
    public let shape: ShapeType = .circle
    private var attributes: [String: String] = [:]
    
    public init() {
        // Default to centered circle filling 50% of container
        self.attributes["cx"] = "50%"
        self.attributes["cy"] = "50%"
        self.attributes["r"] = "50%"
    }
    
    public func render() -> String {
        let attrs = attributes.map { " \($0.key)=\"\($0.value)\"" }.joined()
        return "<circle\(attrs) />"
    }
    
    public func path(in rect: HTMLRect) -> HTMLPath {
        var p = HTMLPath()
        let cx = rect.x + rect.width / 2
        let cy = rect.y + rect.height / 2
        let r = min(rect.width, rect.height) / 2
        
        // Approximate circle with arcs
        p.move(to: (cx + r, cy))
        p.addArc(rx: r, ry: r, xAxisRotation: 0, largeArc: false, sweep: true, to: (cx, cy + r))
        p.addArc(rx: r, ry: r, xAxisRotation: 0, largeArc: false, sweep: true, to: (cx - r, cy))
        p.addArc(rx: r, ry: r, xAxisRotation: 0, largeArc: false, sweep: true, to: (cx, cy - r))
        p.addArc(rx: r, ry: r, xAxisRotation: 0, largeArc: false, sweep: true, to: (cx + r, cy))
        p.closeSubpath()
        return p
    }
    
    // SVG-specific attributes
    public func cx(_ value: any CSSLengthConvertible) -> Self {
        var copy = self
        copy.attributes["cx"] = value.cssLength
        return copy
    }
    
    public func cy(_ value: any CSSLengthConvertible) -> Self {
        var copy = self
        copy.attributes["cy"] = value.cssLength
        return copy
    }
    
    public func r(_ value: any CSSLengthConvertible) -> Self {
        var copy = self
        copy.attributes["r"] = value.cssLength
        return copy
    }
    
    // Shape modifiers
    public func fill(_ color: String) -> Self {
        var copy = self
        copy.attributes["fill"] = color
        return copy
    }
    
    public func stroke(_ color: String) -> Self {
        var copy = self
        copy.attributes["stroke"] = color
        return copy
    }
    
    public func strokeWidth(_ width: any CSSLengthConvertible) -> Self {
        var copy = self
        copy.attributes["stroke-width"] = width.cssLength
        return copy
    }
}
