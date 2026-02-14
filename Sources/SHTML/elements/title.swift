//
//  title.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public struct Title: HTML {
    private let text: String

    /// Creates a new instance.
    public init(_ text: String) {
        self.text = text
    }

    /// render function.
    public func render() -> String {
        "<title>\(HTMLRendering.escape(text))</title>"
    }
}

/// Type alias.
public typealias title = Title
