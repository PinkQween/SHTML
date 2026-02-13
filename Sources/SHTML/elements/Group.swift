// Group - Container for multiple HTML elements (like SwiftUI's Group)
public struct Group: HTMLPrimitive {
    public typealias Body = Never
    
    private let content: () -> [any HTML]
    
    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.content = content
    }
    
    public func render() -> String {
        content().map { $0.render() }.joined()
    }
}
