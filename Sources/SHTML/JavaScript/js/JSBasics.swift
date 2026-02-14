//
//  JSBasics.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

// Raw JS code
public struct JSRaw: JavaScript {
    private let code: String
    
    /// Creates a new instance.
    public init(_ code: String) {
        self.code = code
    }
    
    /// render function.
    public func render() -> String {
        code
    }
}

// Legacy - prefer using JSFunc from NaturalJS
public struct JSFunction: JavaScript {
    private let name: String
    private let params: [String]
    private let isAsync: Bool
    private let body: () -> [any JavaScript]
    
    /// Creates a new instance.
    public init(
        _ name: String,
        params: [String] = [],
        async: Bool = false,
        @JSBuilder body: @escaping () -> [any JavaScript]
    ) {
        self.name = name
        self.params = params
        self.isAsync = async
        self.body = body
    }
    
    /// render function.
    public func render() -> String {
        let asyncKeyword = isAsync ? "async " : ""
        let paramList = params.joined(separator: ", ")
        let statements = JSRendering.renderStatements(body)
        return """
        \(asyncKeyword)function \(name)(\(paramList)) {
            \(statements)
        }
        """
    }
}

// Legacy - prefer using const() from NaturalJS
public struct JSConst: JavaScript {
    private let name: String
    private let value: JSArg
    
    /// Creates a new instance.
    public init(_ name: String, _ value: JSArg) {
        self.name = name
        self.value = value
    }

    /// Creates a new instance.
    public init(_ name: String, _ value: any ExpressibleAsJSArg) {
        self.init(name, value.jsArg)
    }

    // Backward compatibility for legacy raw JS expression usage.
    public init(_ name: String, _ value: String) {
        self.init(name, .raw(value))
    }
    
    /// render function.
    public func render() -> String {
        "const \(name) = \(value.toJS());"
    }
}

// Legacy - prefer using let_() from NaturalJS
public struct JSLet: JavaScript {
    private let name: String
    private let value: JSArg
    
    /// Creates a new instance.
    public init(_ name: String, _ value: JSArg) {
        self.name = name
        self.value = value
    }

    /// Creates a new instance.
    public init(_ name: String, _ value: any ExpressibleAsJSArg) {
        self.init(name, value.jsArg)
    }

    // Backward compatibility for legacy raw JS expression usage.
    public init(_ name: String, _ value: String) {
        self.init(name, .raw(value))
    }
    
    /// render function.
    public func render() -> String {
        "let \(name) = \(value.toJS());"
    }
}
