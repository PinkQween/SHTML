//
//  body.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public struct Body: HTMLPrimitive, HTMLContentModifiable {
    public typealias Body = Never
    
    public var attributes: [String: String]
    private let content: () -> [any HTML]

    public init(@HTMLBuilder _ content: @escaping () -> [any HTML]) {
        self.attributes = [:]
        self.content = content
    }
    
    public init(attributes: [String: String], content: @escaping () -> [any HTML]) {
        self.attributes = attributes
        self.content = content
    }

    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        return "<body\(attrs)>\(HTMLRendering.renderChildren(content))</body>"
    }
}

public typealias body = Body
