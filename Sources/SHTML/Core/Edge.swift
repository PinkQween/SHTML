//
//  Edge.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public enum Edge: Int8, CaseIterable, Sendable {
    case top = 0
    case leading = 1
    case bottom = 2
    case trailing = 3

    public struct Set: OptionSet, Hashable, Sendable, ExpressibleByArrayLiteral {
        public typealias RawValue = UInt8
        public typealias ArrayLiteralElement = Edge

        public let rawValue: RawValue

        @inlinable
        public init(rawValue: RawValue) {
            self.rawValue = rawValue
        }

        @inlinable
        public init(_ edge: Edge) {
            self.rawValue = 1 &<< RawValue(edge.rawValue)
        }

        @inlinable
        public init(arrayLiteral elements: Edge...) {
            var v: RawValue = 0
            for e in elements {
                v |= 1 &<< RawValue(e.rawValue)
            }
            self.rawValue = v
        }

        public static let top      = Set(.top)
        public static let leading  = Set(.leading)
        public static let bottom   = Set(.bottom)
        public static let trailing = Set(.trailing)

        public static let all: Set        = [.top, .leading, .bottom, .trailing]
        public static let horizontal: Set = [.leading, .trailing]
        public static let vertical: Set   = [.top, .bottom]
    }
}
