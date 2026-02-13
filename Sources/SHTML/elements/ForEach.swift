// ForEach - Loop over collections to generate HTML (like SwiftUI's ForEach)
public struct ForEach<Data: Sequence>: HTMLPrimitive {
    public typealias Content = Never
    
    private let data: Data
    private let content: (Data.Element) -> [any HTML]
    
    public init(_ data: Data, @HTMLBuilder content: @escaping (Data.Element) -> [any HTML]) {
        self.data = data
        self.content = content
    }
    
    public func render() -> String {
        data.flatMap { element in
            content(element).map { $0.render() }
        }.joined()
    }
}

// Convenience initializer for ranges
public extension ForEach where Data == Range<Int> {
    init(_ range: Range<Int>, @HTMLBuilder content: @escaping (Int) -> [any HTML]) {
        self.data = range
        self.content = content
    }
}

// Convenience initializer for closed ranges
public extension ForEach where Data == ClosedRange<Int> {
    init(_ range: ClosedRange<Int>, @HTMLBuilder content: @escaping (Int) -> [any HTML]) {
        self.data = range
        self.content = content
    }
}

// Convenience for arrays with index
public extension ForEach where Data == [(offset: Int, element: Any)] {
    init<T>(_ array: [T], @HTMLBuilder content: @escaping (Int, T) -> [any HTML]) {
        self.data = array.enumerated().map { ($0.offset, $0.element as Any) }
        self.content = { item in
            content(item.offset, item.element as! T)
        }
    }
}
