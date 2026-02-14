//
//  JSDOM.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

// Legacy - prefer using document from NaturalJS
public struct JSGetElementById: JavaScript {
    private let id: String
    
    public init(_ id: String) {
        self.id = id
    }
    
    public func render() -> String {
        "document.getElementById('\(id)')"
    }
}

public extension JSGetElementById {
    func setStyle(_ property: JSStyleProperty, _ value: any ExpressibleAsJSArg) -> JSStatement {
        JSExpr(render()).setStyle(property, value)
    }

    func setStyle(_ property: JSStyleProperty, _ value: any JSStyleValueConvertible) -> JSStatement {
        JSExpr(render()).setStyle(property, value)
    }

    func setStyle(_ property: JSStyleProperty, _ color: Color) -> JSStatement {
        JSExpr(render()).setStyle(property, color)
    }
}

// Legacy - prefer using JSExpr.assign() from NaturalJS
public struct JSSetTextContent: JavaScript {
    private let element: String
    private let text: String
    
    public init(element: String, text: String) {
        self.element = element
        self.text = text
    }
    
    public func render() -> String {
        "\(element).textContent = \(text);"
    }
}

// Legacy - prefer using JSExpr.assign() from NaturalJS
public struct JSSetStyle: JavaScript {
    private let element: String
    private let property: String
    private let value: JSArg
    
    public init(element: String, property: String, value: String) {
        self.element = element
        self.property = property
        self.value = .raw(value)
    }

    public init(element: String, property: JSStyleProperty, value: any ExpressibleAsJSArg) {
        self.element = element
        self.property = property.rawValue
        self.value = value.jsArg
    }

    public init(element: String, property: JSStyleProperty, color: Color) {
        self.init(element: element, property: property, value: color)
    }
    
    public func render() -> String {
        "\(element).style.\(property) = \(value.toJS());"
    }
}
