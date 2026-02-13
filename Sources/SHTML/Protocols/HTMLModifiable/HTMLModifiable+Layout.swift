// Layout & positioning modifiers
// Includes display, position, overflow, z-index, and frame functions

public extension HTMLModifiable {
    // Display
    func display(_ value: String) -> Self {
        appendingStyle("display: \(value)")
    }
    
    func display(_ value: Display) -> Self {
        appendingStyle("display: \(value.rawValue)")
    }
    
    func overflow(_ value: String) -> Self {
        appendingStyle("overflow: \(value)")
    }
    
    func overflow(_ value: Overflow) -> Self {
        appendingStyle("overflow: \(value.rawValue)")
    }
    
    func overflowX(_ value: String) -> Self {
        appendingStyle("overflow-x: \(value)")
    }
    
    func overflowX(_ value: Overflow) -> Self {
        appendingStyle("overflow-x: \(value.rawValue)")
    }
    
    func overflowY(_ value: String) -> Self {
        appendingStyle("overflow-y: \(value)")
    }
    
    func overflowY(_ value: Overflow) -> Self {
        appendingStyle("overflow-y: \(value.rawValue)")
    }
    
    // Aspect Ratio
    func aspectRatio(_ ratio: Double) -> Self {
        appendingStyle("aspect-ratio: \(ratio)")
    }
    
    func aspectRatio(width: Double, height: Double) -> Self {
        appendingStyle("aspect-ratio: \(width) / \(height)")
    }
    
    // Frame - sizing modifiers
    func frame(width: String? = nil, height: String? = nil, minWidth: String? = nil, maxWidth: String? = nil, minHeight: String? = nil, maxHeight: String? = nil) -> Self {
        var result = self
        if let width = width { result = result.appendingStyle("width: \(width)") }
        if let height = height { result = result.appendingStyle("height: \(height)") }
        if let minWidth = minWidth { result = result.appendingStyle("min-width: \(minWidth)") }
        if let maxWidth = maxWidth { result = result.appendingStyle("max-width: \(maxWidth)") }
        if let minHeight = minHeight { result = result.appendingStyle("min-height: \(minHeight)") }
        if let maxHeight = maxHeight { result = result.appendingStyle("max-height: \(maxHeight)") }
        return result
    }
    
    func frame(width: CSSLength? = nil, height: CSSLength? = nil, minWidth: CSSLength? = nil, maxWidth: CSSLength? = nil, minHeight: CSSLength? = nil, maxHeight: CSSLength? = nil) -> Self {
        var result = self
        if let width = width { result = result.appendingStyle("width: \(width.css)") }
        if let height = height { result = result.appendingStyle("height: \(height.css)") }
        if let minWidth = minWidth { result = result.appendingStyle("min-width: \(minWidth.css)") }
        if let maxWidth = maxWidth { result = result.appendingStyle("max-width: \(maxWidth.css)") }
        if let minHeight = minHeight { result = result.appendingStyle("min-height: \(minHeight.css)") }
        if let maxHeight = maxHeight { result = result.appendingStyle("max-height: \(maxHeight.css)") }
        return result
    }
    
    func zIndex(_ value: Int) -> Self {
        appendingStyle("z-index: \(value)")
    }
    
    // Position
    func position(_ value: String) -> Self {
        appendingStyle("position: \(value)")
    }
    
    func position(_ value: Position) -> Self {
        appendingStyle("position: \(value.rawValue)")
    }
    
    func top(_ value: String) -> Self {
        appendingStyle("top: \(value)")
    }
    
    func top(_ value: CSSLength) -> Self {
        appendingStyle("top: \(value.css)")
    }
    
    func bottom(_ value: String) -> Self {
        appendingStyle("bottom: \(value)")
    }
    
    func bottom(_ value: CSSLength) -> Self {
        appendingStyle("bottom: \(value.css)")
    }
    
    func left(_ value: String) -> Self {
        appendingStyle("left: \(value)")
    }
    
    func left(_ value: CSSLength) -> Self {
        appendingStyle("left: \(value.css)")
    }
    
    func right(_ value: String) -> Self {
        appendingStyle("right: \(value)")
    }
    
    func right(_ value: CSSLength) -> Self {
        appendingStyle("right: \(value.css)")
    }
    
    // Positioned fill helper
    func positionedFill() -> Self {
        appendingStyle("position: absolute; top: 0; left: 0; width: 100%; height: 100%")
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
