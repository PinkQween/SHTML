//
//  CSSLength.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public struct CSSLength: Sendable, Hashable {
    public let value: Double
    public let unit: CSSUnit

    public init(_ value: Double, _ unit: CSSUnit = .px) {
        self.value = value
        self.unit = unit
    }

    public var css: String {
        if value.rounded() == value {
            return "\(Int(value))\(unit.rawValue)"
        }
        return "\(value)\(unit.rawValue)"
    }
}
