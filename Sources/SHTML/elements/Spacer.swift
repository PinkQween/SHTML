// Spacer-like flexible space
public struct Spacer: HTML {
    public init() {}
    
    public func render() -> String {
        "<div style=\"flex-grow: 1;\"></div>"
    }
}
