//
//  br.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public struct Br: HTMLPrimitive {
    /// Type alias.
    public typealias Content = Never
    
    /// Creates a new instance.
    public init() {}

    /// render function.
    public func render() -> String {
        "<br />"
    }
}

/// Type alias.
public typealias br = Br
