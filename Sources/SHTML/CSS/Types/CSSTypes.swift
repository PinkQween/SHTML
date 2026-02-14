// Type-safe overflow values
public enum Overflow: String {
    case visible
    case hidden
    case scroll
    case auto
    case clip
}

// Type-safe display values
public enum Display: String {
    case block
    case inline
    case inlineBlock = "inline-block"
    case flex
    case inlineFlex = "inline-flex"
    case grid
    case inlineGrid = "inline-grid"
    case none
}

// Type-safe position values
public enum Position: String {
    case `static`
    case relative
    case absolute
    case fixed
    case sticky
}

// Type-safe text alignment
public enum TextAlign: String {
    case left
    case center
    case right
    case justify
}

// Type-safe flex direction
public enum FlexDirection: String {
    case row
    case column
    case rowReverse = "row-reverse"
    case columnReverse = "column-reverse"
}

// Type-safe justify content
public enum JustifyContent: String {
    case flexStart = "flex-start"
    case flexEnd = "flex-end"
    case center
    case spaceBetween = "space-between"
    case spaceAround = "space-around"
    case spaceEvenly = "space-evenly"
}

// Type-safe align items
public enum AlignItems: String {
    case flexStart = "flex-start"
    case flexEnd = "flex-end"
    case center
    case baseline
    case stretch
}

// Type-safe cursor values
public enum Cursor: String {
    case auto
    case `default`
    case pointer
    case wait
    case text
    case move
    case notAllowed = "not-allowed"
    case help
    case grab
    case grabbing
    case crosshair
    case zoomIn = "zoom-in"
    case zoomOut = "zoom-out"
}

// Type-safe timing functions
public enum TimingFunction {
    case linear
    case ease
    case easeIn
    case easeOut
    case easeInOut
    case custom(String)
    
    /// Property.
    public var css: String {
        switch self {
        case .linear: return "linear"
        case .ease: return "ease"
        case .easeIn: return "ease-in"
        case .easeOut: return "ease-out"
        case .easeInOut: return "ease-in-out"
        case .custom(let value): return value
        }
    }
}

/// Type-safe CSS angle value.
public struct CSSAngle: Sendable, Hashable, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    /// Constant.
    public let css: String

    /// Creates a new instance.
    public init(css: String) {
        self.css = css
    }

    /// Creates a new instance.
    public init(integerLiteral value: Int) {
        self.css = "\(value)deg"
    }

    /// Creates a new instance.
    public init(floatLiteral value: Double) {
        self.css = "\(value)deg"
    }

    /// Creates angle in degrees.
    public static func deg(_ value: Double) -> CSSAngle {
        CSSAngle(css: "\(formatNumber(value))deg")
    }

    /// Creates angle in radians.
    public static func rad(_ value: Double) -> CSSAngle {
        CSSAngle(css: "\(formatNumber(value))rad")
    }

    /// Creates angle in turns.
    public static func turn(_ value: Double) -> CSSAngle {
        CSSAngle(css: "\(formatNumber(value))turn")
    }

    private static func formatNumber(_ value: Double) -> String {
        if value.rounded() == value {
            return "\(Int(value))"
        }
        return "\(value)"
    }
}

/// Type-safe transform operations.
public enum TransformOperation: Sendable, Hashable {
    case translate(x: CSSLength, y: CSSLength)
    case translateX(CSSLength)
    case translateY(CSSLength)
    case scale(Double)
    case scaleXY(x: Double, y: Double)
    case scaleX(Double)
    case scaleY(Double)
    case rotate(CSSAngle)
    case skew(x: CSSAngle, y: CSSAngle)
    case skewX(CSSAngle)
    case skewY(CSSAngle)

    /// Property.
    public var css: String {
        switch self {
        case .translate(let x, let y):
            return "translate(\(x.css), \(y.css))"
        case .translateX(let x):
            return "translateX(\(x.css))"
        case .translateY(let y):
            return "translateY(\(y.css))"
        case .scale(let value):
            return "scale(\(value))"
        case .scaleXY(let x, let y):
            return "scale(\(x), \(y))"
        case .scaleX(let value):
            return "scaleX(\(value))"
        case .scaleY(let value):
            return "scaleY(\(value))"
        case .rotate(let angle):
            return "rotate(\(angle.css))"
        case .skew(let x, let y):
            return "skew(\(x.css), \(y.css))"
        case .skewX(let angle):
            return "skewX(\(angle.css))"
        case .skewY(let angle):
            return "skewY(\(angle.css))"
        }
    }
}

/// Type-safe transform value composed from one or more operations.
public struct Transform: Sendable, Hashable {
    /// Constant.
    public let operations: [TransformOperation]

    /// Creates a new instance.
    public init(_ operations: TransformOperation...) {
        self.operations = operations
    }

    /// Creates a new instance.
    public init(_ operations: [TransformOperation]) {
        self.operations = operations
    }

    /// Property.
    public var css: String {
        operations.map(\.css).joined(separator: " ")
    }
}

/// Type-safe transition properties.
public enum TransitionProperty: String {
    case all
    case opacity
    case transform
    case background = "background"
    case backgroundColor = "background-color"
    case color
    case width
    case height
    case left
    case right
    case top
    case bottom
}

// Type-safe transition
public struct Transition {
    /// Constant.
    public let property: String
    /// Constant.
    public let duration: CSSLength
    /// Constant.
    public let timingFunction: TimingFunction
    /// Constant.
    public let delay: CSSLength?
    
    /// Creates a new instance.
    public init(property: String = "all", duration: CSSLength, timingFunction: TimingFunction = .easeInOut, delay: CSSLength? = nil) {
        self.property = property
        self.duration = duration
        self.timingFunction = timingFunction
        self.delay = delay
    }

    /// Creates a new instance.
    public init(property: TransitionProperty, duration: CSSLength, timingFunction: TimingFunction = .easeInOut, delay: CSSLength? = nil) {
        self.init(property: property.rawValue, duration: duration, timingFunction: timingFunction, delay: delay)
    }
    
    /// Property.
    public var css: String {
        var result = "\(property) \(duration.css) \(timingFunction.css)"
        if let delay = delay {
            result += " \(delay.css)"
        }
        return result
    }
    
    // Convenience constructors
    public static func all(duration: CSSLength, timing: TimingFunction = .easeInOut, delay: CSSLength? = nil) -> Transition {
        Transition(property: "all", duration: duration, timingFunction: timing, delay: delay)
    }
    
    public static func opacity(duration: CSSLength, timing: TimingFunction = .easeInOut, delay: CSSLength? = nil) -> Transition {
        Transition(property: "opacity", duration: duration, timingFunction: timing, delay: delay)
    }
    
    public static func transform(duration: CSSLength, timing: TimingFunction = .easeInOut, delay: CSSLength? = nil) -> Transition {
        Transition(property: "transform", duration: duration, timingFunction: timing, delay: delay)
    }
    
    public static func background(duration: CSSLength, timing: TimingFunction = .easeInOut, delay: CSSLength? = nil) -> Transition {
        Transition(property: "background", duration: duration, timingFunction: timing, delay: delay)
    }
}

/// Visibility type.
public enum Visibility: String {
    case visible
    case hidden
    case collapse
}

// Type-safe scroll behavior
public enum ScrollBehavior: String {
    case auto
    case smooth
}

// Type-safe scrollbar width
public enum ScrollbarWidth: String {
    case auto
    case thin
    case none
}

// Type-safe scrollbar gutter
public enum ScrollbarGutter: String {
    case auto
    case stable
    case stableBothEdges = "stable both-edges"
}

// Type-safe box sizing
public enum BoxSizing: String {
    case contentBox = "content-box"
    case borderBox = "border-box"
}

/// UserSelcet type.
public enum UserSelcet: String {
    case auto
    case none
    case text
    case all
}

/// ObjectFit type.
public enum ObjectFit: String {
    case contain
    case cover
    case fill
    case `none`
    case scaleDown = "scale-down"
}

/// UserDrag type.
public enum UserDrag: String {
    case none
    case element
    case auto
}
