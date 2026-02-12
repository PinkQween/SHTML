//
//  String.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

extension String: HTML {
    public func render() -> String {
        Text(self).render()
    }
}
