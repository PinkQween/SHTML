import Foundation

/// A top-level website definition that can render and write HTML output.
public protocol Website {
    /// Root HTML content type.
    associatedtype Content: HTML
    /// Root content instance.
    var content: Content { get }
    /// Creates the website.
    init()
}

/// Extension for Website.
public extension Website {
    /// Program entry point convenience.
    static func main() {
        Self.init().generate()
    }
    
    /// Builds the website HTML string.
    func build() -> String {
        content.render()
    }
    
    /// Generates and writes the website to disk.
    ///
    /// - Parameter outputPath: Output file path, defaulting to `public/index.html`.
    func generate(to outputPath: String = "public/index.html") {
        let html = build()
        
        // Create public directory
        let publicDir = (outputPath as NSString).deletingLastPathComponent
        try? FileManager.default.createDirectory(atPath: publicDir, withIntermediateDirectories: true)
        
        // Write HTML
        try? html.write(toFile: outputPath, atomically: true, encoding: .utf8)
        
        print("✅ Generated HTML at \(outputPath)")
        print("📄 File size: \(html.count) bytes")
    }
}
