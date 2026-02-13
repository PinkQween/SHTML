//
//  Rect.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/13/26.
//

public struct Rect: HTMLShape {
    public let shape: ShapeType = .rectangle

    public init() {}

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
