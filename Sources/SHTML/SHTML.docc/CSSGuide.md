# CSS Guide

A practical guide to using CSS in SHTML - from basic to advanced, with type-safe CSS lengths.

## Quick Start

### Method 1: Inline Styles with Modifiers (Easiest)

Just chain modifiers on any element using type-safe CSS lengths:

```swift
Div {
    h1 { "Hello" }
}
.padding(20.px)
.background("#007AFF")
.cornerRadius(12.px)
```

✅ **Use this when:** Styling individual elements, quick prototypes, or one-off styles.

### Method 2: CSS Classes (Recommended)

Define reusable CSS classes and apply them:

```swift
// 1. Create your styles
html {
    head {
        Style {
            CSSRule(".card") {
                background("white")
                padding("20px")
                borderRadius("12px")
            }
        }
    }
    body {
        // 2. Use the class
        Div { "Content" }
            .class("card")
    }
}
```

✅ **Use this when:** You need reusable styles, complex selectors, or pseudo-classes.

## Type-Safe CSS Lengths

SHTML provides type-safe CSS lengths with automatic unit conversion:

```swift
// All CSS units supported:
100.px          // pixels
2.rem           // root em
1.5.em          // em
50.percent      // %
100.vh          // viewport height
100.vw          // viewport width

// Use them anywhere:
Div { "Content" }
    .padding(20.px)
    .margin(10.px)
    .frame(width: 300.px, height: 200.px)

SVG(width: 100.vw, height: 100.vh) {
    Rect(width: 200.px, height: 150.px)
        .cornerRadius(12.px)
}

// Still works with strings for backward compatibility:
.padding("20px")
.frame(width: "300px", height: "200px")
```

### Available CSS Units

```swift
// Length units
100.px          // Pixels
2.rem           // Root em (relative to root font size)
1.5.em          // Em (relative to parent font size)

// Percentage
50.percent      // Percentage (%)

// Viewport units
100.vh          // Viewport height
100.vw          // Viewport width
50.vmin         // Minimum of vh or vw
50.vmax         // Maximum of vh or vw

// Other units (coming soon)
// 12.pt        // Points
// 1.cm         // Centimeters
// 10.mm        // Millimeters
```

## Complete Examples

### Example 1: Simple Page with Styles

```swift
struct SimplePage: HTML {
    var body: some HTML {
        html {
            head {
                Title("My Page")
                
                // Define your CSS here
                Style {
                    // Reset
                    CSSRule("*") {
                        margin("0")
                        padding("0")
                        boxSizing("border-box")
                    }
                    
                    // Body styles
                    CSSRule("body") {
                        fontFamily("system-ui, -apple-system, sans-serif")
                        background("#f5f5f5")
                    }
                    
                    // Button styles
                    CSSRule(".btn") {
                        padding("12px 24px")
                        background("#007AFF")
                        color("white")
                        border("none")
                        borderRadius("8px")
                        cursor("pointer")
                    }
                }
            }
            body {
                h1 { "Welcome" }
                button { "Click Me" }
                    .class("btn")
            }
        }
    }
}
```

### Example 2: Hover Effects

```swift
Style {
    CSSRule(".button") {
        padding("12px 24px")
        background("#007AFF")
        color("white")
        borderRadius("8px")
        transition("all 0.2s ease")
    }
    
    // Hover state
    CSSRule(".button:hover") {
        background("#0051D5")
        transform("translateY(-2px)")
    }
    
    // Active state
    CSSRule(".button:active") {
        transform("translateY(0)")
    }
}
```

### Example 3: Complete Card Component

```swift
struct CardExample: HTML {
    var body: some HTML {
        html {
            head {
                Style {
                    // Card container
                    CSSRule(".card") {
                        background("white")
                        borderRadius("12px")
                        boxShadow("0 4px 12px rgba(0,0,0,0.1)")
                        overflow("hidden")
                        transition("transform 0.2s")
                    }
                    
                    CSSRule(".card:hover") {
                        transform("translateY(-4px)")
                        boxShadow("0 8px 24px rgba(0,0,0,0.15)")
                    }
                    
                    // Card parts
                    CSSRule(".card-image") {
                        width("100%")
                        height("200px")
                        property("object-fit", "cover")
                    }
                    
                    CSSRule(".card-content") {
                        padding("20px")
                    }
                    
                    CSSRule(".card-title") {
                        fontSize("24px")
                        fontWeight("600")
                        margin("0 0 12px 0")
                    }
                    
                    CSSRule(".card-text") {
                        color("#666")
                        property("line-height", "1.6")
                    }
                }
            }
            body {
                Div {
                    img().src("photo.jpg").class("card-image")
                    Div {
                        h2 { "Card Title" }.class("card-title")
                        p { "This is the card description." }.class("card-text")
                    }
                    .class("card-content")
                }
                .class("card")
            }
        }
    }
}
```

## Animations

### Creating Keyframe Animations

```swift
Style {
    // Define the animation
    CSSKeyframes("fadeIn") {
        CSSKeyframe("0%") {
            opacity("0")
            transform("translateY(20px)")
        }
        CSSKeyframe("100%") {
            opacity("1")
            transform("translateY(0)")
        }
    }
    
    // Use the animation
    CSSRule(".animated") {
        animation("fadeIn 0.5s ease-out")
    }
}

// Apply to element
Div { "I fade in!" }
    .class("animated")
```

### Common Animation Example

```swift
Style {
    CSSKeyframes("spin") {
        CSSKeyframe("0%") {
            transform("rotate(0deg)")
        }
        CSSKeyframe("100%") {
            transform("rotate(360deg)")
        }
    }
    
    CSSRule(".spinner") {
        width("40px")
        height("40px")
        border("4px solid #f3f3f3")
        borderTop("4px solid #007AFF")
        borderRadius("50%")
        animation("spin 1s linear infinite")
    }
}
```

## Responsive Design

### Mobile-First Approach

```swift
Style {
    // Base styles (mobile)
    CSSRule(".container") {
        padding("10px")
        fontSize("14px")
    }
    
    // Tablet and up
    CSSMediaQuery("(min-width: 768px)") {
        CSSRule(".container") {
            padding("20px")
            fontSize("16px")
        }
    }
    
    // Desktop and up
    CSSMediaQuery("(min-width: 1024px)") {
        CSSRule(".container") {
            maxWidth("1200px")
            margin("0 auto")
            padding("40px")
        }
    }
}
```

## Available CSS Properties

You can use any CSS property with these helper functions:

### Layout
- `display()`, `position()`, `width()`, `height()`, `maxWidth()`, `minHeight()`
- `margin()`, `padding()`, `gap()`
- `flexDirection()`, `justifyContent()`, `alignItems()`

### Visual
- `background()`, `color()`, `border()`, `borderLeft()`, `borderRadius()`
- `opacity()`, `boxShadow()`

### Typography
- `fontSize()`, `fontWeight()`, `fontFamily()`, `textAlign()`, `textDecoration()`

### Effects
- `transform()`, `transition()`, `animation()`

### Custom Properties
Use `property(name, value)` for anything else:

```swift
CSSRule(".custom") {
    property("grid-template-columns", "1fr 1fr")
    property("backdrop-filter", "blur(10px)")
    property("user-select", "none")
}
```

## CSS Variables

```swift
Style {
    // Define variables
    CSSRule(":root") {
        property("--primary-color", "#007AFF")
        property("--spacing", "20px")
        property("--border-radius", "12px")
    }
    
    // Use variables
    CSSRule(".button") {
        background("var(--primary-color)")
        padding("var(--spacing)")
        borderRadius("var(--border-radius)")
    }
}
```

## Tips

1. **Keep styles in the `<head>`** - Put your `Style` element in the `head` section
2. **Use classes for reusability** - Define once, use everywhere
3. **Start with reset styles** - Normalize browser defaults first
4. **Mobile-first** - Start with mobile styles, add breakpoints for larger screens
5. **Use CSS variables** - For colors, spacing, and other repeated values

## Common Patterns

### Full-Width Container with Max Width

```swift
CSSRule(".container") {
    width("100%")
    maxWidth("1200px")
    margin("0 auto")
    padding("0 20px")
}
```

### Flexbox Centering

```swift
CSSRule(".center") {
    display("flex")
    justifyContent("center")
    alignItems("center")
    minHeight("100vh")
}
```

### Card Grid

```swift
CSSRule(".grid") {
    display("grid")
    property("grid-template-columns", "repeat(auto-fit, minmax(300px, 1fr))")
    gap("20px")
    padding("20px")
}
```

### Smooth Transitions

```swift
CSSRule(".interactive") {
    transition("all 0.2s ease")
}

CSSRule(".interactive:hover") {
    transform("scale(1.05)")
}
```
