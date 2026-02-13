//
//  Rect.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/13/26.
//

/// A rectangle shape for SVG graphics.
/// Defaults to 100% width and height.
///
/// ## Example
///
/// ```swift
/// Rect()
///     .fill("#007AFF")
///     .cornerRadius(10.px)
/// 
/// Rect(width: 200.px, height: 100.px)
///     .fill("red")
/// ```
public struct Rect: Shape, HTML {
    public typealias Content = Never
    public let shape: ShapeType = .rectangle
    private var attributes: [String: String] = [:]

    public init() {
        self.attributes["width"] = "100%"
        self.attributes["height"] = "100%"
    }
    
    public init(width: (any CSSLengthConvertible)? = nil, height: (any CSSLengthConvertible)? = nil) {
        self.attributes["width"] = width?.cssLength ?? "100%"
        self.attributes["height"] = height?.cssLength ?? "100%"
    }

    public func render() -> String {
        let attrs = attributes.map { " \($0.key)=\"\($0.value)\"" }.joined()
        return "<rect\(attrs) />"
    }

    public func path(in rect: HTMLRect) -> HTMLPath {
        var p = HTMLPath()
        p.move(to: (rect.x, rect.y))
        p.addLine(to: (rect.x + rect.width, rect.y))
        p.addLine(to: (rect.x + rect.width, rect.y + rect.height))
        p.addLine(to: (rect.x, rect.y + rect.height))
        p.closeSubpath()
        return p
    }
    
    // Shape-specific modifiers
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
    
    public func frame(width: (any CSSLengthConvertible)? = nil, height: (any CSSLengthConvertible)? = nil) -> Self {
        var copy = self
        if let width = width {
            copy.attributes["width"] = width.cssLength
        }
        if let height = height {
            copy.attributes["height"] = height.cssLength
        }
        return copy
    }
    
    public func cornerRadius(_ radius: any CSSLengthConvertible) -> Self {
        var copy = self
        let r = radius.cssLength
        copy.attributes["rx"] = r
        copy.attributes["ry"] = r
        return copy
    }
}

