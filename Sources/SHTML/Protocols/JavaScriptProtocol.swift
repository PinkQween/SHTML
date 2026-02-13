//
//  JavaScriptProtocol.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public protocol JavaScript {
    func render() -> String
}

public extension JavaScript {
    var js: String { render() }
}
