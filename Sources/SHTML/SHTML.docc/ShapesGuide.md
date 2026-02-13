# Working with Shapes

Learn how to create vector graphics using SHTML's SVG shapes.

## Overview

SHTML provides SwiftUI-like shapes for creating scalable vector graphics (SVG). All shapes support common modifiers like `fill()`, `stroke()`, and `strokeWidth()`.

## Available Shapes

### Rectangle (Rect)

Create rectangles with optional rounded corners:

```swift
SVG(width: "200", height: "200") {
    Rect()
        .fill("#007AFF")
        .frame(width: "150", height: "100")
        .cornerRadius("10")
}
```

### Circle

Create perfect circles:

```swift
SVG(width: "200", height: "200") {
    Circle()
        .cx("100")
        .cy("100")
        .r("50")
        .fill("#FF3B30")
        .stroke("white")
        .strokeWidth("3")
}
```

### Polygon

Create custom polygons from points:

```swift
// Triangle
SVG(width: "200", height: "200") {
    Polygon(points: [(100, 20), (180, 180), (20, 180)])
        .fill("#34C759")
        .stroke("black")
        .strokeWidth("2")
}

// Star
SVG(width: "200", height: "200") {
    Polygon(points: [
        (100, 10), (120, 80), (190, 80),
        (130, 120), (150, 190), (100, 150),
        (50, 190), (70, 120), (10, 80), (80, 80)
    ])
    .fill("#FFD700")
    .stroke("#FF8C00")
    .strokeWidth("2")
}
```

### Path

Create custom shapes using SVG path data:

```swift
SVG(width: "200", height: "200") {
    Path(d: "M 10 80 Q 52.5 10, 95 80 T 180 80")
        .fill("none")
        .stroke("#007AFF")
        .strokeWidth("3")
        .strokeLinecap("round")
}
```

## Complete Examples

### Example 1: Icon Set

```swift
struct IconSet: HTML {
    var body: some HTML {
        html {
            head {
                Title("SVG Icons")
                Style {
                    CSSRule("body") {
                        background("#f5f5f5")
                        padding("40px")
                    }
                    CSSRule(".icon-grid") {
                        display("grid")
                        property("grid-template-columns", "repeat(auto-fit, 120px)")
                        gap("20px")
                    }
                    CSSRule(".icon-card") {
                        background("white")
                        padding("20px")
                        borderRadius("12px")
                        textAlign("center")
                    }
                }
            }
            body {
                h1 { "SVG Icon Set" }
                
                Div {
                    // Check icon
                    Div {
                        SVG(width: "80", height: "80", viewBox: "0 0 100 100") {
                            Circle()
                                .cx("50")
                                .cy("50")
                                .r("45")
                                .fill("#34C759")
                            
                            Path(d: "M 30 50 L 45 65 L 70 35")
                                .fill("none")
                                .stroke("white")
                                .strokeWidth("6")
                                .strokeLinecap("round")
                                .strokeLinejoin("round")
                        }
                        p { "Success" }
                    }
                    .class("icon-card")
                    
                    // Warning icon
                    Div {
                        SVG(width: "80", height: "80", viewBox: "0 0 100 100") {
                            Polygon(points: [(50, 10), (90, 90), (10, 90)])
                                .fill("#FFD60A")
                                .stroke("#FF9500")
                                .strokeWidth("3")
                            
                            Path(d: "M 50 30 L 50 55")
                                .stroke("black")
                                .strokeWidth("4")
                                .strokeLinecap("round")
                            
                            Circle()
                                .cx("50")
                                .cy("70")
                                .r("3")
                                .fill("black")
                        }
                        p { "Warning" }
                    }
                    .class("icon-card")
                    
                    // Error icon
                    Div {
                        SVG(width: "80", height: "80", viewBox: "0 0 100 100") {
                            Circle()
                                .cx("50")
                                .cy("50")
                                .r("45")
                                .fill("#FF3B30")
                            
                            Path(d: "M 30 30 L 70 70 M 70 30 L 30 70")
                                .stroke("white")
                                .strokeWidth("6")
                                .strokeLinecap("round")
                        }
                        p { "Error" }
                    }
                    .class("icon-card")
                }
                .class("icon-grid")
            }
        }
    }
}
```

### Example 2: Data Visualization

```swift
struct BarChart: HTML {
    let data: [Int] = [30, 60, 90, 45, 75]
    
    var body: some HTML {
        SVG(width: "400", height: "300", viewBox: "0 0 400 300") {
            // Background
            Rect()
                .fill("#f9f9f9")
                .frame(width: "400", height: "300")
            
            // Bars
            for (index, value) in data.enumerated() {
                let x = 50 + (index * 70)
                let height = value * 2
                let y = 250 - height
                
                Rect()
                    .fill("#007AFF")
                    .stroke("white")
                    .strokeWidth("2")
                    .cornerRadius("4")
                    .frame(width: "50", height: "\(height)")
                    // Note: x and y positioning would need CSS transforms or group elements
            }
        }
    }
}
```

### Example 3: Logo Design

```swift
struct Logo: HTML {
    var body: some HTML {
        SVG(width: "100", height: "100", viewBox: "0 0 100 100") {
            // Outer circle
            Circle()
                .cx("50")
                .cy("50")
                .r("45")
                .fill("linear-gradient(135deg, #667eea 0%, #764ba2 100%)")
            
            // Inner shape
            Path(d: "M 30 50 L 50 30 L 70 50 L 50 70 Z")
                .fill("white")
                .stroke("white")
                .strokeWidth("2")
        }
    }
}
```

## Common Modifiers

### Fill

Set the fill color of a shape:

```swift
Rect()
    .fill("#007AFF")              // Solid color
    .fill("transparent")           // No fill
    .fill("url(#gradient)")        // Gradient reference
```

### Stroke

Add an outline to shapes:

```swift
Circle()
    .stroke("#000000")             // Stroke color
    .strokeWidth("2")              // Stroke thickness
    .strokeLinecap("round")        // Line ending style
    .strokeLinejoin("round")       // Corner style
```

### Frame

Set dimensions for rectangles:

```swift
Rect()
    .frame(width: "200", height: "100")
```

### Corner Radius

Round the corners of rectangles:

```swift
Rect()
    .cornerRadius("12")
```

## Using Shapes in ZStack

Shapes work great with ZStack for layered graphics:

```swift
ZStack {
    // Background
    Rect()
        .fill("#f0f0f0")
        .frame(width: "100%", height: "200px")
    
    // SVG overlay
    SVG(width: "100", height: "100") {
        Circle()
            .cx("50")
            .cy("50")
            .r("40")
            .fill("#007AFF")
    }
}
```

## SVG Gradients

Define gradients within SVG:

```swift
SVG(width: "200", height: "200") {
    // Define gradient (using raw SVG)
    JSRaw("""
    <defs>
        <linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" style="stop-color:#667eea;stop-opacity:1" />
            <stop offset="100%" style="stop-color:#764ba2;stop-opacity:1" />
        </linearGradient>
    </defs>
    """)
    
    // Use gradient
    Rect()
        .fill("url(#grad1)")
        .frame(width: "180", height: "180")
        .cornerRadius("20")
}
```

## Tips

1. **Always wrap shapes in SVG** - Shapes must be inside an `SVG` container
2. **Use viewBox for scaling** - Set viewBox to make SVGs responsive
3. **Keep it simple** - Complex graphics can be hard to maintain
4. **Use CSS for interactivity** - Add hover effects and animations with CSS
5. **Consider performance** - Many complex shapes can slow rendering

## Responsive SVG

Make SVG scale with container:

```swift
SVG(width: "100%", height: "auto", viewBox: "0 0 100 100") {
    Circle()
        .cx("50")
        .cy("50")
        .r("40")
        .fill("#007AFF")
}
.preserveAspectRatio("xMidYMid meet")
```

## Next Steps

- Explore CSS animations for shapes
- Learn about SVG filters and effects
- Check out complete SVG examples in the repository
