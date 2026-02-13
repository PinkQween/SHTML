import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Validates hex color at compile time
public struct HexColorMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let argument = node.arguments.first?.expression,
              let stringLiteral = argument.as(StringLiteralExprSyntax.self),
              stringLiteral.segments.count == 1,
              case .stringSegment(let segment) = stringLiteral.segments.first else {
            throw MacroError.requiresStaticString
        }
        
        let hexString = segment.content.text
        
        // Validate hex color format
        try validateHex(hexString)
        
        return "Color.hex(\(literal: hexString))"
    }
    
    private static func validateHex(_ value: String) throws {
        var hex = value
        
        // Remove # or 0x prefix
        if hex.hasPrefix("#") {
            hex = String(hex.dropFirst())
        } else if hex.lowercased().hasPrefix("0x") {
            hex = String(hex.dropFirst(2))
        }
        
        // Validate hex characters
        let validHexChars = Set("0123456789abcdefABCDEF")
        guard hex.allSatisfy({ validHexChars.contains($0) }) else {
            throw MacroError.invalidHexCharacters(value)
        }
        
        // Validate length (3, 6, or 8 digits)
        guard [3, 6, 8].contains(hex.count) else {
            throw MacroError.invalidHexLength(value, hex.count)
        }
    }
}

enum MacroError: Error, CustomStringConvertible {
    case requiresStaticString
    case invalidHexCharacters(String)
    case invalidHexLength(String, Int)
    
    var description: String {
        switch self {
        case .requiresStaticString:
            return "#hex requires a static string literal"
        case .invalidHexCharacters(let value):
            return "Invalid hex color '\(value)': must contain only 0-9, a-f, A-F"
        case .invalidHexLength(let value, let length):
            return "Invalid hex color '\(value)': has \(length) digits, must be 3, 6, or 8 (with optional # or 0x prefix)"
        }
    }
}

@main
struct SHTMLMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        HexColorMacro.self,
    ]
}
