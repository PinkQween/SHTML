//
//  ViewProtocol.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

/// A SwiftUI-style view protocol that renders HTML.
public protocol View {
    /// Rendered HTML content type.
    associatedtype Content: HTML
    /// Declarative view body.
    @HTMLBuilder var body: Content { get }
}

/// Extension for View.
public extension View {
    /// Renders the view body as HTML.
    func render() -> String {
        body.render()
    }
}
