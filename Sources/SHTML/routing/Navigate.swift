public struct Navigate: HTML {
    private let to: String
    private let replace: Bool
    
    public init(to: String, replace: Bool = false) {
        self.to = to
        self.replace = replace
    }
    
    public func render() -> String {
        let replaceParam = replace ? "true" : "false"
        return """
        <script>window.navigate('\(to)', \(replaceParam));</script>
        """
    }
}
