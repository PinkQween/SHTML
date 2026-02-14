/// Protocol for HTML elements that support attribute-based modifiers.
///
/// Conform to `HTMLModifiable` when your element stores HTML attributes and should
/// support shared modifiers such as `.id(_)`, `.class(_)`, `.style(_)`, and event handlers.
public protocol HTMLModifiable: HTML {
    /// Raw HTML attributes rendered on the element tag.
    var attributes: [String: String] { get set }
}

/// Protocol for modifiable HTML elements that also own child content.
///
/// `HTMLContentModifiable` extends ``HTMLModifiable`` with a required initializer
/// used by content-replacement helpers like ``HTMLModifiable/with(class:content:)``.
///
/// Use this for elements like `Div`, `A`, and `Button` that have both attributes and children.
public protocol HTMLContentModifiable: HTMLModifiable {
    /// Creates a new instance with updated attributes and child content.
    init(attributes: [String: String], content: @escaping () -> [any HTML])
}

/// Extension for HTMLModifiable.
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

/// Extension for HTMLModifiable.
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

// Typed JavaScript event overloads
public extension HTMLModifiable {
    func onclick(_ value: any JavaScript) -> Self {
        onclick(value.render())
    }

    func onclick(@JSBuilder _ value: () -> [any JavaScript]) -> Self {
        onclick(JSRendering.renderStatements(value))
    }

    func onchange(_ value: any JavaScript) -> Self {
        onchange(value.render())
    }

    func onchange(@JSBuilder _ value: () -> [any JavaScript]) -> Self {
        onchange(JSRendering.renderStatements(value))
    }

    func onsubmit(_ value: any JavaScript) -> Self {
        onsubmit(value.render())
    }

    func onsubmit(@JSBuilder _ value: () -> [any JavaScript]) -> Self {
        onsubmit(JSRendering.renderStatements(value))
    }

    func onkeydown(_ value: any JavaScript) -> Self {
        onkeydown(value.render())
    }

    func onkeyup(_ value: any JavaScript) -> Self {
        onkeyup(value.render())
    }

    func onfocus(_ value: any JavaScript) -> Self {
        onfocus(value.render())
    }

    func onblur(_ value: any JavaScript) -> Self {
        onblur(value.render())
    }

    func onmouseover(_ value: any JavaScript) -> Self {
        onmouseover(value.render())
    }

    func onmouseout(_ value: any JavaScript) -> Self {
        onmouseout(value.render())
    }

    func onmouseenter(_ value: any JavaScript) -> Self {
        onmouseenter(value.render())
    }

    func onmouseleave(_ value: any JavaScript) -> Self {
        onmouseleave(value.render())
    }

    func onmousedown(_ value: any JavaScript) -> Self {
        onmousedown(value.render())
    }

    func onmouseup(_ value: any JavaScript) -> Self {
        onmouseup(value.render())
    }

    func ontouchstart(_ value: any JavaScript) -> Self {
        ontouchstart(value.render())
    }

    func ontouchend(_ value: any JavaScript) -> Self {
        ontouchend(value.render())
    }

    func ontouchcancel(_ value: any JavaScript) -> Self {
        ontouchcancel(value.render())
    }

    func ondblclick(_ value: any JavaScript) -> Self {
        ondblclick(value.render())
    }

    func ondragstart(_ value: any JavaScript) -> Self {
        ondragstart(value.render())
    }

    func ondrag(_ value: any JavaScript) -> Self {
        ondrag(value.render())
    }

    func ondragend(_ value: any JavaScript) -> Self {
        ondragend(value.render())
    }

    func ondragenter(_ value: any JavaScript) -> Self {
        ondragenter(value.render())
    }

    func ondragover(_ value: any JavaScript) -> Self {
        ondragover(value.render())
    }

    func ondragleave(_ value: any JavaScript) -> Self {
        ondragleave(value.render())
    }

    func ondrop(_ value: any JavaScript) -> Self {
        ondrop(value.render())
    }
}
