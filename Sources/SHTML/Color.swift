// Type-safe color representation
public enum Color: Sendable {
    case hex(String)
    case rgb(Int, Int, Int)
    case rgba(Int, Int, Int, Double)
    case hsl(Int, Int, Int)
    case hsla(Int, Int, Int, Double)
    case named(String)
    
    public var css: String {
        switch self {
        case .hex(let value):
            return value.hasPrefix("#") ? value : "#\(value)"
        case .rgb(let r, let g, let b):
            return "rgb(\(r), \(g), \(b))"
        case .rgba(let r, let g, let b, let a):
            return "rgba(\(r), \(g), \(b), \(a))"
        case .hsl(let h, let s, let l):
            return "hsl(\(h), \(s)%, \(l)%)"
        case .hsla(let h, let s, let l, let a):
            return "hsla(\(h), \(s)%, \(l)%, \(a))"
        case .named(let name):
            return name
        }
    }
    
    // Convenience static colors
    public static let black = Color.named("black")
    public static let white = Color.named("white")
    public static let red = Color.named("red")
    public static let green = Color.named("green")
    public static let blue = Color.named("blue")
    public static let yellow = Color.named("yellow")
    public static let orange = Color.named("orange")
    public static let purple = Color.named("purple")
    public static let pink = Color.named("pink")
    public static let cyan = Color.named("cyan")
    public static let gray = Color.named("gray")
    public static let transparent = Color.named("transparent")
}
