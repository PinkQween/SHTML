// Flexbox modifiers
// Includes flex direction, justify, align, gap

public extension HTMLModifiable {
    // Flexbox
    func flexDirection(_ direction: String) -> Self {
        appendingStyle("display: flex; flex-direction: \(direction)")
    }
    
    func flexDirection(_ direction: FlexDirection) -> Self {
        appendingStyle("display: flex; flex-direction: \(direction.rawValue)")
    }
    
    func gap(_ spacing: String) -> Self {
        appendingStyle("gap: \(spacing)")
    }

    func gap(_ spacing: CSSLength) -> Self {
        appendingStyle("gap: \(spacing.css)")
    }
    
    func justifyContent(_ value: String) -> Self {
        appendingStyle("justify-content: \(value)")
    }
    
    func justifyContent(_ value: JustifyContent) -> Self {
        appendingStyle("justify-content: \(value.rawValue)")
    }
    
    func alignItems(_ value: String) -> Self {
        appendingStyle("align-items: \(value)")
    }
    
    func alignItems(_ value: AlignItems) -> Self {
        appendingStyle("align-items: \(value.rawValue)")
    }

    func flexWrap(_ value: String) -> Self {
        appendingStyle("flex-wrap: \(value)")
    }

    func flex(_ value: String) -> Self {
        appendingStyle("flex: \(value)")
    }

    func flexGrow(_ value: Int) -> Self {
        appendingStyle("flex-grow: \(value)")
    }

    func flexGrow(_ value: Double) -> Self {
        appendingStyle("flex-grow: \(value)")
    }

    func flexShrink(_ value: Int) -> Self {
        appendingStyle("flex-shrink: \(value)")
    }

    func flexShrink(_ value: Double) -> Self {
        appendingStyle("flex-shrink: \(value)")
    }

    func flexBasis(_ value: CSSLength) -> Self {
        appendingStyle("flex-basis: \(value.css)")
    }
}
