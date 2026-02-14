// Typography modifiers
// Includes font size, weight, family, text alignment, line height

public extension HTMLModifiable {
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
    
    func fontSize(_ size: CSSLength) -> Self {
        appendingStyle("font-size: \(size.css)")
    }
    
    func fontWeight(_ weight: String) -> Self {
        appendingStyle("font-weight: \(weight)")
    }

    func fontFamily(_ family: String) -> Self {
        appendingStyle("font-family: \(family)")
    }

    func fontStyle(_ style: String) -> Self {
        appendingStyle("font-style: \(style)")
    }

    func fontStyle(_ style: FontStyle) -> Self {
        appendingStyle("font-style: \(style.rawValue)")
    }
    
    func textAlign(_ alignment: String) -> Self {
        appendingStyle("text-align: \(alignment)")
    }
    
    func textAlign(_ alignment: TextAlign) -> Self {
        appendingStyle("text-align: \(alignment.rawValue)")
    }

    func textDecoration(_ value: String) -> Self {
        appendingStyle("text-decoration: \(value)")
    }

    func textDecoration(_ value: TextDecoration) -> Self {
        appendingStyle("text-decoration: \(value.rawValue)")
    }

    func textTransform(_ value: String) -> Self {
        appendingStyle("text-transform: \(value)")
    }

    func textTransform(_ value: TextTransform) -> Self {
        appendingStyle("text-transform: \(value.rawValue)")
    }

    func lineHeight(_ value: String) -> Self {
        appendingStyle("line-height: \(value)")
    }

    func lineHeight(_ value: CSSLength) -> Self {
        appendingStyle("line-height: \(value.css)")
    }

    func letterSpacing(_ value: String) -> Self {
        appendingStyle("letter-spacing: \(value)")
    }

    func letterSpacing(_ value: CSSLength) -> Self {
        appendingStyle("letter-spacing: \(value.css)")
    }

    func wordSpacing(_ value: String) -> Self {
        appendingStyle("word-spacing: \(value)")
    }

    func wordSpacing(_ value: CSSLength) -> Self {
        appendingStyle("word-spacing: \(value.css)")
    }

    func whiteSpace(_ value: String) -> Self {
        appendingStyle("white-space: \(value)")
    }

    func whiteSpace(_ value: WhiteSpace) -> Self {
        appendingStyle("white-space: \(value.rawValue)")
    }

    func textShadow(_ value: String) -> Self {
        appendingStyle("text-shadow: \(value)")
    }

    func verticalAlign(_ value: String) -> Self {
        appendingStyle("vertical-align: \(value)")
    }

    func verticalAlign(_ value: VerticalAlign) -> Self {
        appendingStyle("vertical-align: \(value.rawValue)")
    }
}
