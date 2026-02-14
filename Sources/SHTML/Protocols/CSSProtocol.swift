//
//  CSSProtocol.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public protocol CSS {
    func render() -> String
}

// CSS Property - represents a single CSS property
public struct CSSProperty: CSS {
    let name: String
    let value: String
    
    /// Creates a new instance.
    public init(_ name: String, _ value: String) {
        self.name = name
        self.value = value
    }
    
    /// render function.
    public func render() -> String {
        "\(name): \(value);"
    }
}

// CSS Property Group - represents multiple CSS properties that should be treated as one
public struct CSSPropertyGroup: CSS {
    let properties: [CSSProperty]
    
    /// Creates a new instance.
    public init(_ properties: [CSSProperty]) {
        self.properties = properties
    }
    
    /// render function.
    public func render() -> String {
        properties.map { $0.render() }.joined(separator: "\n    ")
    }
}

/// CSSKeyframe type.
public struct CSSKeyframe: CSS {
    let position: String
    let properties: [CSSProperty]
    
    /// Creates a new instance.
    public init(_ position: String, @CSSBuilder _ properties: () -> [CSS]) {
        self.position = position
        self.properties = properties().flatMap { item -> [CSSProperty] in
            if let prop = item as? CSSProperty {
                return [prop]
            } else if let group = item as? CSSPropertyGroup {
                return group.properties
            }
            return []
        }
    }
    
    /// render function.
    public func render() -> String {
        let props = properties.map { $0.render() }.joined(separator: " ")
        return "\(position) { \(props) }"
    }
}

// CSS Rule - represents a selector with properties
public struct CSSRule: CSS {
    let selector: String
    let properties: [CSSProperty]
    
    /// Creates a new instance.
    public init(_ selector: String, @CSSBuilder _ properties: () -> [CSS]) {
        self.selector = selector
        // Flatten CSS items into properties
        self.properties = properties().flatMap { item -> [CSSProperty] in
            if let prop = item as? CSSProperty {
                return [prop]
            } else if let group = item as? CSSPropertyGroup {
                return group.properties
            }
            return []
        }
    }
    
    /// Creates a new instance.
    public init(_ selector: CSSSelector, @CSSBuilder _ properties: () -> [CSS]) {
        self.selector = selector.value
        self.properties = properties().flatMap { item -> [CSSProperty] in
            if let prop = item as? CSSProperty {
                return [prop]
            } else if let group = item as? CSSPropertyGroup {
                return group.properties
            }
            return []
        }
    }
    
    /// render function.
    public func render() -> String {
        let props = properties.map { $0.render() }.joined(separator: "\n    ")
        return "\(selector) {\n    \(props)\n}"
    }
}

// Keyframes animation
public struct CSSKeyframes: CSS {
    let name: String
    let frames: [CSSKeyframe]
    
    /// Creates a new instance.
    public init(_ name: String, @CSSKeyframeBuilder _ frames: () -> [CSSKeyframe]) {
        self.name = name
        self.frames = frames()
    }
    
    /// render function.
    public func render() -> String {
        let frameContent = frames.map { $0.render() }.joined(separator: "\n    ")
        return "@keyframes \(name) {\n    \(frameContent)\n}"
    }
}

// Stylesheet - collection of CSS rules
public struct Stylesheet: CSS {
    let rules: [CSS]
    
    /// Creates a new instance.
    public init(@CSSStyleBuilder _ rules: () -> [CSS]) {
        self.rules = rules()
    }
    
    /// render function.
    public func render() -> String {
        rules.map { $0.render() }.joined(separator: "\n")
    }
}
