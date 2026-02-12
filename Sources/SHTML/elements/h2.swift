//
//  h2.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public struct H2: HTML {
    private let content: () -> [any HTML]

    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.content = content
    }

    public func render() -> String {
        "<h2>\(HTMLRendering.renderChildren(content))</h2>"
    }
}

public typealias h2 = H2
