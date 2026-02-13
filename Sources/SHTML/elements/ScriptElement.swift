public struct ScriptTag: HTMLPrimitive {
    public typealias Content = Never
    
    private var attributes: [String: String]
    private let content: String
    
    public init(_ content: String = "") {
        self.attributes = [:]
        self.content = content
    }
    
    public init(@JSBuilder _ builder: @escaping () -> [any JavaScript]) {
        self.attributes = [:]
        self.content = JSRendering.renderStatements(builder)
    }
    
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        return "<script\(attrs)>\(content)</script>"
    }
    
    public func src(_ value: String) -> Self {
        var copy = self
        copy.attributes["src"] = value
        return copy
    }
    
    public func type(_ value: String) -> Self {
        var copy = self
        copy.attributes["type"] = value
        return copy
    }
    
    public func async(_ value: Bool = true) -> Self {
        var copy = self
        if value {
            copy.attributes["async"] = ""
        } else {
            copy.attributes.removeValue(forKey: "async")
        }
        return copy
    }
    
    public func `defer`(_ value: Bool = true) -> Self {
        var copy = self
        if value {
            copy.attributes["defer"] = ""
        } else {
            copy.attributes.removeValue(forKey: "defer")
        }
        return copy
    }
}

public typealias script = ScriptTag
public typealias ScriptElement = ScriptTag
