//
//  Ellipse.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/13/26.
//

/// An elliptical shape for use in SVG graphics.
/// Can be a circle (equal width/height) or an ellipse (different width/height).
/// Defaults to 100% width and height.
///
/// ## Example
///
/// ```swift
/// // Default - fills container
/// Ellipse()
///     .fill(.blue)
/// 
/// // Circle with specific size
/// Ellipse(width: 100.px, height: 100.px)
///     .fill(.red)
/// 
/// // Ellipse
/// Ellipse(width: 200.px, height: 100.px)
///     .fill(.green)
/// ```
public struct Ellipse: Shape, HTML {
    public typealias Body = Never
    public let shape: ShapeType = .circle
    private var attributes: [String: String] = [:]
    
    public init() {
        // Default to 100% container size
        self.attributes["cx"] = "50%"
        self.attributes["cy"] = "50%"
        self.attributes["rx"] = "50%"
        self.attributes["ry"] = "50%"
    }
    
    public init(width: (any CSSLengthConvertible)? = nil, height: (any CSSLengthConvertible)? = nil) {
        self.attributes["cx"] = "50%"
        self.attributes["cy"] = "50%"
        
        if let width = width {
            self.attributes["rx"] = width.cssLength
        } else {
            self.attributes["rx"] = "50%"
        }
        
        if let height = height {
            self.attributes["ry"] = height.cssLength
        } else {
            self.attributes["ry"] = "50%"
        }
    }
    
    public func render() -> String {
        let attrs = attributes.map { " \($0.key)=\"\($0.value)\"" }.joined()
        return "<ellipse\(attrs) />"
    }
    
    public func path(in rect: HTMLRect) -> HTMLPath {
        var p = HTMLPath()
        let cx = rect.x + rect.width / 2
        let cy = rect.y + rect.height / 2
        let rx = rect.width / 2
        let ry = rect.height / 2
        
        // Approximate ellipse with arcs
        p.move(to: (cx + rx, cy))
        p.addArc(rx: rx, ry: ry, xAxisRotation: 0, largeArc: false, sweep: true, to: (cx, cy + ry))
        p.addArc(rx: rx, ry: ry, xAxisRotation: 0, largeArc: false, sweep: true, to: (cx - rx, cy))
        p.addArc(rx: rx, ry: ry, xAxisRotation: 0, largeArc: false, sweep: true, to: (cx, cy - ry))
        p.addArc(rx: rx, ry: ry, xAxisRotation: 0, largeArc: false, sweep: true, to: (cx + rx, cy))
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
    
    public func rx(_ value: any CSSLengthConvertible) -> Self {
        var copy = self
        copy.attributes["rx"] = value.cssLength
        return copy
    }
    
    public func ry(_ value: any CSSLengthConvertible) -> Self {
        var copy = self
        copy.attributes["ry"] = value.cssLength
        return copy
    }
    
    // Shape modifiers
    public func fill(_ color: String) -> Self {
        var copy = self
        copy.attributes["fill"] = color
        return copy
    }
    
    public func fill(_ color: Color) -> Self {
        var copy = self
        copy.attributes["fill"] = color.css
        return copy
    }
    
    public func stroke(_ color: String) -> Self {
        var copy = self
        copy.attributes["stroke"] = color
        return copy
    }
    
    public func stroke(_ color: Color) -> Self {
        var copy = self
        copy.attributes["stroke"] = color.css
        return copy
    }
    
    public func strokeWidth(_ width: any CSSLengthConvertible) -> Self {
        var copy = self
        copy.attributes["stroke-width"] = width.cssLength
        return copy
    }
    
    // Frame support - sets both rx and ry based on width/height
    public func frame(width: (any CSSLengthConvertible)? = nil, height: (any CSSLengthConvertible)? = nil) -> Self {
        var copy = self
        if let width = width {
            copy.attributes["rx"] = width.cssLength
        }
        if let height = height {
            copy.attributes["ry"] = height.cssLength
        }
        return copy
    }
}

// Convenience typealias for backwards compatibility
public typealias Circle = Ellipse
