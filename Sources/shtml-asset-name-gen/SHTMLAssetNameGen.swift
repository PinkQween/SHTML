import Foundation

@main
struct SHTMLAssetNameGen {
    private static let imageExtensions: Set<String> = [
        "png", "jpg", "jpeg", "webp", "gif", "svg", "avif", "bmp", "tif", "tiff"
    ]
    private static let fontExtensions: Set<String> = [
        "ttf", "otf", "woff", "woff2", "eot"
    ]
    private static let videoExtensions: Set<String> = [
        "mp4", "webm", "ogg", "mov", "m4v"
    ]
    private static let audioExtensions: Set<String> = [
        "mp3", "wav", "ogg", "m4a", "aac", "flac"
    ]
    private static let swiftKeywords: Set<String> = [
        "associatedtype", "class", "deinit", "enum", "extension", "fileprivate", "func", "import",
        "init", "inout", "internal", "let", "open", "operator", "private", "protocol", "public",
        "rethrows", "static", "struct", "subscript", "typealias", "var", "break", "case", "catch",
        "continue", "default", "defer", "do", "else", "fallthrough", "for", "guard", "if", "in",
        "repeat", "return", "throw", "switch", "where", "while", "as", "Any", "false", "is", "nil",
        "self", "Self", "super", "throws", "true", "try", "_", "Type", "Protocol"
    ]

    static func main() throws {
        let args = CommandLine.arguments
        guard args.count == 6 else {
            fputs("Usage: shtml-asset-name-gen <images-dir> <videos-dir> <audio-dir> <fonts-dir> <output-dir>\\n", stderr)
            Foundation.exit(2)
        }

        let imagesDir = args[1]
        let videosDir = args[2]
        let audioDir = args[3]
        let fontsDir = args[4]
        let outputDir = args[5]

        try FileManager.default.createDirectory(atPath: outputDir, withIntermediateDirectories: true)

        let imageSymbols = try imageSymbols(in: imagesDir)
        let videoSymbols = try videoSymbols(in: videosDir)
        let audioSymbols = try audioSymbols(in: audioDir)
        let fontSymbols = try fontSymbols(in: fontsDir)

        try renderExtension(typeName: "ImageName", symbols: imageSymbols)
            .write(
                to: URL(fileURLWithPath: outputDir).appendingPathComponent("ImageName+Generated.swift"),
                atomically: true,
                encoding: .utf8
            )

        try renderExtension(typeName: "FontName", symbols: fontSymbols)
            .write(
                to: URL(fileURLWithPath: outputDir).appendingPathComponent("FontName+Generated.swift"),
                atomically: true,
                encoding: .utf8
            )
        try renderExtension(typeName: "VideoName", symbols: videoSymbols)
            .write(
                to: URL(fileURLWithPath: outputDir).appendingPathComponent("VideoName+Generated.swift"),
                atomically: true,
                encoding: .utf8
            )
        try renderExtension(typeName: "AudioName", symbols: audioSymbols)
            .write(
                to: URL(fileURLWithPath: outputDir).appendingPathComponent("AudioName+Generated.swift"),
                atomically: true,
                encoding: .utf8
            )
    }

    private static func imageSymbols(in directory: String) throws -> [(String, String, String)] {
        guard FileManager.default.fileExists(atPath: directory) else { return [] }

        let fileNames = try FileManager.default.contentsOfDirectory(atPath: directory)
        let entries = fileNames.compactMap { file -> (String, String)? in
            let url = URL(fileURLWithPath: file)
            let ext = url.pathExtension.lowercased()
            guard imageExtensions.contains(ext) else { return nil }
            return (url.deletingPathExtension().lastPathComponent, ext)
        }.sorted { lhs, rhs in
            if lhs.0 == rhs.0 { return lhs.1 < rhs.1 }
            return lhs.0 < rhs.0
        }

        var grouped: [String: [String]] = [:]
        for entry in entries {
            grouped[entry.0, default: []].append(entry.1)
        }

        var used = Set<String>()
        return entries.map { base, ext in
            let hasCollision = (grouped[base]?.count ?? 0) > 1
            let seed = hasCollision ? "\(base)-\(ext)" : base
            var id = swiftIdentifier(from: seed)
            if used.contains(id) {
                var n = 2
                while used.contains("\(id)\(n)") { n += 1 }
                id = "\(id)\(n)"
            }
            used.insert(id)
            return (id, base, ext)
        }
    }

    private static func fontSymbols(in directory: String) throws -> [(String, String)] {
        guard FileManager.default.fileExists(atPath: directory) else { return [] }

        let fileNames = try FileManager.default.contentsOfDirectory(atPath: directory)
        let baseNames = fileNames.compactMap { file -> String? in
            let url = URL(fileURLWithPath: file)
            guard fontExtensions.contains(url.pathExtension.lowercased()) else { return nil }
            return url.deletingPathExtension().lastPathComponent
        }.sorted()

        var used = Set<String>()
        return baseNames.map { base in
            var id = swiftIdentifier(from: base)
            if used.contains(id) {
                var n = 2
                while used.contains("\(id)\(n)") {
                    n += 1
                }
                id = "\(id)\(n)"
            }
            used.insert(id)
            return (id, base)
        }
    }

    private static func videoSymbols(in directory: String) throws -> [(String, String, String)] {
        guard FileManager.default.fileExists(atPath: directory) else { return [] }

        let fileNames = try FileManager.default.contentsOfDirectory(atPath: directory)
        let entries = fileNames.compactMap { file -> (String, String)? in
            let url = URL(fileURLWithPath: file)
            let ext = url.pathExtension.lowercased()
            guard videoExtensions.contains(ext) else { return nil }
            return (url.deletingPathExtension().lastPathComponent, ext)
        }.sorted { lhs, rhs in
            if lhs.0 == rhs.0 { return lhs.1 < rhs.1 }
            return lhs.0 < rhs.0
        }

        var grouped: [String: [String]] = [:]
        for entry in entries {
            grouped[entry.0, default: []].append(entry.1)
        }

        var used = Set<String>()
        return entries.map { base, ext in
            let hasCollision = (grouped[base]?.count ?? 0) > 1
            let seed = hasCollision ? "\(base)-\(ext)" : base
            var id = swiftIdentifier(from: seed)
            if used.contains(id) {
                var n = 2
                while used.contains("\(id)\(n)") { n += 1 }
                id = "\(id)\(n)"
            }
            used.insert(id)
            return (id, base, ext)
        }
    }

    private static func audioSymbols(in directory: String) throws -> [(String, String, String)] {
        guard FileManager.default.fileExists(atPath: directory) else { return [] }

        let fileNames = try FileManager.default.contentsOfDirectory(atPath: directory)
        let entries = fileNames.compactMap { file -> (String, String)? in
            let url = URL(fileURLWithPath: file)
            let ext = url.pathExtension.lowercased()
            guard audioExtensions.contains(ext) else { return nil }
            return (url.deletingPathExtension().lastPathComponent, ext)
        }.sorted { lhs, rhs in
            if lhs.0 == rhs.0 { return lhs.1 < rhs.1 }
            return lhs.0 < rhs.0
        }

        var grouped: [String: [String]] = [:]
        for entry in entries {
            grouped[entry.0, default: []].append(entry.1)
        }

        var used = Set<String>()
        return entries.map { base, ext in
            let hasCollision = (grouped[base]?.count ?? 0) > 1
            let seed = hasCollision ? "\(base)-\(ext)" : base
            var id = swiftIdentifier(from: seed)
            if used.contains(id) {
                var n = 2
                while used.contains("\(id)\(n)") { n += 1 }
                id = "\(id)\(n)"
            }
            used.insert(id)
            return (id, base, ext)
        }
    }

    private static func swiftIdentifier(from raw: String) -> String {
        let parts = raw
            .split(whereSeparator: { !$0.isLetter && !$0.isNumber })
            .map(String.init)
            .filter { !$0.isEmpty }

        guard let first = parts.first else { return "asset" }

        let head = first.prefix(1).lowercased() + first.dropFirst()
        let tail = parts.dropFirst().map { part in
            part.prefix(1).uppercased() + part.dropFirst()
        }.joined()

        var identifier = head + tail
        if let firstChar = identifier.first, firstChar.isNumber {
            identifier = "_\(identifier)"
        }
        if swiftKeywords.contains(identifier) {
            return "`\(identifier)`"
        }
        return identifier
    }

    private static func renderExtension(typeName: String, symbols: [(String, String, String)]) -> String {
        let members: String
        switch typeName {
        case "ImageName":
            members = symbols
                .map { "    static let \($0.0): ImageName = ImageName(\"\($0.1)\", format: .\($0.2))" }
                .joined(separator: "\n")
        case "VideoName":
            members = symbols
                .map { "    static let \($0.0): VideoName = VideoName(\"\($0.1)\", format: .\($0.2))" }
                .joined(separator: "\n")
        default:
            members = symbols
                .map { "    static let \($0.0): AudioName = AudioName(\"\($0.1)\", format: .\($0.2))" }
                .joined(separator: "\n")
        }

        return """
        // Generated by SHTML asset-name-gen. Do not edit.
        import SHTML

        extension \(typeName) {
        \(members)
        }
        """
    }

    private static func renderExtension(typeName: String, symbols: [(String, String)]) -> String {
        let members = symbols
            .map { "    static let \($0.0): FontName = \"\($0.1)\"" }
            .joined(separator: "\n")

        return """
        // Generated by SHTML asset-name-gen. Do not edit.
        import SHTML

        extension \(typeName) {
        \(members)
        }
        """
    }
}
