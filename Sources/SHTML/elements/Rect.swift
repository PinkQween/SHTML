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
        return "<rect width=\"\(w)\" height=\"\(h)\" />"
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
}

