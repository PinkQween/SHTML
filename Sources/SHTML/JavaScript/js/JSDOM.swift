//
//  JSDOM.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

// Legacy - prefer using document from NaturalJS
/// Legacy DOM helper that renders `document.getElementById(...)`.
public struct JSGetElementById: JavaScript {
    private let id: String
    
    /// Creates a `getElementById` expression for an element id.
    public init(_ id: String) {
        self.id = id
    }
    
    /// Renders the JavaScript expression.
    public func render() -> String {
        "document.getElementById('\(id)')"
    }
}

/// Extension for JSGetElementById.
public extension JSGetElementById {
    /// Creates a statement that assigns a style property.
    func setStyle(_ property: JSStyleProperty, _ value: any ExpressibleAsJSArg) -> JSStatement {
        JSExpr(render()).setStyle(property, value)
    }

    /// Creates a statement that assigns a style property using a style-convertible value.
    func setStyle(_ property: JSStyleProperty, _ value: any JSStyleValueConvertible) -> JSStatement {
        JSExpr(render()).setStyle(property, value)
    }

    /// Creates a statement that assigns a style property using ``Color``.
    func setStyle(_ property: JSStyleProperty, _ color: Color) -> JSStatement {
        JSExpr(render()).setStyle(property, color)
    }
}

// Legacy - prefer using JSExpr.assign() from NaturalJS
/// Legacy helper for assigning `textContent`.
public struct JSSetTextContent: JavaScript {
    private let element: String
    private let text: String
    
    /// Creates a text-content assignment statement.
    public init(element: String, text: String) {
        self.element = element
        self.text = text
    }
    
    /// Renders the JavaScript statement.
    public func render() -> String {
        "\(element).textContent = \(text);"
    }
}

// Legacy - prefer using JSExpr.assign() from NaturalJS
/// Legacy helper for assigning an inline style property.
public struct JSSetStyle: JavaScript {
    private let element: String
    private let property: String
    private let value: JSArg
    
    /// Creates a style assignment from raw strings.
    public init(element: String, property: String, value: String) {
        self.element = element
        self.property = property
        self.value = .raw(value)
    }

    /// Creates a style assignment from a typed style property.
    public init(element: String, property: JSStyleProperty, value: any ExpressibleAsJSArg) {
        self.element = element
        self.property = property.rawValue
        self.value = value.jsArg
    }

    /// Creates a style assignment using ``Color``.
    public init(element: String, property: JSStyleProperty, color: Color) {
        self.init(element: element, property: property, value: color)
    }
    
    /// Renders the JavaScript statement.
    public func render() -> String {
        "\(element).style.\(property) = \(value.toJS());"
    }
}
