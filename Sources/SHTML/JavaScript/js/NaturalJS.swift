//
//  NaturalJS.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/13/26.
//

// Natural JavaScript API using dynamic member/call lookup
@dynamicMemberLookup
@dynamicCallable
public struct JSExpr: JavaScript {
    private let code: String
    
    public init(_ code: String) {
        self.code = code
    }
    
    public func render() -> String {
        code
    }
    
    // Property access: console.log, document.body, etc.
    public subscript(dynamicMember member: String) -> JSExpr {
        JSExpr("\(code).\(member)")
    }
    
    // Method calls: console.log("hello"), document.getElementById("id")
    public func dynamicallyCall(withArguments args: [JSArg]) -> JSExpr {
        let argList = args.map { $0.toJS() }.joined(separator: ", ")
        return JSExpr("\(code)(\(argList))")
    }
    
    // Assignment: element.assign("textContent", "Hi")
    public func assign(_ property: String, _ value: JSArg) -> JSStatement {
        JSStatement("\(code).\(property) = \(value.toJS())")
    }

    // Assignment with typed JS expression/values
    public func assign(_ property: String, _ value: any ExpressibleAsJSArg) -> JSStatement {
        assign(property, value.jsArg)
    }
    
    // Array/object indexing: arr[0], obj["key"]
    public subscript(_ index: JSArg) -> JSExpr {
        JSExpr("\(code)[\(index.toJS())]")
    }

    // Arithmetic helpers for type-safe expression building
    public func plus(_ value: any ExpressibleAsJSArg) -> JSExpr {
        JSExpr("(\(code) + \(value.jsArg.toJS()))")
    }

    public func minus(_ value: any ExpressibleAsJSArg) -> JSExpr {
        JSExpr("(\(code) - \(value.jsArg.toJS()))")
    }

    public func multiplied(by value: any ExpressibleAsJSArg) -> JSExpr {
        JSExpr("(\(code) * \(value.jsArg.toJS()))")
    }

    public func divided(by value: any ExpressibleAsJSArg) -> JSExpr {
        JSExpr("(\(code) / \(value.jsArg.toJS()))")
    }
}

// Root JS objects
@MainActor
public let console = JSExpr("console")
@MainActor
public let document = JSExpr("document")
@MainActor
public let window = JSExpr("window")
@MainActor
public let localStorage = JSExpr("localStorage")
@MainActor
public let sessionStorage = JSExpr("sessionStorage")

public extension JS {
    static var `this`: JSExpr { JSExpr("this") }
    static var event: JSExpr { JSExpr("event") }
}

// JS argument type - can be strings, numbers, bools, or raw code
public enum JSArg {
    case string(String)
    case number(Double)
    case int(Int)
    case bool(Bool)
    case raw(String)
    case expr(JSExpr)
    
    func toJS() -> String {
        switch self {
        case .string(let s): return "'\(s.replacingOccurrences(of: "'", with: "\\'"))'"
        case .number(let n): return "\(n)"
        case .int(let i): return "\(i)"
        case .bool(let b): return b ? "true" : "false"
        case .raw(let r): return r
        case .expr(let e): return e.render()
        }
    }
}

extension JSArg: ExpressibleAsJSArg {
    public var jsArg: JSArg { self }
}

// Allow literals to be used as arguments
extension String: ExpressibleAsJSArg {
    public var jsArg: JSArg { .string(self) }
}

extension Int: ExpressibleAsJSArg {
    public var jsArg: JSArg { .int(self) }
}

extension Double: ExpressibleAsJSArg {
    public var jsArg: JSArg { .number(self) }
}

extension Bool: ExpressibleAsJSArg {
    public var jsArg: JSArg { .bool(self) }
}

extension JSExpr: ExpressibleAsJSArg {
    public var jsArg: JSArg { .expr(self) }
}

public protocol ExpressibleAsJSArg {
    var jsArg: JSArg { get }
}

// JS Statement (adds semicolon)
public struct JSStatement: JavaScript {
    private let code: String
    
    public init(_ code: String) {
        self.code = code.hasSuffix(";") ? code : code + ";"
    }
    
    public func render() -> String {
        code
    }
}

// Helper functions for common operations
public func const(_ name: String, _ value: JSArg) -> JSStatement {
    JSStatement("const \(name) = \(value.toJS())")
}

public func let_(_ name: String, _ value: JSArg) -> JSStatement {
    JSStatement("let \(name) = \(value.toJS())")
}

public func var_(_ name: String, _ value: JSArg) -> JSStatement {
    JSStatement("var \(name) = \(value.toJS())")
}

public func `return`(_ value: JSArg? = nil) -> JSStatement {
    if let value = value {
        return JSStatement("return \(value.toJS())")
    }
    return JSStatement("return")
}

// Functions
public struct JSFunc: JavaScript {
    private let name: String?
    private let params: [String]
    private let isAsync: Bool
    private let body: () -> [any JavaScript]
    
    public init(
        _ name: String? = nil,
        params: [String] = [],
        async: Bool = false,
        @JSBuilder body: @escaping () -> [any JavaScript]
    ) {
        self.name = name
        self.params = params
        self.isAsync = async
        self.body = body
    }
    
    public func render() -> String {
        let asyncKeyword = isAsync ? "async " : ""
        let paramList = params.joined(separator: ", ")
        let statements = JSRendering.renderStatements(body)
        
        if let name = name {
            return """
            \(asyncKeyword)function \(name)(\(paramList)) {
                \(statements)
            }
            """
        } else {
            return """
            \(asyncKeyword)function(\(paramList)) {
                \(statements)
            }
            """
        }
    }
}

// Arrow functions
public struct JSArrow: JavaScript {
    private let params: [String]
    private let isAsync: Bool
    private let body: () -> [any JavaScript]
    
    public init(
        params: [String] = [],
        async: Bool = false,
        @JSBuilder body: @escaping () -> [any JavaScript]
    ) {
        self.params = params
        self.isAsync = async
        self.body = body
    }
    
    public func render() -> String {
        let asyncKeyword = isAsync ? "async " : ""
        let paramList: String
        if params.count == 1 {
            paramList = params[0]
        } else {
            paramList = "(\(params.joined(separator: ", ")))"
        }
        let statements = JSRendering.renderStatements(body)
        return """
        \(asyncKeyword)\(paramList) => {
            \(statements)
        }
        """
    }
}

// Event listeners
public extension JSExpr {
    func addEventListener(_ event: String, @JSBuilder handler: @escaping () -> [any JavaScript]) -> JSStatement {
        let body = JSRendering.renderStatements(handler)
        return JSStatement("\(code).addEventListener('\(event)', () => { \(body) })")
    }
}

// Method chaining helpers
public extension JSExpr {
    func forEach(@JSBuilder _ body: @escaping () -> [any JavaScript]) -> JSStatement {
        let statements = JSRendering.renderStatements(body)
        return JSStatement("\(code).forEach(() => { \(statements) })")
    }
    
    func then(@JSBuilder _ body: @escaping () -> [any JavaScript]) -> JSExpr {
        let statements = JSRendering.renderStatements(body)
        return JSExpr("\(code).then(() => { \(statements) })")
    }
    
    func `catch`(@JSBuilder _ body: @escaping () -> [any JavaScript]) -> JSExpr {
        let statements = JSRendering.renderStatements(body)
        return JSExpr("\(code).catch(() => { \(statements) })")
    }
}
