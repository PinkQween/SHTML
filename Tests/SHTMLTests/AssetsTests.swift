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
}
