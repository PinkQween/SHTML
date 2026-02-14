// Group - Container for multiple HTML elements (like SwiftUI's Group)
public struct Group: HTMLPrimitive {
    /// Type alias.
    public typealias Content = Never
    
    private let content: () -> [any HTML]
    
    /// Creates a new instance.
    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.content = content
    }
    
    /// render function.
    public func render() -> String {
        content().map { $0.render() }.joined()
    }
}
