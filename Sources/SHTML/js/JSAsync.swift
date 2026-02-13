//
//  JSAsync.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public struct JSFetch: JavaScript {
    private let url: String
    private let options: [String: String]
    
    public init(_ url: String, options: [String: String] = [:]) {
        self.url = url
        self.options = options
    }
    
    public func render() -> String {
        if options.isEmpty {
            return "fetch('\(url)')"
        } else {
            let opts = options.map { "\($0.key): \($0.value)" }.joined(separator: ", ")
            return "fetch('\(url)', { \(opts) })"
        }
    }
}

public struct JSAwait: JavaScript {
    private let expression: String
    
    public init(_ expression: String) {
        self.expression = expression
    }
    
    public func render() -> String {
        "await \(expression)"
    }
}

public struct JSTryCatch: JavaScript {
    private let tryBlock: () -> [any JavaScript]
    private let catchParam: String
    private let catchBlock: () -> [any JavaScript]
    
    public init(
        @JSBuilder try tryBody: @escaping () -> [any JavaScript],
        catch catchParam: String = "error",
        @JSBuilder catchBody: @escaping () -> [any JavaScript]
    ) {
        self.tryBlock = tryBody
        self.catchParam = catchParam
        self.catchBlock = catchBody
    }
    
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
    
    public init(_ message: String) {
        self.message = message
    }
    
    public func render() -> String {
        "console.log(\(message));"
    }
}

// Legacy - prefer using `console.error("message")` from NaturalJS
public struct JSConsoleError: JavaScript {
    private let message: String
    
    public init(_ message: String) {
        self.message = message
    }
    
    public func render() -> String {
        "console.error(\(message));"
    }
}

public struct JSReturn: JavaScript {
    private let value: String?
    
    public init(_ value: String? = nil) {
        self.value = value
    }
    
    public func render() -> String {
        if let value = value {
            return "return \(value);"
        }
        return "return;"
    }
}
