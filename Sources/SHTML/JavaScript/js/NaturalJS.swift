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

    // Method calls with typed Swift values: document.getElementById("id")
    public func dynamicallyCall(withArguments args: [any ExpressibleAsJSArg]) -> JSExpr {
        let argList = args.map { $0.jsArg.toJS() }.joined(separator: ", ")
        return JSExpr("\(code)(\(argList))")
    }

    // Method calls with type-safe Swift values.
    public func call(_ args: any ExpressibleAsJSArg...) -> JSExpr {
        let jsArgs = args.map { $0.jsArg.toJS() }.joined(separator: ", ")
        return JSExpr("\(code)(\(jsArgs))")
    }
    
    // Assignment: element.assign("textContent", "Hi")
    public func assign(_ property: String, _ value: JSArg) -> JSStatement {
        JSStatement("\(code).\(property) = \(value.toJS())")
    }

    // Assignment with typed JS expression/values
    public func assign(_ property: String, _ value: any ExpressibleAsJSArg) -> JSStatement {
        assign(property, value.jsArg)
    }

    // Direct expression assignment: JS.this.scrollTop.set(...)
    public func set(_ value: any ExpressibleAsJSArg) -> JSStatement {
        JSStatement("\(code) = \(value.jsArg.toJS())")
    }

    // Direct assignment for CSS colors: element.style.background.set(.red)
    public func set(_ color: Color) -> JSStatement {
        JSStatement("\(code) = '\(color.css)'")
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

// Common style properties for safer typed style assignments.
public enum JSStyleProperty: String, Sendable {
    case background
    case backgroundColor = "backgroundColor"
    case color
    case display
    case width
    case height
    case minWidth = "minWidth"
    case minHeight = "minHeight"
    case maxWidth = "maxWidth"
    case maxHeight = "maxHeight"
    case margin
    case marginTop = "marginTop"
    case marginRight = "marginRight"
    case marginBottom = "marginBottom"
    case marginLeft = "marginLeft"
    case padding
    case paddingTop = "paddingTop"
    case paddingRight = "paddingRight"
    case paddingBottom = "paddingBottom"
    case paddingLeft = "paddingLeft"
    case borderRadius = "borderRadius"
    case opacity
    case overflow
    case overflowX = "overflowX"
    case overflowY = "overflowY"
    case transform
    case transition
    case position
    case top
    case right
    case bottom
    case left
    case cursor
    case zIndex = "zIndex"
}

public protocol JSStyleValueConvertible {
    var jsStyleValue: String { get }
}

extension Color: JSStyleValueConvertible {
    public var jsStyleValue: String { css }
}

extension CSSLength: JSStyleValueConvertible {
    public var jsStyleValue: String { css }
}

extension CSSValue: JSStyleValueConvertible {
    public var jsStyleValue: String { css }
}

extension Display: JSStyleValueConvertible {
    public var jsStyleValue: String { rawValue }
}

extension Overflow: JSStyleValueConvertible {
    public var jsStyleValue: String { rawValue }
}

extension Position: JSStyleValueConvertible {
    public var jsStyleValue: String { rawValue }
}

extension Cursor: JSStyleValueConvertible {
    public var jsStyleValue: String { rawValue }
}

extension ScrollBehavior: JSStyleValueConvertible {
    public var jsStyleValue: String { rawValue }
}

extension ScrollbarWidth: JSStyleValueConvertible {
    public var jsStyleValue: String { rawValue }
}

extension ScrollbarGutter: JSStyleValueConvertible {
    public var jsStyleValue: String { rawValue }
}

extension BoxSizing: JSStyleValueConvertible {
    public var jsStyleValue: String { rawValue }
}

extension ObjectFit: JSStyleValueConvertible {
    public var jsStyleValue: String { rawValue }
}

extension UserDrag: JSStyleValueConvertible {
    public var jsStyleValue: String { rawValue }
}

extension TimingFunction: JSStyleValueConvertible {
    public var jsStyleValue: String { css }
}

extension Transition: JSStyleValueConvertible {
    public var jsStyleValue: String { css }
}

// Root JS objects
@MainActor public let console = JSExpr("console")
@MainActor public let document = JSExpr("document")
@MainActor public let window = JSExpr("window")
@MainActor public let localStorage = JSExpr("localStorage")
@MainActor public let sessionStorage = JSExpr("sessionStorage")

public extension JS {
    static var console: JSExpr { JSExpr("console") }
    static var document: JSExpr { JSExpr("document") }
    static var window: JSExpr { JSExpr("window") }
    static var globalThis: JSExpr { JSExpr("globalThis") }
    static var navigator: JSExpr { JSExpr("navigator") }
    static var history: JSExpr { JSExpr("history") }
    static var location: JSExpr { JSExpr("location") }
    static var performance: JSExpr { JSExpr("performance") }
    static var math: JSExpr { JSExpr("Math") }
    static var json: JSExpr { JSExpr("JSON") }
    static var intl: JSExpr { JSExpr("Intl") }
    static var promise: JSExpr { JSExpr("Promise") }
    static var reflect: JSExpr { JSExpr("Reflect") }
    static var symbol: JSExpr { JSExpr("Symbol") }
    static var error: JSExpr { JSExpr("Error") }
    static var url: JSExpr { JSExpr("URL") }
    static var urlSearchParams: JSExpr { JSExpr("URLSearchParams") }
    static var date: JSExpr { JSExpr("Date") }
    static var fetch: JSExpr { JSExpr("fetch") }
    static var localStorage: JSExpr { JSExpr("localStorage") }
    static var sessionStorage: JSExpr { JSExpr("sessionStorage") }
    static var `this`: JSExpr { JSExpr("this") }
    static var event: JSExpr { JSExpr("event") }

    // Fetch helpers
    static func fetch(_ resource: any ExpressibleAsJSArg) -> JSExpr {
        JS.fetch.call(resource)
    }

    static func fetch(_ resource: any ExpressibleAsJSArg, options: any ExpressibleAsJSArg) -> JSExpr {
        JS.fetch.call(resource, options)
    }

    // Math helpers
    enum Math {
        public static var E: JSExpr { JSExpr("Math.E") }
        public static var PI: JSExpr { JSExpr("Math.PI") }

        public static func abs(_ value: any ExpressibleAsJSArg) -> JSExpr {
            JS.math.abs.call(value)
        }

        public static func floor(_ value: any ExpressibleAsJSArg) -> JSExpr {
            JS.math.floor.call(value)
        }

        public static func ceil(_ value: any ExpressibleAsJSArg) -> JSExpr {
            JS.math.ceil.call(value)
        }

        public static func round(_ value: any ExpressibleAsJSArg) -> JSExpr {
            JS.math.round.call(value)
        }

        public static func max(_ a: any ExpressibleAsJSArg, _ b: any ExpressibleAsJSArg) -> JSExpr {
            JS.math.max.call(a, b)
        }

        public static func min(_ a: any ExpressibleAsJSArg, _ b: any ExpressibleAsJSArg) -> JSExpr {
            JS.math.min.call(a, b)
        }

        public static func pow(_ base: any ExpressibleAsJSArg, _ exponent: any ExpressibleAsJSArg) -> JSExpr {
            JS.math.pow.call(base, exponent)
        }

        public static func random() -> JSExpr {
            JS.math.random.call()
        }
    }
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

extension Color: ExpressibleAsJSArg {
    public var jsArg: JSArg { .string(css) }
}

public protocol ExpressibleAsJSArg {
    var jsArg: JSArg { get }
}

public func + (lhs: JSExpr, rhs: any ExpressibleAsJSArg) -> JSExpr {
    lhs.plus(rhs)
}

public func - (lhs: JSExpr, rhs: any ExpressibleAsJSArg) -> JSExpr {
    lhs.minus(rhs)
}

public func * (lhs: JSExpr, rhs: any ExpressibleAsJSArg) -> JSExpr {
    lhs.multiplied(by: rhs)
}

public func / (lhs: JSExpr, rhs: any ExpressibleAsJSArg) -> JSExpr {
    lhs.divided(by: rhs)
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
    // Typed style helpers
    func styleValue(_ property: JSStyleProperty) -> JSExpr {
        JSExpr("\(render()).style.\(property.rawValue)")
    }

    func setStyle(_ property: JSStyleProperty, _ value: any ExpressibleAsJSArg) -> JSStatement {
        styleValue(property).set(value)
    }

    func setStyle(_ property: JSStyleProperty, _ color: Color) -> JSStatement {
        styleValue(property).set(color)
    }

    func setStyle(_ property: JSStyleProperty, _ value: any JSStyleValueConvertible) -> JSStatement {
        styleValue(property).set(value.jsStyleValue)
    }

    // Concrete overloads for enum member inference: .setStyle(.display, .flex)
    func setStyle(_ property: JSStyleProperty, _ value: Display) -> JSStatement {
        setStyle(property, value.jsStyleValue)
    }

    func setStyle(_ property: JSStyleProperty, _ value: Overflow) -> JSStatement {
        setStyle(property, value.jsStyleValue)
    }

    func setStyle(_ property: JSStyleProperty, _ value: Position) -> JSStatement {
        setStyle(property, value.jsStyleValue)
    }

    func setStyle(_ property: JSStyleProperty, _ value: Cursor) -> JSStatement {
        setStyle(property, value.jsStyleValue)
    }

    func removeStyle(_ property: JSStyleProperty) -> JSStatement {
        styleValue(property).set("")
    }

    // DOM query helpers
    func getElementById(_ id: String) -> JSExpr {
        self.getElementById(.string(id))
    }

    func getElementById(_ id: JSArg) -> JSExpr {
        JSExpr("\(render()).getElementById(\(id.toJS()))")
    }

    func querySelector(_ selector: String) -> JSExpr {
        self.querySelector(.string(selector))
    }

    func querySelector(_ selector: JSArg) -> JSExpr {
        JSExpr("\(render()).querySelector(\(selector.toJS()))")
    }

    func querySelectorAll(_ selector: String) -> JSExpr {
        self.querySelectorAll(.string(selector))
    }

    func querySelectorAll(_ selector: JSArg) -> JSExpr {
        JSExpr("\(render()).querySelectorAll(\(selector.toJS()))")
    }

    // Element helpers
    func setAttribute(_ name: String, _ value: any ExpressibleAsJSArg) -> JSStatement {
        JSStatement("\(render()).setAttribute('\(name)', \(value.jsArg.toJS()))")
    }

    func getAttribute(_ name: String) -> JSExpr {
        JSExpr("\(render()).getAttribute('\(name)')")
    }

    func appendChild(_ child: any ExpressibleAsJSArg) -> JSStatement {
        JSStatement("\(render()).appendChild(\(child.jsArg.toJS()))")
    }

    func remove() -> JSStatement {
        JSStatement("\(render()).remove()")
    }

    func preventDefault() -> JSStatement {
        JSStatement("\(render()).preventDefault()")
    }

    // classList helpers
    func classListAdd(_ className: String) -> JSStatement {
        JSStatement("\(render()).classList.add('\(className)')")
    }

    func classListRemove(_ className: String) -> JSStatement {
        JSStatement("\(render()).classList.remove('\(className)')")
    }

    func classListToggle(_ className: String) -> JSStatement {
        JSStatement("\(render()).classList.toggle('\(className)')")
    }

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
