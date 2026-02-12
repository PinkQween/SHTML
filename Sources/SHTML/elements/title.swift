//
//  title.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public struct Title: HTML {
    private let text: String

    public init(_ text: String) {
        self.text = text
    }

    public func render() -> String {
        "<title>\(HTMLRendering.escape(text))</title>"
    }
}

public typealias title = Title
