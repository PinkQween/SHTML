//
//  CSSProtocol.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public protocol CSS {
    func render() -> String
}

// CSS Selector - type-safe selector representation
public struct CSSSelector: ExpressibleByStringLiteral {
    let value: String
    
    public init(_ value: String) {
        self.value = value
    }
    
    public init(stringLiteral value: String) {
        self.value = value
    }
    
    // Pseudo-class support
    public var hover: CSSSelector {
        CSSSelector("\(value):hover")
    }
    
    public var active: CSSSelector {
        CSSSelector("\(value):active")
    }
    
    public var focus: CSSSelector {
        CSSSelector("\(value):focus")
    }
    
    public var disabled: CSSSelector {
        CSSSelector("\(value):disabled")
    }
    
    public var firstChild: CSSSelector {
        CSSSelector("\(value):first-child")
    }
    
    public var lastChild: CSSSelector {
        CSSSelector("\(value):last-child")
    }
    
    public var nthChild: CSSSelector {
        CSSSelector("\(value):nth-child")
    }
    
    // Helper to get class name without dot
    public var className: String {
        value.replacingOccurrences(of: ".", with: "")
    }
}

// CSS Rule - represents a selector with properties
public struct CSSRule: CSS {
    let selector: String
    let properties: [CSSProperty]
    
    public init(_ selector: String, @CSSBuilder _ properties: () -> [CSSProperty]) {
        self.selector = selector
        self.properties = properties()
    }
    
    public init(_ selector: CSSSelector, @CSSBuilder _ properties: () -> [CSSProperty]) {
        self.selector = selector.value
        self.properties = properties()
    }
    
    public func render() -> String {
        let props = properties.map { $0.render() }.joined(separator: "\n    ")
        return "\(selector) {\n    \(props)\n}"
    }
}

// CSS Property - represents a single CSS property
public struct CSSProperty: CSS {
    let name: String
    let value: String
    
    public init(_ name: String, _ value: String) {
        self.name = name
        self.value = value
    }
    
    public func render() -> String {
        "\(name): \(value);"
    }
}

// Keyframes animation
public struct CSSKeyframes: CSS {
    let name: String
    let frames: [CSSKeyframe]
    
    public init(_ name: String, @CSSKeyframeBuilder _ frames: () -> [CSSKeyframe]) {
        self.name = name
        self.frames = frames()
    }
    
    public func render() -> String {
        let frameContent = frames.map { $0.render() }.joined(separator: "\n    ")
        return "@keyframes \(name) {\n    \(frameContent)\n}"
    }
}

public struct CSSKeyframe: CSS {
    let position: String
    let properties: [CSSProperty]
    
    public init(_ position: String, @CSSBuilder _ properties: () -> [CSSProperty]) {
        self.position = position
        self.properties = properties()
    }
    
    public func render() -> String {
        let props = properties.map { $0.render() }.joined(separator: " ")
        return "\(position) { \(props) }"
    }
}

// Stylesheet - collection of CSS rules
public struct Stylesheet: CSS {
    let rules: [CSS]
    
    public init(@CSSStyleBuilder _ rules: () -> [CSS]) {
        self.rules = rules()
    }
    
    public func render() -> String {
        rules.map { $0.render() }.joined(separator: "\n")
    }
}
