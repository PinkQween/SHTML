import XCTest
@testable import SHTML

final class AssetsTests: XCTestCase {
    func testExternalFontRegistrationGeneratesFontFaceCSS() {
        var catalog = AssetCatalog()
        catalog.registerExternalFont(
            family: "Inter",
            url: "https://cdn.example.com/inter.woff2",
            format: .woff2,
            weight: "400",
            style: "normal",
            display: .swap
        )

        let css = catalog.generateFontCSS()
        XCTAssertTrue(css.contains("@font-face"))
        XCTAssertTrue(css.contains("font-family: 'Inter'"))
        XCTAssertTrue(css.contains("url('https://cdn.example.com/inter.woff2')"))
        XCTAssertTrue(css.contains("font-display: swap"))
    }

    func testExternalFontStylesheetGeneratesImport() {
        var catalog = AssetCatalog()
        catalog.registerExternalFontStylesheet("https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap")
        let css = catalog.generateFontCSS()
        XCTAssertTrue(css.contains("@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap');"))
    }

    func testAssetNameGeneratorProducesImageAndFontSymbols() throws {
        let root = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString, isDirectory: true)
        let images = root.appendingPathComponent("Assets/Images", isDirectory: true)
        let fonts = root.appendingPathComponent("Assets/Fonts", isDirectory: true)
        let output = root.appendingPathComponent("Generated", isDirectory: true)
        try FileManager.default.createDirectory(at: images, withIntermediateDirectories: true)
        try FileManager.default.createDirectory(at: fonts, withIntermediateDirectories: true)

        FileManager.default.createFile(atPath: images.appendingPathComponent("lily.webp").path, contents: Data())
        FileManager.default.createFile(atPath: fonts.appendingPathComponent("FascinateInline-Regular.ttf").path, contents: Data())

        try AssetNameGenerator.generate(
            imagesDirectory: images.path,
            fontsDirectory: fonts.path,
            outputDirectory: output.path
        )

        let imageGenerated = try String(contentsOf: output.appendingPathComponent("ImageName+Generated.swift"), encoding: .utf8)
        let fontGenerated = try String(contentsOf: output.appendingPathComponent("FontName+Generated.swift"), encoding: .utf8)

        XCTAssertTrue(imageGenerated.contains("static let lily: ImageName = \"lily\""))
        XCTAssertTrue(fontGenerated.contains("static let fascinateInlineRegular: FontName = \"FascinateInline-Regular\""))
    }
}
