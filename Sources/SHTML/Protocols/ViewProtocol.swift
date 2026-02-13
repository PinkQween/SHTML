//
//  ViewProtocol.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public protocol View {
    associatedtype Content: HTML
    @HTMLBuilder var body: Content { get }
}

public extension View {
    func render() -> String {
        body.render()
    }
}
