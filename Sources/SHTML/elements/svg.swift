//
//  svg.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/13/26.
//

/// An SVG container element for rendering vector graphics.
///
/// Use SVG to create scalable vector graphics with shapes like rectangles, circles, polygons, and paths.
///
/// ## Example
///
/// ```swift
/// SVG(width: "200", height: "200") {
///     Rect()
///         .fill("#007AFF")
///         .frame(width: "100", height: "100")
///         .cornerRadius("10")
///     
///     Polygon(points: [(50, 0), (100, 50), (50, 100), (0, 50)])
///         .fill("#FF3B30")
///         .stroke("white")
///         .strokeWidth("2")
/// }
/// ```
public struct SVG: HTMLPrimitive, HTMLModifiable {
    public typealias Body = Never
    
    public var attributes: [String: String]
    private let content: () -> [any HTML]
    
    /// Creates an SVG container with optional width and height.
    ///
    /// - Parameters:
    ///   - width: The width of the SVG canvas (e.g., "200", "100%")
    ///   - height: The height of the SVG canvas (e.g., "200", "100%")
    ///   - viewBox: Optional viewBox attribute for scaling (e.g., "0 0 100 100")
    ///   - content: The shapes and graphics to render inside the SVG
    public init(width: String? = nil, height: String? = nil, viewBox: String? = nil, @HTMLBuilder _ content: @escaping () -> [any HTML] = { [] }) {
        var attrs: [String: String] = [:]
        attrs["xmlns"] = "http://www.w3.org/2000/svg"
        if let width = width { attrs["width"] = width }
        if let height = height { attrs["height"] = height }
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
