// Visual effects modifiers
// Includes opacity, transform, transition, border radius, shadows, cursor, animation

public extension HTMLModifiable {
    // Visual effects
    func opacity(_ value: Double) -> Self {
        appendingStyle("opacity: \(value)")
    }
    
    func cornerRadius(_ radius: String) -> Self {
        appendingStyle("border-radius: \(radius)")
    }
    
    func cornerRadius(_ radius: CSSLength) -> Self {
        appendingStyle("border-radius: \(radius.css)")
    }

    func cornerRadius(_ corners: Corner.Set, _ radius: String) -> Self {
        appendingStyle(borderRadiusDeclarations(for: corners, radius: radius))
    }

    func cornerRadius(_ corners: Corner.Set, _ radius: CSSLength) -> Self {
        cornerRadius(corners, radius.css)
    }
    
    func borderRadius(_ radius: String) -> Self {
        appendingStyle("border-radius: \(radius)")
    }
    
    func borderRadius(_ radius: CSSLength) -> Self {
        appendingStyle("border-radius: \(radius.css)")
    }

    func borderRadius(topLeft: String, topRight: String, bottomRight: String, bottomLeft: String) -> Self {
        appendingStyle("border-radius: \(topLeft) \(topRight) \(bottomRight) \(bottomLeft)")
    }

    func borderRadius(topLeft: CSSLength, topRight: CSSLength, bottomRight: CSSLength, bottomLeft: CSSLength) -> Self {
        borderRadius(
            topLeft: topLeft.css,
            topRight: topRight.css,
            bottomRight: bottomRight.css,
            bottomLeft: bottomLeft.css
        )
    }

    func borderRadius(_ corners: Corner.Set, _ radius: String) -> Self {
        appendingStyle(borderRadiusDeclarations(for: corners, radius: radius))
    }

    func borderRadius(_ corners: Corner.Set, _ radius: CSSLength) -> Self {
        borderRadius(corners, radius.css)
    }

    func cornerRadius(topLeft: String, topRight: String, bottomRight: String, bottomLeft: String) -> Self {
        borderRadius(topLeft: topLeft, topRight: topRight, bottomRight: bottomRight, bottomLeft: bottomLeft)
    }

    func cornerRadius(topLeft: CSSLength, topRight: CSSLength, bottomRight: CSSLength, bottomLeft: CSSLength) -> Self {
        borderRadius(topLeft: topLeft, topRight: topRight, bottomRight: bottomRight, bottomLeft: bottomLeft)
    }
    
    func transition(_ value: String) -> Self {
        appendingStyle("transition: \(value)")
    }
    
    func transition(_ value: Transition) -> Self {
        appendingStyle("transition: \(value.css)")
    }
    
    func shadow(x: String = "0", y: String = "10px", blur: String = "30px", color: String = "rgba(0,0,0,0.2)") -> Self {
        appendingStyle("box-shadow: \(x) \(y) \(blur) \(color)")
    }
    
    func cursor(_ value: String) -> Self {
        appendingStyle("cursor: \(value)")
    }
    
    func cursor(_ value: Cursor) -> Self {
        appendingStyle("cursor: \(value.rawValue)")
    }
    
    // Transform
    func transform(_ value: String) -> Self {
        appendingStyle("transform: \(value)")
    }

    func transform(_ value: Transform) -> Self {
        appendingStyle("transform: \(value.css)")
    }

    func transform(_ operations: TransformOperation...) -> Self {
        transform(Transform(operations))
    }
    
    // Animation
    func animation(_ value: String) -> Self {
        appendingStyle("animation: \(value)")
    }
    
    // Image
    func objectFit(_ value: ObjectFit) -> Self {
        appendingStyle("object-fit: \(value.rawValue)")
    }

    private func borderRadiusDeclarations(for corners: Corner.Set, radius: String) -> String {
        if corners == .all {
            return "border-radius: \(radius)"
        }

        var declarations: [String] = []
        if corners.contains(.topLeft) {
            declarations.append("border-top-left-radius: \(radius)")
        }
        if corners.contains(.topRight) {
            declarations.append("border-top-right-radius: \(radius)")
        }
        if corners.contains(.bottomRight) {
            declarations.append("border-bottom-right-radius: \(radius)")
        }
        if corners.contains(.bottomLeft) {
            declarations.append("border-bottom-left-radius: \(radius)")
        }
        return declarations.joined(separator: "; ")
    }
}
