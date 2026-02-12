//
//  a.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public struct A: HTML {
    private var attributes: [String: String]
    private let content: () -> [any HTML]

    public init(href: String = "#", @HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = ["href": href]
        self.content = content
    }

    public func render() -> String {
        "<a\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</a>"
    }

    public func href(_ value: String) -> Self {
        var copy = self
        copy.attributes["href"] = value
        return copy
    }

    public func target(_ value: String) -> Self {
        var copy = self
        copy.attributes["target"] = value
        return copy
    }

    public func rel(_ value: String) -> Self {
        var copy = self
        copy.attributes["rel"] = value
        return copy
    }
}

public typealias a = A
