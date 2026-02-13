//
//  HTMLProtocol.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

/// The base protocol for all HTML content.
///
/// Conform to `HTML` to create custom HTML components. Use the `var content: some HTML` pattern
/// to compose smaller components into larger ones, similar to SwiftUI's `View` protocol.
///
/// ## Example
///
/// ```swift
/// struct Card: HTML {
///     var content: some HTML {
///         Div {
///             h2 { "Card Title" }
///             p { "Card content goes here" }
///         }
///         .padding("20px")
///         .background("white")
///         .cornerRadius("8px")
///     }
/// }
/// ```
///
/// ## Creating Primitive Elements
///
/// For base HTML elements that don't have sub-components, conform to ``HTMLPrimitive``
/// instead and implement the `render()` method directly.
///
/// ```swift
/// struct MyElement: HTMLPrimitive {
///     public typealias Content = Never
///
///     public func render() -> String {
///         "<custom-element>Content</custom-element>"
///     }
/// }
/// ```
///
/// ## Topics
///
/// ### Creating Components
///
/// - ``content``
/// - ``render()``
///
/// ### Primitive Elements
///
/// - ``HTMLPrimitive``
public protocol HTML {
    /// The type of content this HTML component produces.
    ///
    /// For most components, this will be `some HTML`. For primitive elements
    /// that directly implement `render()`, this should be `Never`.
    associatedtype Content
    
    /// The content and behavior of the HTML component.
    ///
    /// Use this property to define the structure of your HTML component by composing
    /// other HTML elements together.
    ///
    /// ```swift
    /// var content: some HTML {
    ///     Div {
    ///         h1 { "Title" }
    ///         p { "Paragraph" }
    ///     }
    /// }
    /// ```
    var content: Content { get }
    
    /// Renders this HTML component to a string.
    ///
    /// You typically don't call this method directly. The framework calls it automatically
    /// when generating the final HTML output.
    ///
    /// - Returns: The HTML string representation of this component.
    func render() -> String
}

// For primitive elements that don't have nested content
public extension HTML where Content == Never {
    var content: Never {
        fatalError("This element has no content")
    }
}

// Default render implementation for components with content (only when Content conforms to HTML)
public extension HTML where Content: HTML {
    func render() -> String {
        content.render()
    }
}

// Convenience property
public extension HTML {
    var html: String { render() }

    func mount(to elementID: String) {
        JS.setInnerHTML(elementID: elementID, html: render())
    }
}

/// Protocol for primitive HTML elements that don't have nested content.
///
/// Use `HTMLPrimitive` for base HTML elements like `<div>`, `<p>`, `<h1>`, etc.
/// These elements implement `render()` directly and don't compose other elements.
///
/// ## Example
///
/// ```swift
/// public struct CustomTag: HTMLPrimitive {
///     public typealias Content = Never
///     
///     private let content: String
///     
///     public init(_ content: String) {
///         self.content = content
///     }
///     
///     public func render() -> String {
///         "<custom>\(content)</custom>"
///     }
/// }
/// ```
public protocol HTMLPrimitive: HTML where Content == Never {
}

