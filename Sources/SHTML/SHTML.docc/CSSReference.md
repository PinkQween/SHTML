# Complete CSS Reference

A comprehensive guide to all CSS properties available in SHTML with type-safe lengths.

## Border Radius

### Simple Border Radius

```swift
CSSRule(".card") {
    borderRadius(12.px)  // All corners
}

CSSRule(".button") {
    borderRadius(8.px)
}
```

### Individual Corner Radius

```swift
CSSRule(".top-rounded") {
    borderTopLeftRadius(16.px)
    borderTopRightRadius(16.px)
    borderBottomLeftRadius(0.px)
    borderBottomRightRadius(0.px)
}

// Or use the compound function
CSSRule(".custom-corners") {
    borderRadius(
        topLeft: 20.px,
        topRight: 10.px,
        bottomRight: 20.px,
        bottomLeft: 10.px
    )
}
```

### Pill-Shaped Elements

```swift
CSSRule(".pill") {
    borderRadius(9999.px)  // Creates perfect pill shape
    padding(10.px, 20.px)
}
```

## Spacing with Type-Safe Units

### Margin

```swift
CSSRule(".box") {
    // All sides
    margin(20.px)
    
    // Individual sides
    marginTop(10.px)
    marginRight(20.px)
    marginBottom(10.px)
    marginLeft(20.px)
    
    // Using different units
    marginTop(2.rem)
    marginBottom(5.percent)
}
```

### Padding

```swift
CSSRule(".container") {
    padding(40.px)           // All sides
    paddingTop(20.px)        // Individual sides
    paddingBottom(2.rem)     // Different units
}
```

## Sizing

### Width & Height

```swift
CSSRule(".full-screen") {
    width(100.vw)
    height(100.vh)
}

CSSRule(".centered-box") {
    width(500.px)
    height(300.px)
    maxWidth(90.percent)     // Responsive
}

CSSRule(".responsive") {
    minWidth(200.px)
    maxWidth(800.px)
    minHeight(400.px)
}
```

## Complete Border Control

```swift
CSSRule(".bordered-card") {
    border("2px solid #e0e0e0")
    borderRadius(12.px)
    
    // Or more specific
    borderWidth(2.px)
    borderColor("#e0e0e0")
    borderStyle("solid")
}

CSSRule(".top-border-only") {
    borderTop("3px solid #007AFF")
}

CSSRule(".fancy-border") {
    borderTopLeftRadius(20.px)
    borderTopRightRadius(20.px)
    borderBottomLeftRadius(5.px)
    borderBottomRightRadius(5.px)
    borderWidth(2.px)
    borderColor("#007AFF")
}
```

## Typography

```swift
CSSRule(".heading") {
    fontSize(32.px)
    fontWeight("bold")
    fontFamily("system-ui, -apple-system, sans-serif")
    lineHeight(1.4.em)
    letterSpacing(0.5.px)
    textAlign("center")
}

CSSRule(".body-text") {
    fontSize(16.px)
    lineHeight(1.6.em)
    wordSpacing(2.px)
    textTransform("none")
    whiteSpace("normal")
}
```

## Flexbox Layout

```swift
CSSRule(".flex-container") {
    display("flex")
    flexDirection("row")
    justifyContent("space-between")
    alignItems("center")
    gap(20.px)
    flexWrap("wrap")
}

CSSRule(".flex-item") {
    flexGrow(1)
    flexShrink(0)
    flexBasis(200.px)
}

CSSRule(".column-layout") {
    display("flex")
    flexDirection("column")
    rowGap(16.px)
    columnGap(24.px)
}
```

## Grid Layout

```swift
CSSRule(".grid-container") {
    display("grid")
    gridTemplateColumns("repeat(3, 1fr)")
    gridTemplateRows("auto")
    gap(20.px)
    rowGap(30.px)
    columnGap(15.px)
}

CSSRule(".grid-item-span") {
    gridColumn("1 / 3")  // Span 2 columns
    gridRow("1 / 2")
}
```

## Positioning

```swift
CSSRule(".absolute-centered") {
    position("absolute")
    top(50.percent)
    left(50.percent)
    transform("translate(-50%, -50%)")
}

CSSRule(".sticky-header") {
    position("sticky")
    top(0.px)
    zIndex(100)
}

CSSRule(".fixed-bottom") {
    position("fixed")
    bottom(20.px)
    right(20.px)
}
```

## Visual Effects

### Shadows

```swift
CSSRule(".card-shadow") {
    boxShadow("0 4px 12px rgba(0, 0, 0, 0.1)")
}

CSSRule(".elevated-card") {
    boxShadow("0 10px 30px rgba(0, 0, 0, 0.15)")
}

CSSRule(".text-with-shadow") {
    textShadow("2px 2px 4px rgba(0, 0, 0, 0.3)")
}
```

### Opacity & Overflow

```swift
CSSRule(".semi-transparent") {
    opacity(0.8)
}

CSSRule(".scrollable") {
    overflow("auto")
    maxHeight(400.px)
}

CSSRule(".hidden-overflow") {
    overflowX("hidden")
    overflowY("scroll")
}
```

### Filters

```swift
CSSRule(".blurred-background") {
    backdropFilter("blur(10px)")
    background("rgba(255, 255, 255, 0.8)")
}

CSSRule(".grayscale-image") {
    filter("grayscale(100%)")
}

CSSRule(".glassy") {
    backdropFilter("blur(20px) saturate(180%)")
}
```

## Transforms & Transitions

### Transforms

```swift
CSSRule(".rotated") {
    transform("rotate(45deg)")
}

CSSRule(".scaled") {
    transform("scale(1.1)")
}

CSSRule(".moved") {
    transform("translateX(20px) translateY(-10px)")
}

CSSRule(".3d-card") {
    transform("perspective(1000px) rotateY(10deg)")
    transformOrigin("center center")
}
```

### Transitions

```swift
CSSRule(".smooth-transition") {
    transition("all 0.3s ease")
}

CSSRule(".button-hover") {
    transitionProperty("background-color, transform")
    transitionDuration("0.2s")
    transitionTimingFunction("ease-in-out")
}

CSSRule(".delayed-fade") {
    transition("opacity 0.5s ease")
    transitionDelay("0.1s")
}
```

### Animations

```swift
CSSRule(".animated") {
    animationName("fadeIn")
    animationDuration("0.5s")
    animationTimingFunction("ease-out")
    animationFillMode("forwards")
}

CSSRule(".infinite-spin") {
    animation("spin 2s linear infinite")
}

CSSRule(".bounce") {
    animationName("bounce")
    animationDuration("1s")
    animationIterationCount("infinite")
    animationDirection("alternate")
}
```

## Complete Example: Modern Card

```swift
Style {
    CSSRule(".modern-card") {
        // Layout
        display("flex")
        flexDirection("column")
        gap(16.px)
        
        // Sizing
        width(100.percent)
        maxWidth(400.px)
        minHeight(200.px)
        
        // Spacing
        padding(24.px)
        margin(20.px)
        
        // Visual
        background("white")
        borderRadius(16.px)
        boxShadow("0 4px 20px rgba(0, 0, 0, 0.08)")
        
        // Border
        borderWidth(1.px)
        borderColor("rgba(0, 0, 0, 0.05)")
        borderStyle("solid")
        
        // Effects
        transition("all 0.3s ease")
        cursor("pointer")
    }
    
    CSSRule(".modern-card:hover") {
        transform("translateY(-4px)")
        boxShadow("0 8px 30px rgba(0, 0, 0, 0.12)")
    }
    
    CSSRule(".card-header") {
        fontSize(24.px)
        fontWeight("600")
        lineHeight(1.3.em)
        marginBottom(12.px)
    }
    
    CSSRule(".card-body") {
        fontSize(16.px)
        lineHeight(1.6.em)
        color("#666")
        flexGrow(1)
    }
    
    CSSRule(".card-footer") {
        marginTop(16.px)
        paddingTop(16.px)
        borderTop("1px solid rgba(0, 0, 0, 0.1)")
        display("flex")
        justifyContent("space-between")
        alignItems("center")
    }
}
```

## Complete Example: Responsive Layout

```swift
Style {
    // Container
    CSSRule(".container") {
        width(100.percent)
        maxWidth(1200.px)
        margin(0.px)  // Can use 0 or 0.px
        padding(0.px, 20.px)
        boxSizing("border-box")
    }
    
    // Grid
    CSSRule(".grid") {
        display("grid")
        gridTemplateColumns("repeat(auto-fit, minmax(300px, 1fr))")
        gap(24.px)
        rowGap(32.px)
        columnGap(24.px)
    }
    
    // Card
    CSSRule(".grid-item") {
        background("white")
        borderRadius(12.px)
        padding(20.px)
        boxShadow("0 2px 8px rgba(0, 0, 0, 0.1)")
        
        // Transitions
        transition("all 0.2s ease")
    }
    
    CSSRule(".grid-item:hover") {
        transform("scale(1.02)")
        boxShadow("0 4px 16px rgba(0, 0, 0, 0.15)")
    }
    
    // Media Queries
    CSSMediaQuery("(max-width: 768px)") {
        CSSRule(".container") {
            padding(0.px, 15.px)
        }
        
        CSSRule(".grid") {
            gap(16.px)
        }
    }
}
```

## Tips

1. **Use type-safe lengths everywhere** - `20.px` instead of `"20px"`
2. **Mix units appropriately**:
   - `px` for precise control
   - `rem`/`em` for scalable typography
   - `percent` for responsive sizing
   - `vh`/`vw` for viewport-relative layouts
3. **Leverage compound functions** - Like `borderRadius(topLeft:topRight:bottomRight:bottomLeft:)`
4. **Use transitions for smooth interactions** - Makes UI feel more polished
5. **Combine properties** - Use flexbox/grid for layouts, not absolute positioning
6. **Consider accessibility** - Use sufficient contrast, focus states, etc.
