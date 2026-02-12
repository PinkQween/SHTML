//
//  body.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public struct Body: HTML {
    private let content: () -> [any HTML]

    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.content = content
    }

    public func render() -> String {
        "<body>\(HTMLRendering.renderChildren(content))</body>"
    }
}

public typealias body = Body
