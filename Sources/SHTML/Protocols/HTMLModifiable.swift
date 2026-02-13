// Universal modifiers that can be applied to any HTML element
// Similar to SwiftUI's ViewModifier

public protocol HTMLModifiable: HTML {
    var attributes: [String: String] { get set }
}

public protocol HTMLContentModifiable: HTMLModifiable {
    init(attributes: [String: String], content: @escaping () -> [any HTML])
}

public extension HTMLModifiable where Self: HTMLContentModifiable {
    func with(class className: String, @HTMLBuilder content: @escaping () -> [any HTML]) -> Self {
        var copy = self
        copy.attributes["class"] = className
        return Self(attributes: copy.attributes, content: content)
    }
    
    func with(id idValue: String, @HTMLBuilder content: @escaping () -> [any HTML]) -> Self {
        var copy = self
        copy.attributes["id"] = idValue
        return Self(attributes: copy.attributes, content: content)
    }
    
    func with(style styleValue: String, @HTMLBuilder content: @escaping () -> [any HTML]) -> Self {
        var copy = self
        copy.attributes["style"] = styleValue
        return Self(attributes: copy.attributes, content: content)
    }
}

public extension HTMLModifiable {
    func id(_ value: String) -> Self {
        var copy = self
        copy.attributes["id"] = value
        return copy
    }
    
    func `class`(_ value: String) -> Self {
        var copy = self
        copy.attributes["class"] = value
        return copy
    }
    
    func style(_ value: String) -> Self {
        var copy = self
        copy.attributes["style"] = value
        return copy
    }
    
    func title(_ value: String) -> Self {
        var copy = self
        copy.attributes["title"] = value
        return copy
    }
    
    func hidden(_ value: Bool = true) -> Self {
        var copy = self
        if value {
            copy.attributes["hidden"] = ""
        } else {
            copy.attributes.removeValue(forKey: "hidden")
        }
        return copy
    }
    
    func tabIndex(_ value: Int) -> Self {
        var copy = self
        copy.attributes["tabindex"] = "\(value)"
        return copy
    }
    
    func accessibilityLabel(_ value: String) -> Self {
        var copy = self
        copy.attributes["aria-label"] = value
        return copy
    }
    
    func role(_ value: String) -> Self {
        var copy = self
        copy.attributes["role"] = value
        return copy
    }
    
    func dataAttribute(_ name: String, _ value: String) -> Self {
        var copy = self
        copy.attributes["data-\(name)"] = value
        return copy
    }
}

// Event modifiers
public extension HTMLModifiable {
    func onclick(_ value: String) -> Self {
        var copy = self
        copy.attributes["onclick"] = value
        return copy
    }
    
    func onchange(_ value: String) -> Self {
        var copy = self
        copy.attributes["onchange"] = value
        return copy
    }
    
    func onsubmit(_ value: String) -> Self {
        var copy = self
        copy.attributes["onsubmit"] = value
        return copy
    }
    
    func onkeydown(_ value: String) -> Self {
        var copy = self
        copy.attributes["onkeydown"] = value
        return copy
    }
    
    func onkeyup(_ value: String) -> Self {
        var copy = self
        copy.attributes["onkeyup"] = value
        return copy
    }
    
    func onfocus(_ value: String) -> Self {
        var copy = self
        copy.attributes["onfocus"] = value
        return copy
    }
    
    func onblur(_ value: String) -> Self {
        var copy = self
        copy.attributes["onblur"] = value
        return copy
    }
    
    func onmouseover(_ value: String) -> Self {
        var copy = self
        copy.attributes["onmouseover"] = value
        return copy
    }
    
    func onmouseout(_ value: String) -> Self {
        var copy = self
        copy.attributes["onmouseout"] = value
        return copy
    }
}

// SwiftUI-style modifiers
public extension HTMLModifiable {
    // Helper to append styles
    private func appendingStyle(_ newStyle: String) -> Self {
        var copy = self
        var styles: [String] = []
        
        if let existing = copy.attributes["style"], !existing.isEmpty {
            styles.append(existing)
        }
        styles.append(newStyle)
        copy.attributes["style"] = styles.joined(separator: "; ")
        
        return copy
    }
    
    // Layout
    func padding(_ value: String) -> Self {
        appendingStyle("padding: \(value)")
    }
    
    func padding(top: String? = nil, right: String? = nil, bottom: String? = nil, left: String? = nil) -> Self {
        var result = self
        if let top = top { result = result.appendingStyle("padding-top: \(top)") }
        if let right = right { result = result.appendingStyle("padding-right: \(right)") }
        if let bottom = bottom { result = result.appendingStyle("padding-bottom: \(bottom)") }
        if let left = left { result = result.appendingStyle("padding-left: \(left)") }
        return result
    }
    
    func margin(_ value: String) -> Self {
        appendingStyle("margin: \(value)")
    }
    
    func margin(top: String? = nil, right: String? = nil, bottom: String? = nil, left: String? = nil) -> Self {
        var result = self
        if let top = top { result = result.appendingStyle("margin-top: \(top)") }
        if let right = right { result = result.appendingStyle("margin-right: \(right)") }
        if let bottom = bottom { result = result.appendingStyle("margin-bottom: \(bottom)") }
        if let left = left { result = result.appendingStyle("margin-left: \(left)") }
        return result
    }
    
    func frame(width: String? = nil, height: String? = nil, maxWidth: String? = nil, minHeight: String? = nil) -> Self {
        var result = self
        if let width = width { result = result.appendingStyle("width: \(width)") }
        if let height = height { result = result.appendingStyle("height: \(height)") }
        if let maxWidth = maxWidth { result = result.appendingStyle("max-width: \(maxWidth)") }
        if let minHeight = minHeight { result = result.appendingStyle("min-height: \(minHeight)") }
        return result
    }
    
    // Colors
    func background(_ color: String) -> Self {
        appendingStyle("background: \(color)")
    }
    
    func foregroundColor(_ color: String) -> Self {
        appendingStyle("color: \(color)")
    }
    
    // Typography
    func font(size: String? = nil, weight: String? = nil, family: String? = nil) -> Self {
        var result = self
        if let size = size { result = result.appendingStyle("font-size: \(size)") }
        if let weight = weight { result = result.appendingStyle("font-weight: \(weight)") }
        if let family = family { result = result.appendingStyle("font-family: \(family)") }
        return result
    }
    
    func fontSize(_ size: String) -> Self {
        appendingStyle("font-size: \(size)")
    }
    
    func fontWeight(_ weight: String) -> Self {
        appendingStyle("font-weight: \(weight)")
    }
    
    func textAlign(_ alignment: String) -> Self {
        appendingStyle("text-align: \(alignment)")
    }
    
    // Visual effects
    func opacity(_ value: Double) -> Self {
        appendingStyle("opacity: \(value)")
    }
    
    func cornerRadius(_ radius: String) -> Self {
        appendingStyle("border-radius: \(radius)")
    }
    
    func shadow(x: String = "0", y: String = "10px", blur: String = "30px", color: String = "rgba(0,0,0,0.2)") -> Self {
        appendingStyle("box-shadow: \(x) \(y) \(blur) \(color)")
    }
    
    func border(width: String = "1px", style: String = "solid", color: String = "black") -> Self {
        appendingStyle("border: \(width) \(style) \(color)")
    }
    
    func borderLeft(width: String, color: String) -> Self {
        appendingStyle("border-left: \(width) solid \(color)")
    }
    
    // Flexbox
    func flexDirection(_ direction: String) -> Self {
        appendingStyle("display: flex; flex-direction: \(direction)")
    }
    
    func gap(_ spacing: String) -> Self {
        appendingStyle("gap: \(spacing)")
    }
    
    func justifyContent(_ value: String) -> Self {
        appendingStyle("justify-content: \(value)")
    }
    
    func alignItems(_ value: String) -> Self {
        appendingStyle("align-items: \(value)")
    }
    
    // Display
    func display(_ value: String) -> Self {
        appendingStyle("display: \(value)")
    }
    
    func overflow(_ value: String) -> Self {
        appendingStyle("overflow: \(value)")
    }
    
    // Position
    func position(_ value: String) -> Self {
        appendingStyle("position: \(value)")
    }
    
    // Transform
    func transform(_ value: String) -> Self {
        appendingStyle("transform: \(value)")
    }
    
    // Transition
    func transition(_ value: String = "all 0.3s") -> Self {
        appendingStyle("transition: \(value)")
    }
    
    // Animation
    func animation(_ value: String) -> Self {
        appendingStyle("animation: \(value)")
    }
}
