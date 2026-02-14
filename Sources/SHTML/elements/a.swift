//
//  a.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public struct A: HTMLPrimitive, HTMLContentModifiable {
    /// Type alias.
    public typealias Content = Never
    
    /// Property.
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    /// Creates a new instance.
    public init(attributes: [String: String] = [:], content: @escaping () -> [any HTML]) {
        self.attributes = attributes
        self.content = content
    }

    /// Creates a new instance.
    public init(href: String = "#", @HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = ["href": href]
        self.content = content
    }

    /// render function.
    public func render() -> String {
        "<a\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</a>"
    }

    /// href function.
    public func href(_ value: String) -> Self {
        var copy = self
        copy.attributes["href"] = value
        return copy
    }

    /// target function.
    public func target(_ value: String) -> Self {
        var copy = self
        copy.attributes["target"] = value
        return copy
    }

    /// rel function.
    public func rel(_ value: String) -> Self {
        var copy = self
        copy.attributes["rel"] = value
        return copy
    }
}

/// Type alias.
public typealias a = A
