//
//  svg.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/13/26.
//

/// An SVG container element for rendering vector graphics.
///
/// Use SVG to create scalable vector graphics with shapes like rectangles, circles, polygons, and paths.
/// Defaults to 100% width and 100% height.
///
/// ## Example
///
/// ```swift
/// SVG {
///     Rect()
///         .fill("#007AFF")
/// }
/// 
/// SVG(width: 200.px, height: 200.px) {
///     Circle()
///         .fill("red")
/// }
/// ```
public struct SVG: HTMLPrimitive, HTMLModifiable {
    public typealias Body = Never
    
    public var attributes: [String: String]
    private let content: () -> [any HTML]
    
    /// Creates an SVG container with optional width and height.
    /// Defaults to 100% width and 100% height.
    ///
    /// - Parameters:
    ///   - width: The width of the SVG canvas (default: 100%)
    ///   - height: The height of the SVG canvas (default: 100%). Use `"auto"` with aspectRatio modifier.
    ///   - viewBox: Optional viewBox attribute for scaling (e.g., "0 0 100 100")
    ///   - content: The shapes and graphics to render inside the SVG
    public init(width: (any CSSLengthConvertible)? = nil, height: (any CSSLengthConvertible)? = nil, viewBox: String? = nil, @HTMLBuilder _ content: @escaping () -> [any HTML] = { [] }) {
        var attrs: [String: String] = [:]
        attrs["xmlns"] = "http://www.w3.org/2000/svg"
        
        // Set width
        attrs["width"] = width?.cssLength ?? "100%"
        
        // Only set height if explicitly provided, otherwise use auto for aspect-ratio compatibility
        if let height = height {
            attrs["height"] = height.cssLength
        } else {
            attrs["height"] = "100%"
        }
        
        if let viewBox = viewBox { attrs["viewBox"] = viewBox }
        self.attributes = attrs
        self.content = content
    }
    
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        let children = content().map { $0.render() }.joined()
        return "<svg\(attrs)>\(children)</svg>"
    }
    
    public func viewBox(_ value: String) -> Self {
        var copy = self
        copy.attributes["viewBox"] = value
        return copy
    }
    
    public func preserveAspectRatio(_ value: String) -> Self {
        var copy = self
        copy.attributes["preserveAspectRatio"] = value
        return copy
    }
}

public typealias svg = SVG
