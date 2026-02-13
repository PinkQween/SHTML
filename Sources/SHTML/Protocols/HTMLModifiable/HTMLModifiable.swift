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
    
    func `class`(_ selector: CSSSelector) -> Self {
        var copy = self
        copy.attributes["class"] = selector.className
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
    
    func draggable(_ value: Bool = true) -> Self {
        var copy = self
        copy.attributes["draggable"] = value ? "true" : "false"
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

    func ondblclick(_ value: String) -> Self {
        var copy = self
        copy.attributes["ondblclick"] = value
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

    func onmouseenter(_ value: String) -> Self {
        var copy = self
        copy.attributes["onmouseenter"] = value
        return copy
    }

    func onmouseout(_ value: String) -> Self {
        var copy = self
        copy.attributes["onmouseout"] = value
        return copy
    }

    func onmouseleave(_ value: String) -> Self {
        var copy = self
        copy.attributes["onmouseleave"] = value
        return copy
    }

    func onmousedown(_ value: String) -> Self {
        var copy = self
        copy.attributes["onmousedown"] = value
        return copy
    }

    func onmouseup(_ value: String) -> Self {
        var copy = self
        copy.attributes["onmouseup"] = value
        return copy
    }

    func ontouchstart(_ value: String) -> Self {
        var copy = self
        copy.attributes["ontouchstart"] = value
        return copy
    }

    func ontouchend(_ value: String) -> Self {
        var copy = self
        copy.attributes["ontouchend"] = value
        return copy
    }

    func ontouchcancel(_ value: String) -> Self {
        var copy = self
        copy.attributes["ontouchcancel"] = value
        return copy
    }
    
    // Drag and drop events
    func ondragstart(_ value: String) -> Self {
        var copy = self
        copy.attributes["ondragstart"] = value
        return copy
    }
    
    func ondrag(_ value: String) -> Self {
        var copy = self
        copy.attributes["ondrag"] = value
        return copy
    }
    
    func ondragend(_ value: String) -> Self {
        var copy = self
        copy.attributes["ondragend"] = value
        return copy
    }
    
    func ondragenter(_ value: String) -> Self {
        var copy = self
        copy.attributes["ondragenter"] = value
        return copy
    }
    
    func ondragover(_ value: String) -> Self {
        var copy = self
        copy.attributes["ondragover"] = value
        return copy
    }
    
    func ondragleave(_ value: String) -> Self {
        var copy = self
        copy.attributes["ondragleave"] = value
        return copy
    }
    
    func ondrop(_ value: String) -> Self {
        var copy = self
        copy.attributes["ondrop"] = value
        return copy
    }
}
