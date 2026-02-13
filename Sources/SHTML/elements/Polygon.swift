//
//  Polygon.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/13/26.
//

public struct Polygon: Shape, HTML {
    public typealias Body = Never
    public let shape: ShapeType = .polygon

    /// The points that make up the polygon in local coordinates.
    public var points: [(x: Double, y: Double)]

    public init(points: [(Double, Double)]) {
        self.points = points.map { (x: $0.0, y: $0.1) }
    }

    /// Convenience initializer using separate arrays (must be same count)
    public init(xs: [Double], ys: [Double]) {
        precondition(xs.count == ys.count, "xs and ys must have the same count")
        self.points = Array(zip(xs, ys)).map { (x: $0.0, y: $0.1) }
    }

    // MARK: - HTML Rendering
    public func render() -> String {
        // Render as an SVG <polygon> element with space/comma-separated points
        let pts = points.map { "\($0.x),\($0.y)" }.joined(separator: " ")
        return "<polygon points=\"\(pts)\" />"
    }

    // MARK: - Shape Path
    public func path(in rect: HTMLRect) -> HTMLPath {
        var p = HTMLPath()
        guard let first = points.first else { return p }

        // Move to first point relative to rect origin
        p.move(to: (rect.x + first.x, rect.y + first.y))
        // Lines to subsequent points
        for pt in points.dropFirst() {
            p.addLine(to: (rect.x + pt.x, rect.y + pt.y))
        }
        p.closeSubpath()
        return p
    }
}
