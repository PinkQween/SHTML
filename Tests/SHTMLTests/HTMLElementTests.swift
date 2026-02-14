import XCTest
@testable import SHTML

/// Tests for core HTML protocol and element rendering
final class HTMLElementTests: XCTestCase {
    
    // MARK: - Basic Element Tests
    
    func testDivRendering() {
        let div = Div { "Hello" }
        XCTAssertEqual(div.render(), "<div>Hello</div>")
    }
    
    func testDivWithMultipleChildren() {
        let div = Div {
            h1 { "Title" }
            p { "Paragraph" }
        }
        let expected = "<div><h1>Title</h1><p>Paragraph</p></div>"
        XCTAssertEqual(div.render(), expected)
    }
    
    func testHeadingElements() {
        XCTAssertEqual(h1 { "H1" }.render(), "<h1>H1</h1>")
        XCTAssertEqual(h2 { "H2" }.render(), "<h2>H2</h2>")
        XCTAssertEqual(h3 { "H3" }.render(), "<h3>H3</h3>")
        XCTAssertEqual(h4 { "H4" }.render(), "<h4>H4</h4>")
        XCTAssertEqual(h5 { "H5" }.render(), "<h5>H5</h5>")
        XCTAssertEqual(h6 { "H6" }.render(), "<h6>H6</h6>")
    }
    
    func testParagraph() {
        let p = p { "This is a paragraph." }
        XCTAssertEqual(p.render(), "<p>This is a paragraph.</p>")
    }
    
    func testSpan() {
        let span = span { "Inline text" }
        XCTAssertEqual(span.render(), "<span>Inline text</span>")
    }
    
    func testButton() {
        let btn = button { "Click Me" }
        XCTAssertEqual(btn.render(), "<button>Click Me</button>")
    }
    
    func testButtonWithId() {
        let btn = button { "Click" }.id("myBtn")
        XCTAssertTrue(btn.render().contains("id=\"myBtn\""))
        XCTAssertTrue(btn.render().contains("Click"))
    }
    
    // MARK: - List Elements
    
    func testUnorderedList() {
        let list = ul {
            li { "Item 1" }
            li { "Item 2" }
        }
        let result = list.render()
        XCTAssertTrue(result.contains("<ul>"))
        XCTAssertTrue(result.contains("<li>Item 1</li>"))
        XCTAssertTrue(result.contains("<li>Item 2</li>"))
    }

    func testOrderedList() {
        let list = ol {
            li { "First" }
            li { "Second" }
        }
        .start(5)
        let result = list.render()
        XCTAssertTrue(result.contains("<ol"))
        XCTAssertTrue(result.contains("start=\"5\""))
        XCTAssertTrue(result.contains("<li>First</li>"))
    }
    
    // MARK: - Empty Elements
    
    func testBreak() {
        let br = br()
        XCTAssertEqual(br.render(), "<br />")
    }

    func testHorizontalRule() {
        XCTAssertEqual(hr().render(), "<hr />")
    }
    
    func testImage() {
        let img = img(src: "test.jpg", alt: "Test")
        let result = img.render()
        XCTAssertTrue(result.contains("src=\"test.jpg\""))
        XCTAssertTrue(result.contains("alt=\"Test\""))
    }
    
    // MARK: - Meta Elements
    
    func testMeta() {
        let meta = meta().charset("UTF-8")
        XCTAssertTrue(meta.render().contains("charset=\"UTF-8\""))
    }
    
    func testMetaNameContent() {
        let meta = meta().name("viewport").content("width=device-width")
        let result = meta.render()
        XCTAssertTrue(result.contains("name=\"viewport\""))
        XCTAssertTrue(result.contains("content=\"width=device-width\""))
    }
    
    // MARK: - Document Structure
    
    func testCompleteHTMLDocument() {
        let doc = html {
            head {
                Title("Test Page")
            }
            body {
                h1 { "Hello, World!" }
            }
        }
        
        let result = doc.render()
        XCTAssertTrue(result.contains("<html>"))
        XCTAssertTrue(result.contains("<head>"))
        XCTAssertTrue(result.contains("<title>Test Page</title>"))
        XCTAssertTrue(result.contains("<body>"))
        XCTAssertTrue(result.contains("<h1>Hello, World!</h1>"))
    }
    
    // MARK: - Group Component
    
    func testGroup() {
        let group = Group {
            h1 { "Title" }
            p { "Paragraph" }
        }
        let expected = "<h1>Title</h1><p>Paragraph</p>"
        XCTAssertEqual(group.render(), expected)
    }

    func testFieldsetLegendLabel() {
        let result = fieldset {
            legend { "Profile" }
            label { "Name" }.for("name")
            input().id("name")
        }
        .render()
        XCTAssertTrue(result.contains("<fieldset>"))
        XCTAssertTrue(result.contains("<legend>Profile</legend>"))
        XCTAssertTrue(result.contains("for=\"name\""))
    }

    func testSelectOptionAndTextarea() {
        let result = Div {
            select {
                option { "One" }.value("1")
                option { "Two" }.value("2").selected()
            }
            textarea { "Hello" }.rows(4).cols(10)
        }
        .render()
        XCTAssertTrue(result.contains("<select>"))
        XCTAssertTrue(result.contains("<option value=\"1\">One</option>"))
        XCTAssertTrue(result.contains("selected=\"\""))
        XCTAssertTrue(result.contains("<textarea"))
        XCTAssertTrue(result.contains("rows=\"4\""))
        XCTAssertTrue(result.contains("cols=\"10\""))
    }

    func testSemanticElements() {
        let result = article {
            header { h2 { "Title" } }
            section { p { "Body" } }
            footer { span { "Meta" } }
        }
        .render()
        XCTAssertTrue(result.contains("<article>"))
        XCTAssertTrue(result.contains("<header>"))
        XCTAssertTrue(result.contains("<section>"))
        XCTAssertTrue(result.contains("<footer>"))
    }
    
    // MARK: - Custom HTML Components
    
    func testCustomComponent() {
        struct Card: HTML {
            var body: some HTML {
                Div {
                    h2 { "Card Title" }
                    p { "Card content" }
                }
            }
        }
        
        let card = Card()
        let result = card.render()
        XCTAssertTrue(result.contains("<h2>Card Title</h2>"))
        XCTAssertTrue(result.contains("<p>Card content</p>"))
    }
}
