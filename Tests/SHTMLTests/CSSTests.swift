import XCTest
@testable import SHTML

/// Tests for the CSS generation system
final class CSSTests: XCTestCase {
    
    // MARK: - CSS Rule Tests
    
    func testSimpleCSSRule() {
        let rule = CSSRule("body") {
            margin("0")
            padding("0")
        }
        
        let result = rule.render()
        XCTAssertTrue(result.contains("body {"))
        XCTAssertTrue(result.contains("margin: 0;"))
        XCTAssertTrue(result.contains("padding: 0;"))
        XCTAssertTrue(result.contains("}"))
    }
    
    func testCSSRuleWithMultipleProperties() {
        let rule = CSSRule(".container") {
            display("flex")
            flexDirection("column")
            alignItems("center")
            gap("20px")
        }
        
        let result = rule.render()
        XCTAssertTrue(result.contains(".container {"))
        XCTAssertTrue(result.contains("display: flex;"))
        XCTAssertTrue(result.contains("flex-direction: column;"))
        XCTAssertTrue(result.contains("align-items: center;"))
        XCTAssertTrue(result.contains("gap: 20px;"))
    }
    
    // MARK: - CSS Property Tests
    
    func testCSSProperty() {
        let prop = CSSProperty("color", "#333")
        XCTAssertEqual(prop.render(), "color: #333;")
    }
    
    // MARK: - CSS Helper Functions
    
    func testMarginHelper() {
        let prop = margin("10px")
        XCTAssertEqual(prop.render(), "margin: 10px;")
    }
    
    func testPaddingHelper() {
        let prop = padding("20px 10px")
        XCTAssertEqual(prop.render(), "padding: 20px 10px;")
    }
    
    func testBackgroundHelper() {
        let prop = background("#f0f0f0")
        XCTAssertEqual(prop.render(), "background: #f0f0f0;")
    }

    func testTypedLinearGradientBackgroundHelper() {
        let gradient = LinearGradient(
            direction: .angle(135.deg),
            GradientStop(.hex("667eea")),
            GradientStop(.hex("764ba2"))
        )
        let prop = background(gradient)
        XCTAssertEqual(prop.render(), "background: linear-gradient(135deg, #667eea, #764ba2);")
    }

    func testTypedLinearGradientBackgroundImageHelper() {
        let gradient = LinearGradient(
            direction: .toBottom,
            GradientStop(.red, at: 0.percent),
            GradientStop(.blue, at: 100.percent)
        )
        let prop = backgroundImage(gradient)
        XCTAssertEqual(prop.render(), "background-image: linear-gradient(to bottom, red 0%, blue 100%);")
    }
    
    func testColorHelper() {
        let prop = color("#333")
        XCTAssertEqual(prop.render(), "color: #333;")
    }

    func testColorHelperWithTypedColor() {
        let prop = color(.red)
        XCTAssertEqual(prop.render(), "color: red;")
    }

    func testBorderColorHelperWithTypedColor() {
        let prop = borderColor(.blue)
        XCTAssertEqual(prop.render(), "border-color: blue;")
    }

    func testOutlineColorHelperWithTypedColor() {
        let prop = outlineColor(.green)
        XCTAssertEqual(prop.render(), "outline-color: green;")
    }
    
    func testFontSizeHelper() {
        let prop = fontSize("16px")
        XCTAssertEqual(prop.render(), "font-size: 16px;")
    }
    
    func testFontFamilyHelper() {
        let prop = fontFamily("Arial, sans-serif")
        XCTAssertEqual(prop.render(), "font-family: Arial, sans-serif;")
    }

    func testTypedFontFamilyHelper() {
        let prop = fontFamily(.named("Inter", fallbacks: .sansSerif))
        XCTAssertEqual(prop.render(), "font-family: Inter, sans-serif;")
    }

    func testTypedTextDecorationHelper() {
        let prop = textDecoration(.underline)
        XCTAssertEqual(prop.render(), "text-decoration: underline;")
    }

    func testTypedTextTransformHelper() {
        let prop = textTransform(.uppercase)
        XCTAssertEqual(prop.render(), "text-transform: uppercase;")
    }
    
    // MARK: - CSS Keyframes Tests
    
    func testCSSKeyframes() {
        let keyframes = CSSKeyframes("fadeIn") {
            CSSKeyframe(.from) {
                opacity(0)
            }
            CSSKeyframe(.to) {
                opacity(1)
            }
        }
        
        let result = keyframes.render()
        XCTAssertTrue(result.contains("@keyframes fadeIn {"))
        XCTAssertTrue(result.contains("from {"))
        XCTAssertTrue(result.contains("opacity: 0;"))
        XCTAssertTrue(result.contains("to {"))
        XCTAssertTrue(result.contains("opacity: 1;"))
    }
    
    func testKeyframeWithPercentage() {
        let keyframe = CSSKeyframe(.percent(50)) {
            transform("scale(1.2)")
        }
        
        let result = keyframe.render()
        XCTAssertTrue(result.contains("50% {"))
        XCTAssertTrue(result.contains("transform: scale(1.2);"))
    }
    
    // MARK: - Style Element Tests
    
    func testStyleElement() {
        let style = Style {
            CSSRule("body") {
                margin("0")
                padding("0")
            }
        }
        
        let result = style.render()
        XCTAssertTrue(result.contains("<style>"))
        XCTAssertTrue(result.contains("body {"))
        XCTAssertTrue(result.contains("margin: 0;"))
        XCTAssertTrue(result.contains("</style>"))
    }
    
    func testCompleteStylesheet() {
        let style = Style {
            CSSRule("*") {
                margin("0")
                padding("0")
                boxSizing("border-box")
            }
            
            CSSRule("body") {
                fontFamily("-apple-system, sans-serif")
                background("linear-gradient(135deg, #667eea, #764ba2)")
            }
            
            CSSKeyframes("fadeIn") {
                CSSKeyframe("from") {
                    opacity(0)
                    transform("translateY(10px)")
                }
                CSSKeyframe("to") {
                    opacity(1)
                    transform("translateY(0)")
                }
            }
        }
        
        let result = style.render()
        XCTAssertTrue(result.contains("* {"))
        XCTAssertTrue(result.contains("body {"))
        XCTAssertTrue(result.contains("@keyframes fadeIn {"))
        XCTAssertTrue(result.contains("box-sizing: border-box;"))
    }
    
    // MARK: - Complex CSS Properties
    
    func testBoxShadow() {
        let prop = boxShadow("0 4px 6px rgba(0,0,0,0.1)")
        XCTAssertEqual(prop.render(), "box-shadow: 0 4px 6px rgba(0,0,0,0.1);")
    }
    
    func testTransform() {
        let prop = transform("rotate(45deg)")
        XCTAssertEqual(prop.render(), "transform: rotate(45deg);")
    }

    func testTypedTransform() {
        let prop = transform(
            .translateX(12.px),
            .rotate(45.deg),
            .scale(1.1)
        )
        XCTAssertEqual(prop.render(), "transform: translateX(12px) rotate(45deg) scale(1.1);")
    }

    func testTransitionPropertyTyped() {
        let prop = transitionProperty(.transform)
        XCTAssertEqual(prop.render(), "transition-property: transform;")
    }
    
    func testAnimation() {
        let prop = animation("fadeIn 0.3s ease-in-out")
        XCTAssertEqual(prop.render(), "animation: fadeIn 0.3s ease-in-out;")
    }
    
    func testTransition() {
        let prop = transition("all 0.3s ease")
        XCTAssertEqual(prop.render(), "transition: all 0.3s ease;")
    }
    
    // MARK: - Layout Properties
    
    func testDisplay() {
        let prop = display("flex")
        XCTAssertEqual(prop.render(), "display: flex;")
    }
    
    func testFlexDirection() {
        let prop = flexDirection("column")
        XCTAssertEqual(prop.render(), "flex-direction: column;")
    }
    
    func testJustifyContent() {
        let prop = justifyContent("space-between")
        XCTAssertEqual(prop.render(), "justify-content: space-between;")
    }
    
    func testAlignItems() {
        let prop = alignItems("center")
        XCTAssertEqual(prop.render(), "align-items: center;")
    }
}
