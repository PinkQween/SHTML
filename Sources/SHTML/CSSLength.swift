//
//  CSSLength.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public struct CSSLength: Sendable, Hashable, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    public let value: Double
    public let unit: CSSUnit

    public init(_ value: Double, _ unit: CSSUnit = .px) {
        self.value = value
        self.unit = unit
    }
    
    public init(integerLiteral value: Int) {
        self.value = Double(value)
        self.unit = .px
    }
    
    public init(floatLiteral value: Double) {
        self.value = value
        self.unit = .px
    }

    public var css: String {
        if value.rounded() == value {
            return "\(Int(value))\(unit.rawValue)"
        }
        return "\(value)\(unit.rawValue)"
    }
}

// String conversion for easy use in attributes
extension CSSLength: CustomStringConvertible {
    public var description: String { css }
}

// Allow strings to be converted to CSSLength for backward compatibility
public protocol CSSLengthConvertible {
    var cssLength: String { get }
}

extension CSSLength: CSSLengthConvertible {
    public var cssLength: String { css }
}

extension String: CSSLengthConvertible {
    public var cssLength: String { self }
}

extension Int: CSSLengthConvertible {
    public var cssLength: String { "\(self)px" }
}

extension Double: CSSLengthConvertible {
    public var cssLength: String { "\(self)px" }
}
