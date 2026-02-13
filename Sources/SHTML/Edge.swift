//
//  Edge.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

enum Edge: Int8, CaseIterable {
    case top = 0
    case leading = 1
    case bottom = 2
    case trailing = 3

    struct Set: OptionSet, Hashable, Sendable, ExpressibleByArrayLiteral {
        typealias RawValue = Int8
        typealias ArrayLiteralElement = Edge

        let rawValue: Int8

        init(rawValue: Int8) {
            self.rawValue = rawValue
        }

        init(_ edge: Edge) {
            self.rawValue = 1 << edge.rawValue
        }

        init(arrayLiteral elements: Edge...) {
            var v: Int8 = 0
            for e in elements {
                v |= (1 << e.rawValue)
            }
            self.rawValue = v
        }

        static let top: Set      = Set(.top)
        static let leading: Set  = Set(.leading)
        static let bottom: Set   = Set(.bottom)
        static let trailing: Set = Set(.trailing)

        static let all: Set        = [.top, .leading, .bottom, .trailing]
        static let horizontal: Set = [.leading, .trailing]
        static let vertical: Set   = [.top, .bottom]
    }
}
