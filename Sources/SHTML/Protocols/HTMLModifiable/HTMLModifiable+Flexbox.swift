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
}
