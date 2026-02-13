// Inline style modifiers
// Includes padding, margin, colors, borders, and sizing

public extension HTMLModifiable {
    // Helper to append styles
    func appendingStyle(_ newStyle: String) -> Self {
        var copy = self
        var styles: [String] = []
        
        if let existing = copy.attributes["style"], !existing.isEmpty {
            styles.append(existing)
        }
        styles.append(newStyle)
        copy.attributes["style"] = styles.joined(separator: "; ")
        
        return copy
    }
    
    // Layout - Padding
    func padding(_ value: String) -> Self {
        appendingStyle("padding: \(value)")
    }

    func padding(_ length: CSSLength) -> Self {
        appendingStyle("padding: \(length.css)")
    }

    internal func padding(_ edges: Edge.Set, _ length: CSSLength) -> Self {
        return padding(edges, length.css)
    }

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
    func margin(_ value: String) -> Self {
        appendingStyle("margin: \(value)")
    }

    func margin(_ length: CSSLength) -> Self {
        appendingStyle("margin: \(length.css)")
    }

    internal func margin(_ edges: Edge.Set, _ length: CSSLength) -> Self {
        return margin(edges, length.css)
    }

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
    
    func background(_ color: Color) -> Self {
        appendingStyle("background: \(color.css)")
    }
    
    func foregroundColor(_ color: String) -> Self {
        appendingStyle("color: \(color)")
    }
    
    func foregroundColor(_ color: Color) -> Self {
        appendingStyle("color: \(color.css)")
    }
    
    // Borders
    func border(width: String = "1px", style: String = "solid", color: String = "black") -> Self {
        appendingStyle("border: \(width) \(style) \(color)")
    }
    
    func border(width: String, style: String = "solid", color: Color) -> Self {
        appendingStyle("border: \(width) \(style) \(color.css)")
    }
    
    func borderLeft(width: String, color: String) -> Self {
        appendingStyle("border-left: \(width) solid \(color)")
    }
    
    func borderLeft(width: String, color: Color) -> Self {
        appendingStyle("border-left: \(width) solid \(color.css)")
    }
    
    // Sizing
    func width(_ value: String) -> Self {
        appendingStyle("width: \(value)")
    }
    
    func width(_ value: CSSLength) -> Self {
        appendingStyle("width: \(value.css)")
    }
    
    func height(_ value: String) -> Self {
        appendingStyle("height: \(value)")
    }
    
    func height(_ value: CSSLength) -> Self {
        appendingStyle("height: \(value.css)")
    }
    
    func maxWidth(_ value: String) -> Self {
        appendingStyle("max-width: \(value)")
    }
    
    func maxWidth(_ value: CSSLength) -> Self {
        appendingStyle("max-width: \(value.css)")
    }
    
    func maxHeight(_ value: String) -> Self {
        appendingStyle("max-height: \(value)")
    }
    
    func maxHeight(_ value: CSSLength) -> Self {
        appendingStyle("max-height: \(value.css)")
    }
    
    func minWidth(_ value: String) -> Self {
        appendingStyle("min-width: \(value)")
    }
    
    func minWidth(_ value: CSSLength) -> Self {
        appendingStyle("min-width: \(value.css)")
    }
    
    func minHeight(_ value: String) -> Self {
        appendingStyle("min-height: \(value)")
    }
    
    func minHeight(_ value: CSSLength) -> Self {
        appendingStyle("min-height: \(value.css)")
    }
}
