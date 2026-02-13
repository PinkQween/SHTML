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
    public typealias Body = Never
    public let shape: ShapeType = .path
    private let d: String
    private var attributes: [String: String] = [:]
    
    /// Creates a path with SVG path data.
    ///
    /// - Parameter d: The SVG path data string (e.g., "M 10 10 L 90 90 Z")
    public init(d: String) {
        self.d = d
    }
    
    public func render() -> String {
        let attrs = attributes.map { " \($0.key)=\"\($0.value)\"" }.joined()
        return "<path d=\"\(d)\"\(attrs) />"
    }
    
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
    
    public func stroke(_ color: String) -> Self {
        var copy = self
        copy.attributes["stroke"] = color
        return copy
    }
    
    public func strokeWidth(_ width: String) -> Self {
        var copy = self
        copy.attributes["stroke-width"] = width
        return copy
    }
    
    public func strokeLinecap(_ value: String) -> Self {
        var copy = self
        copy.attributes["stroke-linecap"] = value
        return copy
    }
    
    public func strokeLinejoin(_ value: String) -> Self {
        var copy = self
        copy.attributes["stroke-linejoin"] = value
        return copy
    }
    
    public func fillRule(_ value: String) -> Self {
        var copy = self
        copy.attributes["fill-rule"] = value
        return copy
    }
}
