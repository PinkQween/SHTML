/// Corner identifiers for per-corner styling APIs.
public enum Corner: Int8, CaseIterable, Sendable {
    case topLeft = 0
    case topRight = 1
    case bottomRight = 2
    case bottomLeft = 3

    /// Option set of corners.
    public struct Set: OptionSet, Hashable, Sendable, ExpressibleByArrayLiteral {
        /// Type alias.
        public typealias RawValue = UInt8
        /// Type alias.
        public typealias ArrayLiteralElement = Corner

        /// Constant.
        public let rawValue: RawValue

        @inlinable
        /// Creates a new instance.
        public init(rawValue: RawValue) {
            self.rawValue = rawValue
        }

        @inlinable
        /// Creates a new instance.
        public init(_ corner: Corner) {
            self.rawValue = 1 &<< RawValue(corner.rawValue)
        }

        @inlinable
        /// Creates a new instance.
        public init(arrayLiteral elements: Corner...) {
            var value: RawValue = 0
            for corner in elements {
                value |= 1 &<< RawValue(corner.rawValue)
            }
            self.rawValue = value
        }

        public static let topLeft = Set(.topLeft)
        public static let topRight = Set(.topRight)
        public static let bottomRight = Set(.bottomRight)
        public static let bottomLeft = Set(.bottomLeft)

        public static let all: Set = [.topLeft, .topRight, .bottomRight, .bottomLeft]
        public static let top: Set = [.topLeft, .topRight]
        public static let bottom: Set = [.bottomLeft, .bottomRight]
        public static let leading: Set = [.topLeft, .bottomLeft]
        public static let trailing: Set = [.topRight, .bottomRight]
    }
}
