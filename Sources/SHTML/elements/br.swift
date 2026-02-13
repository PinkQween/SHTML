//
//  br.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public struct Br: HTMLPrimitive {
    public typealias Content = Never
    
    public init() {}

    public func render() -> String {
        "<br />"
    }
}

public typealias br = Br
