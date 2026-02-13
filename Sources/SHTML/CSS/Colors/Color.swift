// Type-safe color representation

/// Compile-time validated hex color
/// Example: `#hex("#ff0000")` or `#hex("abc")` or `#hex("0xaabbcc")`
@freestanding(expression)
public macro hex(_ color: String) -> Color = #externalMacro(module: "SHTMLMacros", type: "HexColorMacro")

import Foundation

public enum Color: Sendable {
    case hex(String)
    case rgb(Int, Int, Int)
    case rgba(Int, Int, Int, Double)
    case hsl(Int, Int, Int)
    case hsla(Int, Int, Int, Double)
    case named(String)
    case variable(String)  // CSS custom property
    
    public var css: String {
        switch self {
        case .hex(let value):
            return Color.normalizeHex(value)
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
        case .variable(let name):
            return "var(\(name))"
        }
    }
    
    // Validates and normalizes hex color values
    // Accepts: "abc", "#abc", "0xabc", "aabbcc", "#aabbcc", "0xaabbcc", "aabbccdd", "#aabbccdd", "0xaabbccdd"
    static func normalizeHex(_ value: String) -> String {
        var hex = value
        
        // Remove # or 0x prefix
        if hex.hasPrefix("#") {
            hex = String(hex.dropFirst())
        } else if hex.lowercased().hasPrefix("0x") {
            hex = String(hex.dropFirst(2))
        }
        
        // Validate hex characters and length
        let validChars = CharacterSet(charactersIn: "0123456789abcdefABCDEF")
        guard hex.unicodeScalars.allSatisfy({ validChars.contains($0) }) else {
            fatalError("Invalid hex color: '\(value)'. Must contain only 0-9, a-f, A-F")
        }
        
        guard [3, 6, 8].contains(hex.count) else {
            fatalError("Invalid hex color length: '\(value)'. Must be 3, 6, or 8 hex digits (with optional # or 0x prefix)")
        }
        
        return "#\(hex)"
    }
}
