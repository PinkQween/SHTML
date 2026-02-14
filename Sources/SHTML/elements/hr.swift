/// Horizontal rule element.
public struct Hr: HTMLPrimitive, HTMLModifiable {
    public typealias Content = Never

    public var attributes: [String: String]

    /// Creates a horizontal rule with optional attributes.
    public init(attributes: [String: String] = [:]) {
        self.attributes = attributes
    }

    /// Renders the element into an HTML `<hr />` string.
    public func render() -> String {
        "<hr\(HTMLRendering.renderAttributes(attributes)) />"
    }
}

/// Type alias for ``Hr``.
public typealias hr = Hr
