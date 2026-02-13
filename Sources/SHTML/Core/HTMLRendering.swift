//
//  HTMLRendering.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public enum HTMLRendering {
    public static func renderChildren(_ content: () -> [any HTML]) -> String {
        content().map { $0.render() }.joined()
    }

    public static func renderAttributes(_ attributes: [String: String]) -> String {
        guard !attributes.isEmpty else { return "" }

        let rendered = attributes
            .sorted { $0.key < $1.key }
            .map { key, value in "\(key)=\"\(escape(value))\"" }
            .joined(separator: " ")
        return " \(rendered)"
    }

    public static func escape(_ value: String) -> String {
        var escaped = String()
        escaped.reserveCapacity(value.count)

        for character in value {
            switch character {
            case "&":
                escaped += "&amp;"
            case "<":
                escaped += "&lt;"
            case ">":
                escaped += "&gt;"
            case "\"":
                escaped += "&quot;"
            case "'":
                escaped += "&#39;"
            default:
                escaped.append(character)
            }
        }

        return escaped
    }
}
