// Spacer-like flexible space
public struct Spacer: HTML {
    /// Creates a new instance.
    public init() {}
    
    /// render function.
    public func render() -> String {
        "<div style=\"flex-grow: 1;\"></div>"
    }
}
