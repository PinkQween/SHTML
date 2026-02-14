//
//  ZStack.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/13/26.
//

/// A container that overlays its children on top of each other.
///
/// ZStack positions its children in the z-axis, with later children appearing on top
/// of earlier ones. This is similar to SwiftUI's ZStack and is useful for creating
/// layered interfaces like backgrounds with content on top.
///
/// ## Example
///
/// ```swift
/// ZStack {
///     Rect()
///         .fill("#007AFF")
///         .frame(width: "200px", height: "200px")
///     
///     VStack(spacing: "10px") {
///         h2 { "Overlay Content" }
///         p { "This appears on top" }
///     }
///     .padding("20px")
/// }
/// .cornerRadius("12px")
/// ```
public struct ZStack: HTML, HTMLModifiable {
    /// Property.
    public var attributes: [String: String]
    private let alignment: String
    /// Constant.
    public let content: () -> [any HTML]
    
    /// Creates a ZStack with the specified alignment and content.
    ///
    /// - Parameters:
    ///   - alignment: The alignment of children (default: "center"). Can be "center", "top", "bottom", "left", "right", "top-left", etc.
    ///   - content: A builder closure that produces the stack's content.
    public init(alignment: String = "center", @HTMLBuilder _ content: @escaping () -> [any HTML]) {
        var attrs: [String: String] = [:]
        
        // Container uses relative positioning
        var style = "position: relative; display: flex;"
        
        // Set alignment
        switch alignment {
        case "center":
            style += " justify-content: center; align-items: center;"
        case "top":
            style += " justify-content: center; align-items: flex-start;"
        case "bottom":
            style += " justify-content: center; align-items: flex-end;"
        case "left":
            style += " justify-content: flex-start; align-items: center;"
        case "right":
            style += " justify-content: flex-end; align-items: center;"
        case "top-left":
            style += " justify-content: flex-start; align-items: flex-start;"
        case "top-right":
            style += " justify-content: flex-end; align-items: flex-start;"
        case "bottom-left":
            style += " justify-content: flex-start; align-items: flex-end;"
        case "bottom-right":
            style += " justify-content: flex-end; align-items: flex-end;"
        default:
            style += " justify-content: center; align-items: center;"
        }
        
        attrs["style"] = style
        self.attributes = attrs
        self.alignment = alignment
        self.content = content
    }
    
    /// render function.
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        let children = content().enumerated().map { index, child in
            // Each child needs absolute positioning to stack on top of each other
            let childStyle = "position: absolute; z-index: \(index);"
            return "<div style=\"\(childStyle)\">\(child.render())</div>"
        }.joined()
        return "<div\(attrs)>\(children)</div>"
    }
    
    /// padding function.
    public func padding(_ value: String) -> Self {
        var copy = self
        var style = copy.attributes["style"] ?? ""
        style += " padding: \(value);"
        copy.attributes["style"] = style
        return copy
    }
    
    /// background function.
    public func background(_ value: String) -> Self {
        var copy = self
        var style = copy.attributes["style"] ?? ""
        style += " background: \(value);"
        copy.attributes["style"] = style
        return copy
    }
}
