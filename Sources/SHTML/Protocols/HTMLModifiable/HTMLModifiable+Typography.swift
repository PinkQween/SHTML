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
    
    func fontWeight(_ weight: String) -> Self {
        appendingStyle("font-weight: \(weight)")
    }
    
    func textAlign(_ alignment: String) -> Self {
        appendingStyle("text-align: \(alignment)")
    }
    
    func textAlign(_ alignment: TextAlign) -> Self {
        appendingStyle("text-align: \(alignment.rawValue)")
    }
}
