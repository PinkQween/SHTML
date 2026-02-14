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

    func testTemplateLiteral() {
        let tpl = template(
            .text("rgb("),
            .value(JSExpr("r")),
            .text(", "),
            .value(JSExpr("g")),
            .text(", "),
            .value(JSExpr("b")),
            .text(")")
        )
        XCTAssertEqual(tpl.render(), "`rgb(${r}, ${g}, ${b})`")
    }
    
    // MARK: - JSExpr Tests
    
    func testJSExprRendering() {
        let expr = JSExpr("myVar")
        XCTAssertEqual(expr.render(), "myVar")
    }

    func testTypedThisAndEventExpressions() {
        let expr = JS.this.scrollTop.minus(JS.event.movementY)
        XCTAssertEqual(expr.render(), "(this.scrollTop - event.movementY)")
    }

    func testTypedAssignWithoutRawString() {
        let statement = JS.this.assign(
            "scrollTop",
            JS.this.scrollTop.minus(JS.event.movementY)
        )
        XCTAssertEqual(
            statement.render(),
            "this.scrollTop = (this.scrollTop - event.movementY);"
        )
    }

    func testSetOnExpression() {
        let statement = JS.this.scrollTop.set(
            JS.this.scrollTop - JS.event.movementY
        )
        XCTAssertEqual(
            statement.render(),
            "this.scrollTop = (this.scrollTop - event.movementY);"
        )
    }

    func testCallWithSwiftValues() {
        let expr = JS.console.log.call("drag y", JS.event.clientY)
        XCTAssertEqual(expr.render(), "console.log('drag y', event.clientY)")
    }

    func testDocumentGetElementByIdWithStringCallSyntax() {
        let expr = JS.document.getElementById("id")
        XCTAssertEqual(expr.render(), "document.getElementById('id')")
    }

    func testGlobalDocumentAliasGetElementById() {
        let expr = document.getElementById("id")
        XCTAssertEqual(expr.render(), "document.getElementById('id')")
    }

    func testTypedBackgroundColorAssignment() {
        let statement = JS.document
            .getElementById("id")
            .style
            .background
            .set(.red)
        XCTAssertEqual(
            statement.render(),
            "document.getElementById('id').style.background = 'red';"
        )
    }

    func testTypedSetStyleHelper() {
        let statement = JS.document
            .getElementById("id")
            .setStyle(.background, .red)
        XCTAssertEqual(
            statement.render(),
            "document.getElementById('id').style.background = 'red';"
        )
    }

    func testSetStyleFromStoredJSExprVariable() {
        let swiftVarJSId = document.getElementById("id")
        let statement = swiftVarJSId.setStyle(.background, .red)
        XCTAssertEqual(
            statement.render(),
            "document.getElementById('id').style.background = 'red';"
        )
    }

    func testTypedSetStyleWithStringValue() {
        let statement = JS.document
            .getElementById("id")
            .setStyle(.display, "flex")
        XCTAssertEqual(
            statement.render(),
            "document.getElementById('id').style.display = 'flex';"
        )
    }

    func testTypedSetStyleWithDisplayEnum() {
        let statement = JS.document
            .getElementById("id")
            .setStyle(.display, .flex)
        XCTAssertEqual(
            statement.render(),
            "document.getElementById('id').style.display = 'flex';"
        )
    }

    func testRemoveStyleHelper() {
        let statement = JS.document
            .getElementById("id")
            .removeStyle(.background)
        XCTAssertEqual(
            statement.render(),
            "document.getElementById('id').style.background = '';"
        )
    }

    func testLegacyJSSetStyleTypedProperty() {
        let statement = JSSetStyle(
            element: "document.getElementById('id')",
            property: .background,
            color: .red
        )
        XCTAssertEqual(
            statement.render(),
            "document.getElementById('id').style.background = 'red';"
        )
    }

    func testJSGetElementByIdSetStyleChaining() {
        let bg = JSGetElementById("bg")
        let color = JS.routeParam("id")
        let statement = bg.setStyle(.background, color)
        XCTAssertEqual(
            statement.render(),
            "document.getElementById('bg').style.background = window.routeParams['id'];"
        )
    }

    func testStandardGlobalAliases() {
        XCTAssertEqual(JS.globalThis.render(), "globalThis")
        XCTAssertEqual(JS.navigator.render(), "navigator")
        XCTAssertEqual(JS.history.render(), "history")
        XCTAssertEqual(JS.location.render(), "location")
        XCTAssertEqual(JS.performance.render(), "performance")
        XCTAssertEqual(JS.math.render(), "Math")
        XCTAssertEqual(JS.json.render(), "JSON")
        XCTAssertEqual(JS.fetch.render(), "fetch")
    }

    func testFetchHelpers() {
        XCTAssertEqual(JS.fetch("/api").render(), "fetch('/api')")
        XCTAssertEqual(
            JS.fetch("/api", options: JSExpr("{ method: 'POST' }")).render(),
            "fetch('/api', { method: 'POST' })"
        )
    }

    func testMathHelpers() {
        XCTAssertEqual(JS.Math.PI.render(), "Math.PI")
        XCTAssertEqual(JS.Math.floor(3.9).render(), "Math.floor(3.9)")
        XCTAssertEqual(JS.Math.max(10, 20).render(), "Math.max(10, 20)")
        XCTAssertEqual(JS.Math.random().render(), "Math.random()")
    }

    func testQueryHelpers() {
        XCTAssertEqual(
            JS.document.querySelector("#app").render(),
            "document.querySelector('#app')"
        )
        XCTAssertEqual(
            JS.document.querySelectorAll(".item").render(),
            "document.querySelectorAll('.item')"
        )
    }

    func testClassListHelpers() {
        let add = JS.document.getElementById("id").classListAdd("active")
        let remove = JS.document.getElementById("id").classListRemove("active")
        let toggle = JS.document.getElementById("id").classListToggle("active")

        XCTAssertEqual(add.render(), "document.getElementById('id').classList.add('active');")
        XCTAssertEqual(remove.render(), "document.getElementById('id').classList.remove('active');")
        XCTAssertEqual(toggle.render(), "document.getElementById('id').classList.toggle('active');")
    }
    
    // MARK: - Helper Function Tests
    
    func testConstDeclaration() {
        let stmt = const("myVar", .string("value"))
        XCTAssertEqual(stmt.render(), "const myVar = 'value';")
    }

    func testConstDeclarationWithExpressibleValue() {
        let stmt = const("color", template(.text("#"), .value(255)))
        XCTAssertEqual(stmt.render(), "const color = `#${255}`;")
    }
    
    func testLetDeclaration() {
        let stmt = let_("count", .int(0))
        XCTAssertEqual(stmt.render(), "let count = 0;")
    }

    func testLetDeclarationWithExpressibleValue() {
        let stmt = let_("enabled", true)
        XCTAssertEqual(stmt.render(), "let enabled = true;")
    }
    
    func testVarDeclaration() {
        let stmt = var_("oldStyle", .bool(true))
        XCTAssertEqual(stmt.render(), "var oldStyle = true;")
    }

    func testVarDeclarationWithExpressibleValue() {
        let stmt = var_("message", "hello")
        XCTAssertEqual(stmt.render(), "var message = 'hello';")
    }

    func testLegacyJSConstTypedValue() {
        let stmt = JSConst("count", JSArg.int(5))
        XCTAssertEqual(stmt.render(), "const count = 5;")
    }

    func testLegacyJSConstExpressibleValue() {
        let stmt = JSConst("name", "alice")
        XCTAssertEqual(stmt.render(), "const name = alice;")
    }

    func testLegacyJSLetTypedValue() {
        let stmt = JSLet("enabled", JSArg.bool(true))
        XCTAssertEqual(stmt.render(), "let enabled = true;")
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

    func testJSFuncCallableFromSwiftDSL() {
        let updateBackground = JSFunc("UpdateBackground") {
            JSRaw("console.log('ok')")
        }
        XCTAssertEqual(updateBackground().render(), "UpdateBackground()")
    }

    func testAddEventListenerWithFunctionReference() {
        let updateBackground = JSFunc("UpdateBackground") {
            JSRaw("console.log('ok')")
        }
        let stmt = window.addEventListener("DOMContentLoaded", updateBackground)
        XCTAssertEqual(stmt.render(), "window.addEventListener('DOMContentLoaded', UpdateBackground);")
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
