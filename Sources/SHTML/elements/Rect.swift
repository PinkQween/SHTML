//
//  Rect.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/13/26.
//

public struct Rect: Shape, HTML {
    public typealias Body = Never
    public let shape: ShapeType = .rectangle
    public var width: Int
    public var height: Int
    private var attributes: [String: String] = [:]

    public init() {
        self.width = -1
        self.height = -1
    }
    
    public init(width: Int = -1, height: Int = -1) {
        self.width = width
        self.height = height
    }

    public func render() -> String {
        let w = (width == -1) ? "100%" : "\(width)"
        let h = (height == -1) ? "100%" : "\(height)"
        let attrs = attributes.map { " \($0.key)=\"\($0.value)\"" }.joined()
        return "<rect width=\"\(w)\" height=\"\(h)\"\(attrs) />"
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
    
    public func frame(width: String, height: String) -> Self {
        var copy = self
        copy.attributes["width"] = width
        copy.attributes["height"] = height
        return copy
    }
    
    public func cornerRadius(_ radius: String) -> Self {
        var copy = self
        copy.attributes["rx"] = radius
        copy.attributes["ry"] = radius
        return copy
    }
}

