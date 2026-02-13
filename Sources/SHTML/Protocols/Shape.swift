//
//  Shape.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/13/26.
//

import Foundation

/// A rectangle in local coordinates, used to compute paths.
public struct HTMLRect: Equatable {
    public var x: Double
    public var y: Double
    public var width: Double
    public var height: Double

    public init(x: Double, y: Double, width: Double, height: Double) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
}

/// A very lightweight path representation suitable for translating to SVG path data.
public struct HTMLPath: Equatable {
    public enum Command: Equatable {
        case moveTo(x: Double, y: Double)
        case lineTo(x: Double, y: Double)
        case arc(rx: Double, ry: Double, xAxisRotation: Double, largeArc: Bool, sweep: Bool, x: Double, y: Double)
        case closePath
    }

    public private(set) var commands: [Command] = []

    public init() {}

    public mutating func move(to point: (x: Double, y: Double)) {
        commands.append(.moveTo(x: point.x, y: point.y))
    }

    public mutating func addLine(to point: (x: Double, y: Double)) {
        commands.append(.lineTo(x: point.x, y: point.y))
    }

    public mutating func addArc(rx: Double, ry: Double, xAxisRotation: Double = 0, largeArc: Bool = false, sweep: Bool = true, to point: (x: Double, y: Double)) {
        commands.append(.arc(rx: rx, ry: ry, xAxisRotation: xAxisRotation, largeArc: largeArc, sweep: sweep, x: point.x, y: point.y))
    }

    public mutating func closeSubpath() {
        commands.append(.closePath)
    }
}

/// A type that describes the kind of shape. Useful for mapping to HTML/SVG elements.
public enum ShapeType: String {
    case rectangle
    case circle
    case ellipse
    case line
    case polygon
    case path
}

/// A SwiftUI-like Shape protocol that conforms to HTML rendering.
///
/// Conformers provide a vector path via `path(in:)`. Default HTML rendering is provided
/// by converting the path to an SVG `<path>` element, but shapes may override for specialized SVG.
public protocol Shape: HTML {
    /// The semantic kind of shape.
    var shape: ShapeType { get }

    /// Produce a vector path within the given rect, similar to SwiftUI's Shape API.
    func path(in rect: HTMLRect) -> HTMLPath
}

public extension Shape {
    /// Default HTML rendering using SVG path data.
    func renderHTML() -> String {
        // Convert path commands to minimal SVG path data string.
        let rect = HTMLRect(x: 0, y: 0, width: 100, height: 100)
        let p = path(in: rect)
        let d: String = p.commands.map { cmd in
            switch cmd {
            case let .moveTo(x, y):
                return "M \(x) \(y)"
            case let .lineTo(x, y):
                return "L \(x) \(y)"
            case let .arc(rx, ry, xAxisRotation, largeArc, sweep, x, y):
                let laf = largeArc ? 1 : 0
                let sf = sweep ? 1 : 0
                return "A \(rx) \(ry) \(xAxisRotation) \(laf) \(sf) \(x) \(y)"
            case .closePath:
                return "Z"
            }
        }.joined(separator: " ")
        return "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 \(rect.width) \(rect.height)\"><path d=\"\(d)\"/></svg>"
    }
}
