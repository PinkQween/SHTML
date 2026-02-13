//
//  CSSLength.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

// CSS Value - represents any CSS value including lengths, calc, and variables
public enum CSSValue: Sendable, Hashable {
    case length(Double, CSSUnit)
    case calc(String)
    case variable(String)
    case raw(String)
    
    public var css: String {
        switch self {
        case .length(let value, let unit):
            if value.rounded() == value {
                return "\(Int(value))\(unit.rawValue)"
            }
            return "\(value)\(unit.rawValue)"
        case .calc(let expr):
            return "calc(\(expr))"
        case .variable(let name):
            return "var(\(name))"
        case .raw(let value):
            return value
        }
    }
    
    // Arithmetic operators for calc()
    public static func + (lhs: CSSValue, rhs: CSSValue) -> CSSValue {
        .calc("\(lhs.css) + \(rhs.css)")
    }
    
    public static func - (lhs: CSSValue, rhs: CSSValue) -> CSSValue {
        .calc("\(lhs.css) - \(rhs.css)")
    }
    
    public static func * (lhs: CSSValue, rhs: Double) -> CSSValue {
        .calc("\(lhs.css) * \(rhs)")
    }
    
    public static func / (lhs: CSSValue, rhs: Double) -> CSSValue {
        .calc("\(lhs.css) / \(rhs)")
    }
}

public struct CSSLength: Sendable, Hashable, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    internal let value: CSSValue
    
    public init(_ val: Double, _ unit: CSSUnit = .px) {
        self.value = .length(val, unit)
    }
    
    private init(_ value: CSSValue) {
        self.value = value
    }
    
    public init(integerLiteral val: Int) {
        self.value = .length(Double(val), .px)
    }
    
    public init(floatLiteral val: Double) {
        self.value = .length(val, .px)
    }
    
    // CSS variable
    public static func variable(_ name: String) -> CSSLength {
        CSSLength(.variable(name))
    }
    
    // Raw CSS value
    public static func raw(_ value: String) -> CSSLength {
        CSSLength(.raw(value))
    }

    public var css: String {
        value.css
    }
    
    // Arithmetic operators that create calc() expressions
    public static func + (lhs: CSSLength, rhs: CSSLength) -> CSSLength {
        CSSLength(lhs.value + rhs.value)
    }
    
    public static func - (lhs: CSSLength, rhs: CSSLength) -> CSSLength {
        CSSLength(lhs.value - rhs.value)
    }
    
    public static func * (lhs: CSSLength, rhs: Double) -> CSSLength {
        CSSLength(lhs.value * rhs)
    }
    
    public static func / (lhs: CSSLength, rhs: Double) -> CSSLength {
        CSSLength(lhs.value / rhs)
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
