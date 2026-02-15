//
//  JSAsync.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public struct JSFetch: JavaScript {
    private let url: String
    private let options: [String: String]
    
    /// Creates a new instance.
    public init(_ url: String, options: [String: String] = [:]) {
        self.url = url
        self.options = options
    }
    
    /// render function.
    public func render() -> String {
        if options.isEmpty {
            return "fetch('\(url)')"
        } else {
            let opts = options.map { "\($0.key): \($0.value)" }.joined(separator: ", ")
            return "fetch('\(url)', { \(opts) })"
        }
    }
}

/// JSAwait type.
public struct JSAwait: JavaScript {
    private let expression: String
    
    /// Creates a new instance.
    public init(_ expression: String) {
        self.expression = expression
    }
    
    /// render function.
    public func render() -> String {
        "await \(expression)"
    }
}

/// JSTryCatch type.
public struct JSTryCatch: JavaScript {
    private let tryBlock: () -> [any JavaScript]
    private let catchParam: String
    private let catchBlock: () -> [any JavaScript]
    
    /// Creates a new instance.
    public init(
        @JSBuilder try tryBody: @escaping () -> [any JavaScript],
        catch catchParam: String = "error",
        @JSBuilder catchBody: @escaping () -> [any JavaScript]
    ) {
        self.tryBlock = tryBody
        self.catchParam = catchParam
        self.catchBlock = catchBody
    }
    
    /// render function.
    public func render() -> String {
        let tryStatements = JSRendering.renderStatements(tryBlock)
        let catchStatements = JSRendering.renderStatements(catchBlock)
        return """
        try {
            \(tryStatements)
        } catch (\(catchParam)) {
            \(catchStatements)
        }
        """
    }
}

// Legacy - prefer using `console.log("message")` from NaturalJS
public struct JSConsoleLog: JavaScript {
    private let message: String
    
    /// Creates a new instance.
    public init(_ message: String) {
        self.message = message
    }
    
    /// render function.
    public func render() -> String {
        "console.log(\(message));"
    }
}

// Legacy - prefer using `console.error("message")` from NaturalJS
public struct JSConsoleError: JavaScript {
    private let message: String
    
    /// Creates a new instance.
    public init(_ message: String) {
        self.message = message
    }
    
    /// render function.
    public func render() -> String {
        "console.error(\(message));"
    }
}

/// JSReturn type.
public struct JSReturn: JavaScript {
    private let value: JSArg?

    /// Creates a new instance with no return value.
    public init() {
        self.value = nil
    }

    /// Backward-compatible raw JavaScript return expression.
    public init(_ value: String?) {
        self.value = value.map { .raw($0) }
    }

    /// Type-safe return expression.
    public init(_ value: any ExpressibleAsJSArg) {
        self.value = value.jsArg
    }

    /// Returns any JavaScript-renderable expression as raw JS.
    public init(_ value: any JavaScript) {
        self.value = .raw(value.render())
    }

    /// Direct JSArg initializer.
    public init(_ value: JSArg?) {
        self.value = value
    }
    
    /// render function.
    public func render() -> String {
        if let value = value {
            return "return \(value.toJS());"
        }
        return "return;"
    }
}
