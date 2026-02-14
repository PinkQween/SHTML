import XCTest
@testable import SHTML

/// Tests for the modifier system
final class ModifierTests: XCTestCase {
    
    // MARK: - Basic Modifiers
    
    func testClassModifier() {
        let div = Div { "Content" }.class("container")
        XCTAssertTrue(div.render().contains("class=\"container\""))
    }
    
    func testIdModifier() {
        let div = Div { "Content" }.id("main")
        XCTAssertTrue(div.render().contains("id=\"main\""))
    }
    
    // MARK: - Style Modifiers
    
    func testPaddingModifier() {
        let div = Div { "Content" }.padding("20px")
        XCTAssertTrue(div.render().contains("padding: 20px"))
    }
    
    func testPaddingWithSides() {
        let div = Div { "Content" }.padding(top: "10px", right: "20px")
        let result = div.render()
        XCTAssertTrue(result.contains("padding-top: 10px"))
        XCTAssertTrue(result.contains("padding-right: 20px"))
    }
    
    func testMarginModifier() {
        let div = Div { "Content" }.margin("15px")
        XCTAssertTrue(div.render().contains("margin: 15px"))
    }
    
    func testMarginWithSides() {
        let div = Div { "Content" }.margin(bottom: "30px")
        XCTAssertTrue(div.render().contains("margin-bottom: 30px"))
    }
    
    func testBackgroundColor() {
        let div = Div { "Content" }.background("#f0f0f0")
        XCTAssertTrue(div.render().contains("background: #f0f0f0"))
    }
    
    func testForegroundColor() {
        let div = Div { "Content" }.foregroundColor("#333")
        XCTAssertTrue(div.render().contains("color: #333"))
    }

    func testColorModifier() {
        let div = Div { "Content" }.color(.red)
        XCTAssertTrue(div.render().contains("color: red"))
    }

    func testBackgroundColorModifier() {
        let div = Div { "Content" }.backgroundColor(.blue)
        XCTAssertTrue(div.render().contains("background-color: blue"))
    }

    func testTypedLinearGradientBackgroundModifier() {
        let gradient = LinearGradient(
            direction: .toRight,
            GradientStop(.red),
            GradientStop(.blue)
        )
        let div = Div { "Content" }.background(gradient)
        XCTAssertTrue(div.render().contains("background: linear-gradient(to right, red, blue)"))
    }
    
    func testFontSize() {
        let div = Div { "Content" }.fontSize("18px")
        XCTAssertTrue(div.render().contains("font-size: 18px"))
    }
    
    func testFontWeight() {
        let div = Div { "Content" }.fontWeight("bold")
        XCTAssertTrue(div.render().contains("font-weight: bold"))
    }

    func testTypedFontFamilyModifier() {
        let div = Div { "Content" }.fontFamily(.named("JetBrains Mono", fallbacks: .monospace))
        XCTAssertTrue(div.render().contains("font-family: 'JetBrains Mono', monospace"))
    }

    func testTextDecoration() {
        let div = Div { "Content" }.textDecoration("underline")
        XCTAssertTrue(div.render().contains("text-decoration: underline"))
    }

    func testTypedTextDecoration() {
        let div = Div { "Content" }.textDecoration(.lineThrough)
        XCTAssertTrue(div.render().contains("text-decoration: line-through"))
    }

    func testTextTransform() {
        let div = Div { "Content" }.textTransform("uppercase")
        XCTAssertTrue(div.render().contains("text-transform: uppercase"))
    }

    func testTypedTextTransform() {
        let div = Div { "Content" }.textTransform(.capitalize)
        XCTAssertTrue(div.render().contains("text-transform: capitalize"))
    }
    
    func testCornerRadius() {
        let div = Div { "Content" }.cornerRadius("10px")
        XCTAssertTrue(div.render().contains("border-radius: 10px"))
    }

    func testCornerRadiusSpecificCorners() {
        let div = Div { "Content" }.cornerRadius([.topLeft, .bottomRight], 12.px)
        let result = div.render()
        XCTAssertTrue(result.contains("border-top-left-radius: 12px"))
        XCTAssertTrue(result.contains("border-bottom-right-radius: 12px"))
    }

    func testBorderRadiusPerCornerValues() {
        let div = Div { "Content" }
            .borderRadius(topLeft: 4.px, topRight: 8.px, bottomRight: 12.px, bottomLeft: 16.px)
        XCTAssertTrue(div.render().contains("border-radius: 4px 8px 12px 16px"))
    }
    
    func testShadow() {
        let div = Div { "Content" }.shadow(x: "0", y: "5px", blur: "10px", color: "rgba(0,0,0,0.2)")
        XCTAssertTrue(div.render().contains("box-shadow: 0 5px 10px rgba(0,0,0,0.2)"))
    }
    
    // MARK: - Layout Modifiers
    
    func testWidth() {
        let div = Div { "Content" }.frame(width: "100%")
        XCTAssertTrue(div.render().contains("width: 100%"))
    }
    
    func testHeight() {
        let div = Div { "Content" }.frame(height: "200px")
        XCTAssertTrue(div.render().contains("height: 200px"))
    }
    
    func testFrame() {
        let div = Div { "Content" }.frame(width: "300px", height: "150px")
        let result = div.render()
        XCTAssertTrue(result.contains("width: 300px"))
        XCTAssertTrue(result.contains("height: 150px"))
    }
    
    func testFrameWithMinMax() {
        let div = Div { "Content" }.frame(maxWidth: "200px", minHeight: "500px")
        let result = div.render()
        XCTAssertTrue(result.contains("max-width: 200px"))
        XCTAssertTrue(result.contains("min-height: 500px"))
    }
    
    // MARK: - Display Modifiers
    
    func testDisplay() {
        let div = Div { "Content" }.display("flex")
        XCTAssertTrue(div.render().contains("display: flex"))
    }
    
    func testFlexDirection() {
        let div = Div { "Content" }.flexDirection("column")
        XCTAssertTrue(div.render().contains("flex-direction: column"))
    }
    
    func testJustifyContent() {
        let div = Div { "Content" }.justifyContent("center")
        XCTAssertTrue(div.render().contains("justify-content: center"))
    }
    
    func testAlignItems() {
        let div = Div { "Content" }.alignItems("center")
        XCTAssertTrue(div.render().contains("align-items: center"))
    }
    
    func testGap() {
        let div = Div { "Content" }.gap("20px")
        XCTAssertTrue(div.render().contains("gap: 20px"))
    }

    func testOverflowTyped() {
        let div = Div { "Content" }.overflow(.scroll)
        XCTAssertTrue(div.render().contains("overflow: scroll"))
    }

    func testFlexShrinkModifier() {
        let div = Div { "Content" }.flexShrink(0)
        XCTAssertTrue(div.render().contains("flex-shrink: 0"))
    }

    func testVStackBackgroundAfterOverflowKeepsValidStyleSeparator() {
        let stack = VStack {
            "Item"
        }
        .overflow(.scroll)
        .background(.red)

        let result = stack.render()
        XCTAssertTrue(result.contains("overflow: scroll; background: red"))
    }
    
    // MARK: - Modifier Chaining
    
    func testModifierChaining() {
        let div = Div { "Content" }
            .padding("20px")
            .margin("10px")
            .background("#fff")
            .cornerRadius("8px")
        
        let result = div.render()
        XCTAssertTrue(result.contains("padding: 20px"))
        XCTAssertTrue(result.contains("margin: 10px"))
        XCTAssertTrue(result.contains("background: #fff"))
        XCTAssertTrue(result.contains("border-radius: 8px"))
    }
    
    func testComplexModifierChain() {
        let card = Div {
            h2 { "Card Title" }
            p { "Description" }
        }
        .background("white")
        .padding("30px")
        .cornerRadius("12px")
        .shadow(y: "5px", blur: "15px", color: "rgba(0,0,0,0.1)")
        .margin(bottom: "20px")
        
        let result = card.render()
        XCTAssertTrue(result.contains("background: white"))
        XCTAssertTrue(result.contains("padding: 30px"))
        XCTAssertTrue(result.contains("border-radius: 12px"))
        XCTAssertTrue(result.contains("box-shadow:"))
        XCTAssertTrue(result.contains("margin-bottom: 20px"))
    }
    
    // MARK: - Border Modifiers
    
    func testBorder() {
        let div = Div { "Content" }.border(width: "1px", style: "solid", color: "#ccc")
        XCTAssertTrue(div.render().contains("border: 1px solid #ccc"))
    }
    
    // MARK: - Transition Modifiers
    
    func testTransition() {
        let div = Div { "Content" }.transition()
        XCTAssertTrue(div.render().contains("transition: all 0.3s"))
    }
    
    func testCustomTransition() {
        let div = Div { "Content" }.transition("opacity 0.5s ease")
        XCTAssertTrue(div.render().contains("transition: opacity 0.5s ease"))
    }

    func testTypedTransformModifier() {
        let div = Div { "Content" }.transform(.translateY(8.px), .scale(1.02))
        XCTAssertTrue(div.render().contains("transform: translateY(8px) scale(1.02)"))
    }

    func testCSSBridgeSingleProperty() {
        let div = Div { "Content" }.css(textDecoration(.none))
        XCTAssertTrue(div.render().contains("text-decoration: none"))
    }

    func testCSSBridgePropertyGroup() {
        let div = Div { "Content" }.css(margin(.horizontal, 12.px))
        let result = div.render()
        XCTAssertTrue(result.contains("margin-left: 12px"))
        XCTAssertTrue(result.contains("margin-right: 12px"))
    }

    // MARK: - Gesture Modifiers

    func testOnTapGestureSingleTap() {
        let div = Div { "Tap" }.onTapGesture(perform: "handleTap()")
        XCTAssertTrue(div.render().contains("onclick=\"handleTap()\""))
    }

    func testOnClickWithTypedJavaScript() {
        let div = Div { "Tap" }.onclick(JS.console.log.call("clicked", JS.event.clientY))
        let result = div.render()
        XCTAssertTrue(result.contains("onclick=\"console.log(&#39;clicked&#39;, event.clientY)\""))
    }

    func testOnTapGestureDoubleTap() {
        let div = Div { "Tap" }.onTapGesture(count: 2, perform: "handleDoubleTap()")
        XCTAssertTrue(div.render().contains("ondblclick=\"handleDoubleTap()\""))
    }

    func testOnHoverGesture() {
        let div = Div { "Hover" }.onHover(enter: "handleEnter()", leave: "handleLeave()")
        let result = div.render()
        XCTAssertTrue(result.contains("onmouseenter=\"handleEnter()\""))
        XCTAssertTrue(result.contains("onmouseleave=\"handleLeave()\""))
    }

    func testOnHoverCSSModifier() {
        let div = Div { "Hover" }.onHoverCSS {
            textDecoration(.none)
            color(.white)
        }
        let result = div.render()
        XCTAssertTrue(result.contains("onmouseenter="))
        XCTAssertTrue(result.contains("onmouseleave="))
        XCTAssertTrue(result.contains("text-decoration: none; color: white"))
        XCTAssertTrue(result.contains("__shtmlHoverPrevStyle"))
    }

    func testOnDragGesture() {
        let div = Div { "Drag" }.onDragGesture(onChanged: "handleDrag()", onEnded: "handleDragEnd()")
        let result = div.render()
        XCTAssertTrue(result.contains("onpointerdown="))
        XCTAssertTrue(result.contains("onpointermove="))
        XCTAssertTrue(result.contains("onpointerup="))
        XCTAssertTrue(result.contains("handleDrag()"))
        XCTAssertTrue(result.contains("handleDragEnd()"))
    }

    func testOnDragGestureWithJavaScriptType() {
        let framework = JSExpr("framework")
        let div = Div { "Drag" }.onDragGesture(
            onChanged: framework.dragMove(.expr(JSExpr("event"))),
            onEnded: framework.dragEnd(.expr(JSExpr("event")))
        )
        let result = div.render()
        XCTAssertTrue(result.contains("onpointermove="))
        XCTAssertTrue(result.contains("framework.dragMove(event)"))
        XCTAssertTrue(result.contains("framework.dragEnd(event)"))
    }

    func testOnLongPressGesture() {
        let div = Div { "Press" }.onLongPressGesture(minimumDuration: 1.2, perform: "handleLongPress()")
        let result = div.render()
        XCTAssertTrue(result.contains("onmousedown="))
        XCTAssertTrue(result.contains("onmouseup="))
        XCTAssertTrue(result.contains("ontouchstart="))
        XCTAssertTrue(result.contains("ontouchend="))
        XCTAssertTrue(result.contains("handleLongPress()"))
        XCTAssertTrue(result.contains("1200"))
    }

}
