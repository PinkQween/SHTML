/// A helper element that triggers navigation when rendered.
public struct Navigate: HTML {
    private let to: String
    private let replace: Bool
    
    /// Creates a navigation trigger.
    ///
    /// - Parameters:
    ///   - to: Destination path.
    ///   - replace: Whether to replace the current history entry.
    public init(to: String, replace: Bool = false) {
        self.to = to
        self.replace = replace
    }
    
    /// Renders a script that calls `window.navigate`.
    public func render() -> String {
        let replaceParam = replace ? "true" : "false"
        return """
        <script>window.navigate('\(to)', \(replaceParam));</script>
        """
    }
}
