//
//  JavaScriptProtocol.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

/// A renderable JavaScript fragment.
public protocol JavaScript {
    /// Renders JavaScript source.
    func render() -> String
}

/// Extension for JavaScript.
public extension JavaScript {
    /// Convenience accessor for rendered JavaScript.
    var js: String { render() }
}
