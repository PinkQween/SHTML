public struct Text: HTML {
    private let value: String

    public init(_ value: String) {
        self.value = value
    }

    public func render() -> String {
        HTMLRendering.escape(value)
    }
}
