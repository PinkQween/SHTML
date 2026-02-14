//
//  Script.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public struct Script: JavaScript {
    private let content: () -> [any JavaScript]
    
    /// Creates a new instance.
    public init(@JSBuilder _ content: @escaping () -> [any JavaScript]) {
        self.content = content
    }
    
    /// render function.
    public func render() -> String {
        JSRendering.renderStatements(content)
    }
}
