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

    /// Set type.
    public struct Set: OptionSet, Hashable, Sendable, ExpressibleByArrayLiteral {
        /// Type alias.
        public typealias RawValue = UInt8
        /// Type alias.
        public typealias ArrayLiteralElement = Edge

        /// Constant.
        public let rawValue: RawValue

        @inlinable
        /// Creates a new instance.
        public init(rawValue: RawValue) {
            self.rawValue = rawValue
        }

        @inlinable
        /// Creates a new instance.
        public init(_ edge: Edge) {
            self.rawValue = 1 &<< RawValue(edge.rawValue)
        }

        @inlinable
        /// Creates a new instance.
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
