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
    private let value: String
    
    public init(element: String, property: String, value: String) {
        self.element = element
        self.property = property
        self.value = value
    }
    
    public func render() -> String {
        "\(element).style.\(property) = \(value);"
    }
}
