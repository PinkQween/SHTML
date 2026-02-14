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

/// Type-safe text decoration values.
public enum TextDecoration: String {
    case none
    case underline
    case overline
    case lineThrough = "line-through"
}

/// Type-safe text transform values.
public enum TextTransform: String {
    case none
    case capitalize
    case uppercase
    case lowercase
}

/// Type-safe white-space values.
public enum WhiteSpace: String {
    case normal
    case nowrap
    case pre
    case preWrap = "pre-wrap"
    case preLine = "pre-line"
    case breakSpaces = "break-spaces"
}

/// Type-safe vertical-align values.
public enum VerticalAlign: String {
    case baseline
    case `sub`
    case `super`
    case top
    case textTop = "text-top"
    case middle
    case bottom
    case textBottom = "text-bottom"
}

/// Type-safe font-style values.
public enum FontStyle: String {
    case normal
    case italic
    case oblique
}

/// Type-safe generic font families.
public enum GenericFontFamily: String, Sendable, Hashable {
    case serif
    case sansSerif = "sans-serif"
    case monospace
    case cursive
    case fantasy
    case systemUI = "system-ui"
}

/// Type-safe font-family value.
public indirect enum FontFamily: Sendable, Hashable {
    case custom(String)
    case generic(GenericFontFamily)
    case stack([FontFamily])

    /// Property.
    public var css: String {
        switch self {
        case .custom(let name):
            return FontFamily.quoteIfNeeded(name)
        case .generic(let family):
            return family.rawValue
        case .stack(let families):
            return families.map(\.css).joined(separator: ", ")
        }
    }

    /// Creates a stack with a primary custom family and generic fallbacks.
    public static func named(_ name: String, fallbacks: GenericFontFamily...) -> FontFamily {
        let values: [FontFamily] = [.custom(name)] + fallbacks.map { .generic($0) }
        return .stack(values)
    }

    private static func quoteIfNeeded(_ value: String) -> String {
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.hasPrefix("'") || trimmed.hasPrefix("\"") {
            return trimmed
        }
        if trimmed.contains(" ") {
            return "'\(trimmed)'"
        }
        return trimmed
    }
}

/// Type-safe linear-gradient direction.
public enum LinearGradientDirection: Sendable {
    case toTop
    case toBottom
    case toLeft
    case toRight
    case toTopLeft
    case toTopRight
    case toBottomLeft
    case toBottomRight
    case angle(CSSAngle)

    /// Property.
    public var css: String {
        switch self {
        case .toTop: return "to top"
        case .toBottom: return "to bottom"
        case .toLeft: return "to left"
        case .toRight: return "to right"
        case .toTopLeft: return "to top left"
        case .toTopRight: return "to top right"
        case .toBottomLeft: return "to bottom left"
        case .toBottomRight: return "to bottom right"
        case .angle(let angle): return angle.css
        }
    }
}

/// Type-safe linear-gradient color stop.
public struct GradientStop: Sendable {
    /// Constant.
    public let color: Color
    /// Constant.
    public let position: CSSLength?

    /// Creates a new instance.
    public init(_ color: Color, at position: CSSLength? = nil) {
        self.color = color
        self.position = position
    }

    /// Property.
    public var css: String {
        if let position {
            return "\(color.css) \(position.css)"
        }
        return color.css
    }
}

/// Type-safe `linear-gradient(...)` value.
public struct LinearGradient: Sendable {
    /// Constant.
    public let direction: LinearGradientDirection?
    /// Constant.
    public let stops: [GradientStop]

    /// Creates a new instance.
    public init(direction: LinearGradientDirection? = nil, _ stops: GradientStop...) {
        self.direction = direction
        self.stops = stops
    }

    /// Creates a new instance.
    public init(direction: LinearGradientDirection? = nil, stops: [GradientStop]) {
        self.direction = direction
        self.stops = stops
    }

    /// Property.
    public var css: String {
        let stopList = stops.map(\.css).joined(separator: ", ")
        if let direction {
            return "linear-gradient(\(direction.css), \(stopList))"
        }
        return "linear-gradient(\(stopList))"
    }
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
