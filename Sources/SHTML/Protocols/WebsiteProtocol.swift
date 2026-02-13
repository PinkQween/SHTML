import Foundation

public protocol Website {
    associatedtype Body: HTML
    var body: Body { get }
    init()
}

public extension Website {
    static func main() {
        Self.init().generate()
    }
    
    func build() -> String {
        body.render()
    }
    
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
