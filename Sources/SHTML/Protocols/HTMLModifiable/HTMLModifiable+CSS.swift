/// Bridge modifiers that let any CSS helper be applied to ``HTMLModifiable``.
public extension HTMLModifiable {
    /// Applies a single CSS value (property or property group).
    func css(_ value: CSS) -> Self {
        applyCSSValues([value])
    }

    /// Applies multiple CSS values in order.
    func css(_ values: CSS...) -> Self {
        applyCSSValues(values)
    }

    /// Applies CSS values produced by a ``CSSBuilder`` closure.
    func css(@CSSBuilder _ values: () -> [CSS]) -> Self {
        applyCSSValues(values())
    }

    private func applyCSSValues(_ values: [CSS]) -> Self {
        var fragments: [String] = []

        for value in values {
            if let property = value as? CSSProperty {
                fragments.append("\(property.name): \(property.value)")
                continue
            }

            if let group = value as? CSSPropertyGroup {
                for property in group.properties {
                    fragments.append("\(property.name): \(property.value)")
                }
                continue
            }
        }

        guard !fragments.isEmpty else { return self }
        return appendingStyle(fragments.joined(separator: "; "))
    }
}
