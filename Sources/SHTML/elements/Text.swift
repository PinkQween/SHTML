/// Text type.
public struct Text: HTML {
    private let value: String

    /// Creates a new instance.
    public init(_ value: String) {
        self.value = value
    }

    /// render function.
    public func render() -> String {
        HTMLRendering.escape(value)
    }
}
