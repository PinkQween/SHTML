//
//  h1.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public struct H1: HTML {
    private let content: () -> [any HTML]

    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.content = content
    }

    public func render() -> String {
        "<h1>\(HTMLRendering.renderChildren(content))</h1>"
    }
}

public typealias h1 = H1
