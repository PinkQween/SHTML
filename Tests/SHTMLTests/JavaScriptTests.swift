import XCTest
@testable import SHTML

/// Tests for the JavaScript generation system
final class JavaScriptTests: XCTestCase {
    
    // MARK: - JSArg Tests
    
    func testStringArgument() {
        let arg = JSArg.string("hello")
        XCTAssertEqual(arg.toJS(), "'hello'")
    }
    
    func testIntArgument() {
        let arg = JSArg.int(42)
        XCTAssertEqual(arg.toJS(), "42")
    }
    
    func testBoolArgument() {
        let arg = JSArg.bool(true)
        XCTAssertEqual(arg.toJS(), "true")
        
        let falseArg = JSArg.bool(false)
        XCTAssertEqual(falseArg.toJS(), "false")
    }
    
    func testRawArgument() {
        let arg = JSArg.raw("myVariable")
        XCTAssertEqual(arg.toJS(), "myVariable")
    }
    
    // MARK: - JSExpr Tests
    
    func testJSExprRendering() {
        let expr = JSExpr("myVar")
        XCTAssertEqual(expr.render(), "myVar")
    }
    
    // MARK: - Helper Function Tests
    
    func testConstDeclaration() {
        let stmt = const("myVar", .string("value"))
        XCTAssertEqual(stmt.render(), "const myVar = 'value';")
    }
    
    func testLetDeclaration() {
        let stmt = let_("count", .int(0))
        XCTAssertEqual(stmt.render(), "let count = 0;")
    }
    
    func testVarDeclaration() {
        let stmt = var_("oldStyle", .bool(true))
        XCTAssertEqual(stmt.render(), "var oldStyle = true;")
    }
    
    func testReturnStatement() {
        let stmt = `return`(.int(42))
        XCTAssertEqual(stmt.render(), "return 42;")
    }
    
    func testReturnVoid() {
        let stmt = `return`()
        XCTAssertEqual(stmt.render(), "return;")
    }
    
    // MARK: - JSFunc Tests
    
    func testSimpleFunction() {
        let func_ = JSFunc("greet") {
            JSRaw("console.log('Hello')")
        }
        
        let result = func_.render()
        XCTAssertTrue(result.contains("function greet() {"))
        XCTAssertTrue(result.contains("console.log('Hello')"))
        XCTAssertTrue(result.contains("}"))
    }
    
    func testFunctionWithParameters() {
        let func_ = JSFunc("add", params: ["a", "b"]) {
            `return`(.raw("a + b"))
        }
        
        let result = func_.render()
        XCTAssertTrue(result.contains("function add(a, b) {"))
        XCTAssertTrue(result.contains("return a + b;"))
    }
    
    func testAsyncFunction() {
        let func_ = JSFunc("fetchData", async: true) {
            JSRaw("const data = await fetch('/api')")
            `return`(.raw("data"))
        }
        
        let result = func_.render()
        XCTAssertTrue(result.contains("async function fetchData() {"))
    }
    
    // MARK: - JSRaw Tests
    
    func testRawJavaScript() {
        let raw = JSRaw("console.log('Hello, World!');")
        XCTAssertEqual(raw.render(), "console.log('Hello, World!');")
    }
    
    func testMultilineRaw() {
        let raw = JSRaw("""
        if (x > 0) {
            console.log('Positive');
        }
        """)
        
        let result = raw.render()
        XCTAssertTrue(result.contains("if (x > 0)"))
        XCTAssertTrue(result.contains("console.log('Positive')"))
    }
    
    // MARK: - Script Element Tests
    
    func testScriptWithString() {
        let script = script("console.log('test');")
        let result = script.render()
        XCTAssertTrue(result.contains("<script>"))
        XCTAssertTrue(result.contains("console.log('test');"))
        XCTAssertTrue(result.contains("</script>"))
    }
    
    func testScriptWithBuilder() {
        let script = script {
            const("x", .int(10))
            JSRaw("console.log(x);")
        }
        
        let result = script.render()
        XCTAssertTrue(result.contains("<script>"))
        XCTAssertTrue(result.contains("const x = 10;"))
        XCTAssertTrue(result.contains("console.log(x);"))
        XCTAssertTrue(result.contains("</script>"))
    }
    
    // MARK: - Integration Tests
    
    func testCompleteJavaScriptBlock() {
        let script = script {
            let_("count", .int(0))
            const("btn", .raw("document.getElementById('btn')"))
            
            JSRaw("""
            btn.addEventListener('click', () => {
                count++;
                console.log('Count:', count);
            });
            """)
        }
        
        let result = script.render()
        XCTAssertTrue(result.contains("let count = 0;"))
        XCTAssertTrue(result.contains("const btn = document.getElementById('btn');"))
        XCTAssertTrue(result.contains("addEventListener"))
    }
    
    func testFunctionDefinitionInScript() {
        let script = script {
            JSFunc("handleClick", params: ["event"]) {
                JSRaw("event.preventDefault()")
                const("target", .raw("event.target"))
                JSRaw("console.log('Clicked:', target)")
            }
            
            JSRaw("document.addEventListener('click', handleClick);")
        }
        
        let result = script.render()
        XCTAssertTrue(result.contains("function handleClick(event) {"))
        XCTAssertTrue(result.contains("event.preventDefault()"))
        XCTAssertTrue(result.contains("const target = event.target;"))
    }
}
