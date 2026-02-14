//
//  Path.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/13/26.
//

/// A path shape for custom vector graphics.
///
/// ## Example
///
/// ```swift
/// SVG(width: "200", height: "200") {
///     Path(d: "M 10 10 L 90 90 L 10 90 Z")
///         .fill("#FF3B30")
///         .stroke("black")
///         .strokeWidth("2")
/// }
/// ```
public struct Path: Shape, HTML {
    /// Type alias.
    public typealias Content = Never
    /// Constant.
    public let shape: ShapeType = .path
    private let d: String
    private var attributes: [String: String] = [:]
    
    /// Creates a path with SVG path data.
    ///
    /// - Parameter d: The SVG path data string (e.g., "M 10 10 L 90 90 Z")
    public init(d: String) {
        self.d = d
    }
    
    /// render function.
    public func render() -> String {
        let attrs = attributes.map { " \($0.key)=\"\($0.value)\"" }.joined()
        return "<path d=\"\(d)\"\(attrs) />"
    }
    
    /// path function.
    public func path(in rect: HTMLRect) -> HTMLPath {
        // For custom paths, we can't easily convert back to HTMLPath
        // This is mainly for rendering purposes
        return HTMLPath()
    }
    
    // Shape modifiers
    public func fill(_ color: String) -> Self {
        var copy = self
        copy.attributes["fill"] = color
        return copy
    }
    
    /// stroke function.
    public func stroke(_ color: String) -> Self {
        var copy = self
        copy.attributes["stroke"] = color
        return copy
    }
    
    /// strokeWidth function.
    public func strokeWidth(_ width: any CSSLengthConvertible) -> Self {
        var copy = self
        copy.attributes["stroke-width"] = width.cssLength
        return copy
    }
    
    /// strokeLinecap function.
    public func strokeLinecap(_ value: String) -> Self {
        var copy = self
        copy.attributes["stroke-linecap"] = value
        return copy
    }
    
    /// strokeLinejoin function.
    public func strokeLinejoin(_ value: String) -> Self {
        var copy = self
        copy.attributes["stroke-linejoin"] = value
        return copy
    }
    
    /// fillRule function.
    public func fillRule(_ value: String) -> Self {
        var copy = self
        copy.attributes["fill-rule"] = value
        return copy
    }
}
