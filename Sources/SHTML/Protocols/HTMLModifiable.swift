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
    /// Public-facing padding that doesn't expose internal types.
    /// Accepts a raw CSS length string.
    func padding(_ value: String) -> Self {
        appendingStyle("padding: \(value)")
    }

    /// Public-facing padding that accepts a CSSLength without referencing internal Edge.Set defaults.
    /// Callers specify the length and we apply it to all edges.
    func padding(_ length: CSSLength) -> Self {
        appendingStyle("padding: \(length.css)")
    }

    /// Internal helper that supports edge-specific padding using internal Edge.Set.
    /// Kept internal to avoid leaking internal types in the public API.
    internal func padding(_ edges: Edge.Set, _ length: CSSLength) -> Self {
        return padding(edges, length.css)
    }

    /// Internal helper that applies edge-specific padding using a raw CSS value.
    private func padding(_ edges: Edge.Set, _ value: String) -> Self {
        switch edges {
        case .all:
            return appendingStyle("padding: \(value)")
        case .horizontal:
            return appendingStyle("padding-left: \(value); padding-right: \(value)")
        case .vertical:
            return appendingStyle("padding-top: \(value); padding-bottom: \(value)")
        case .top:
            return appendingStyle("padding-top: \(value)")
        case .bottom:
            return appendingStyle("padding-bottom: \(value)")
        case .leading:
            return appendingStyle("padding-left: \(value)")
        case .trailing:
            return appendingStyle("padding-right: \(value)")
        default:
            var styles: [String] = []
            if edges.contains(.top) { styles.append("padding-top: \(value)") }
            if edges.contains(.bottom) { styles.append("padding-bottom: \(value)") }
            if edges.contains(.leading) { styles.append("padding-left: \(value)") }
            if edges.contains(.trailing) { styles.append("padding-right: \(value)") }
            return appendingStyle(styles.joined(separator: "; "))
        }
    }
    
    // Layout - Margin
    /// Public-facing margin that accepts a raw CSS length string and applies to all edges.
    func margin(_ value: String) -> Self {
        appendingStyle("margin: \(value)")
    }

    /// Public-facing margin that accepts a CSSLength and applies to all edges.
    func margin(_ length: CSSLength) -> Self {
        appendingStyle("margin: \(length.css)")
    }

    /// Internal helper to support edge-specific margin using internal Edge.Set and CSSLength.
    internal func margin(_ edges: Edge.Set, _ length: CSSLength) -> Self {
        return margin(edges, length.css)
    }

    /// Internal helper that applies edge-specific margin using a raw CSS value.
    private func margin(_ edges: Edge.Set, _ value: String) -> Self {
        switch edges {
        case .all:
            return appendingStyle("margin: \(value)")
        case .horizontal:
            return appendingStyle("margin-left: \(value); margin-right: \(value)")
        case .vertical:
            return appendingStyle("margin-top: \(value); margin-bottom: \(value)")
        case .top:
            return appendingStyle("margin-top: \(value)")
        case .bottom:
            return appendingStyle("margin-bottom: \(value)")
        case .leading:
            return appendingStyle("margin-left: \(value)")
        case .trailing:
            return appendingStyle("margin-right: \(value)")
        default:
            var styles: [String] = []
            if edges.contains(.top) { styles.append("margin-top: \(value)") }
            if edges.contains(.bottom) { styles.append("margin-bottom: \(value)") }
            if edges.contains(.leading) { styles.append("margin-left: \(value)") }
            if edges.contains(.trailing) { styles.append("margin-right: \(value)") }
            return appendingStyle(styles.joined(separator: "; "))
        }
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
    
    // Overlay - creates a positioned overlay element
    func overlay(@HTMLBuilder _ content: @escaping () -> [any HTML]) -> Div {
        Div {
            [self] + content()
        }
        .style("position: relative")
    }
    
    func overlay(alignment: String = "center", @HTMLBuilder _ content: @escaping () -> [any HTML]) -> Div {
        let alignStyles: String
        switch alignment {
        case "top":
            alignStyles = "top: 0; left: 50%; transform: translateX(-50%)"
        case "bottom":
            alignStyles = "bottom: 0; left: 50%; transform: translateX(-50%)"
        case "leading", "left":
            alignStyles = "left: 0; top: 50%; transform: translateY(-50%)"
        case "trailing", "right":
            alignStyles = "right: 0; top: 50%; transform: translateY(-50%)"
        case "topLeading":
            alignStyles = "top: 0; left: 0"
        case "topTrailing":
            alignStyles = "top: 0; right: 0"
        case "bottomLeading":
            alignStyles = "bottom: 0; left: 0"
        case "bottomTrailing":
            alignStyles = "bottom: 0; right: 0"
        default: // center
            alignStyles = "top: 50%; left: 50%; transform: translate(-50%, -50%)"
        }
        
        return Div {
            [self] + [Div {
                content()
            }
            .style("position: absolute; \(alignStyles)")]
        }
        .style("position: relative")
    }
}

