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

// Type-safe transition
public struct Transition {
    public let property: String
    public let duration: CSSLength
    public let timingFunction: TimingFunction
    public let delay: CSSLength?
    
    public init(property: String = "all", duration: CSSLength, timingFunction: TimingFunction = .easeInOut, delay: CSSLength? = nil) {
        self.property = property
        self.duration = duration
        self.timingFunction = timingFunction
        self.delay = delay
    }
    
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

public enum UserSelcet: String {
    case auto
    case none
    case text
    case all
}

public enum ObjectFit: String {
    case contain
    case cover
    case fill
    case `none`
    case scaleDown = "scale-down"
}
