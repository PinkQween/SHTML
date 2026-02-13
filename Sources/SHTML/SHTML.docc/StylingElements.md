# Styling Elements

Learn how to style your HTML elements using SHTML's SwiftUI-inspired modifier system and type-safe CSS.

## Overview

SHTML provides two main approaches to styling:
1. **Inline modifiers** - SwiftUI-style method chaining (`.padding()`, `.background()`, etc.)
2. **CSS classes** - Type-safe CSS using result builders

## Inline Modifiers

Apply styles directly to elements using modifiers. These work on any element that conforms to `HTMLModifiable`.

### Layout Modifiers

Control spacing, sizing, and positioning:

```swift
Div {
    h1 { "Title" }
}
.padding("20px")                    // All sides
.padding(top: "20px", left: "10px") // Specific sides
.margin("10px")                      // All sides
.frame(width: "300px", height: "200px")
```

### Color Modifiers

Set background and text colors:

```swift
Div {
    p { "Colored text" }
}
.background("#007AFF")              // Solid color
.background("linear-gradient(135deg, #667eea 0%, #764ba2 100%)") // Gradient
.foregroundColor("white")           // Text color
```

### Typography Modifiers

Style text appearance:

```swift
h1 { "Headline" }
    .font(size: "32px", weight: "bold", family: "Arial")
    .fontSize("32px")
    .fontWeight("600")
    .textAlign("center")
```

### Visual Effect Modifiers

Add visual polish:

```swift
Div { "Card" }
    .cornerRadius("12px")
    .shadow(x: "0", y: "4px", blur: "12px", color: "rgba(0,0,0,0.1)")
    .opacity(0.95)
    .border(width: "2px", style: "solid", color: "#ddd")
```

### Display Modifiers

Control element visibility and display:

```swift
Div { "Content" }
    .hidden(true)           // Hide element
    .display("none")        // CSS display property
    .position("relative")
```

### Event Modifiers

Attach JavaScript event handlers:

```swift
button { "Click Me" }
    .onclick("handleClick()")
    .onmouseover("this.style.opacity='0.8'")
    .onmouseout("this.style.opacity='1'")
    .onfocus("console.log('focused')")
    .onblur("console.log('blurred')")
```

### Attribute Modifiers

Set HTML attributes:

```swift
Div { "Content" }
    .id("unique-id")
    .class("my-class another-class")
    .title("Tooltip text")
    .dataAttribute("value", "123")
    .role("button")
    .accessibilityLabel("Descriptive label")
    .tabIndex(0)
```

## Complete Modifier Examples

### Styled Button

```swift
button { "Get Started" }
    .padding("14px 28px")
    .background("linear-gradient(135deg, #667eea 0%, #764ba2 100%)")
    .foregroundColor("white")
    .border(width: "0")
    .cornerRadius("8px")
    .font(size: "16px", weight: "600")
    .shadow(y: "4px", blur: "12px", color: "rgba(102, 126, 234, 0.4)")
    .onclick("handleGetStarted()")
```

### Card Component

```swift
Div {
    VStack(spacing: "12px") {
        h2 { "Card Title" }
        p { "Card description goes here" }
    }
}
.padding("24px")
.background("white")
.cornerRadius("12px")
.shadow(y: "2px", blur: "8px", color: "rgba(0,0,0,0.08)")
.border(width: "1px", color: "#e0e0e0")
```

### Hero Section

```swift
body {
    VStack(spacing: "24px") {
        h1 { "Welcome to SHTML" }
            .font(size: "48px", weight: "bold")
        
        p { "Build web apps with Swift" }
            .font(size: "20px")
            .foregroundColor("#666")
        
        button { "Learn More" }
            .padding("12px 24px")
            .background("#007AFF")
            .foregroundColor("white")
            .cornerRadius("8px")
    }
    .padding("80px 20px")
    .textAlign("center")
}
.background("linear-gradient(to bottom, #f7f9fc, #ffffff)")
```

## Type-Safe CSS

For more complex styling, use the CSS result builder:

### Basic CSS Rules

```swift
struct MyStyles: CSS {
    var body: some CSS {
        CSSRule(".card") {
            background("white")
            padding("20px")
            borderRadius("12px")
            boxShadow("0 4px 12px rgba(0,0,0,0.1)")
        }
        
        CSSRule(".button-primary") {
            background("#007AFF")
            color("white")
            padding("12px 24px")
            border("none")
            borderRadius("8px")
            fontSize("16px")
            fontWeight("600")
            cursor("pointer")
            transition("all 0.2s ease")
        }
    }
}
```

### Pseudo-classes and States

```swift
CSSRule(".button-primary:hover") {
    background("#0051D5")
    transform("translateY(-2px)")
    boxShadow("0 6px 16px rgba(0, 122, 255, 0.3)")
}

CSSRule(".button-primary:active") {
    transform("translateY(0)")
}

CSSRule("a:visited") {
    color("purple")
}
```

### Media Queries

```swift
CSSMediaQuery("(max-width: 768px)") {
    CSSRule(".container") {
        padding("10px")
        fontSize("14px")
    }
    
    CSSRule(".hero-title") {
        fontSize("32px")
    }
}
```

### Animations

```swift
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

CSSRule(".animated") {
    animation("fadeIn 0.5s ease-out")
}
```

### Using CSS in Your Pages

Include CSS in your HTML:

```swift
html {
    head {
        Title("My Page")
        Style { MyStyles() }
    }
    body {
        Div { "Content" }
            .class("card")
        
        button { "Click" }
            .class("button-primary")
    }
}
```

## Layout Patterns

### Flexbox with VStack and HStack

VStack and HStack use flexbox internally:

```swift
// Vertical centering
VStack(spacing: "20px") {
    h1 { "Centered Content" }
    p { "This is centered" }
}
.frame(height: "100vh")
.padding("20px")

// Horizontal layout
HStack(spacing: "16px") {
    Div { "Left" }
        .padding("20px")
        .background("#f0f0f0")
    
    Div { "Right" }
        .padding("20px")
        .background("#e0e0e0")
}
```

### Overlays with ZStack

Create layered layouts:

```swift
ZStack(alignment: "center") {
    // Background layer
    Rect()
        .fill("#007AFF")
        .frame(width: "100%", height: "300px")
    
    // Middle layer
    Div {
        VStack {
            h2 { "Overlay Title" }
            p { "Overlay content" }
        }
    }
    .padding("40px")
    .background("rgba(255, 255, 255, 0.1)")
    .cornerRadius("12px")
    
    // Top layer
    img().src("icon.png")
        .frame(width: "50px", height: "50px")
        .position("absolute")
}
```

### Grid Layouts

Use CSS Grid with modifiers:

```swift
Div {
    for item in items {
        Div { item }
            .padding("20px")
            .background("white")
            .cornerRadius("8px")
    }
}
.style("""
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
    padding: 20px;
""")
```

## Responsive Design

### Using Media Queries in CSS

```swift
struct ResponsiveStyles: CSS {
    var body: some CSS {
        CSSRule(".container") {
            maxWidth("1200px")
            margin("0 auto")
            padding("20px")
        }
        
        // Tablet
        CSSMediaQuery("(max-width: 1024px)") {
            CSSRule(".container") {
                padding("15px")
            }
        }
        
        // Mobile
        CSSMediaQuery("(max-width: 768px)") {
            CSSRule(".container") {
                padding("10px")
            }
            
            CSSRule(".hide-mobile") {
                display("none")
            }
        }
    }
}
```

### Conditional Classes

```swift
struct ResponsiveNav: HTML {
    var body: some HTML {
        nav {
            HStack(spacing: "20px") {
                h1 { "Logo" }
                
                HStack(spacing: "16px") {
                    a { "Home" }.href("/")
                    a { "About" }.href("/about")
                    a { "Contact" }.href("/contact")
                }
                .class("hide-mobile")
            }
            .padding("20px")
        }
    }
}
```

## Best Practices

1. **Use modifiers for simple styles** - They're readable and maintainable
2. **Use CSS classes for complex or repeated styles** - Avoid duplicating style code
3. **Leverage layout containers** - VStack, HStack, and ZStack provide consistent spacing
4. **Keep styles scoped** - Use unique class names to avoid conflicts
5. **Use CSS variables** - Define common values (colors, spacing) in one place
6. **Test responsiveness** - Check your layouts on different screen sizes
7. **Use semantic values** - Prefer named values (`"bold"`) over numbers (`"700"`)

## Color System Example

```swift
// Define colors in CSS
struct ColorSystem: CSS {
    var body: some CSS {
        CSSRule(":root") {
            cssVariable("--primary", "#007AFF")
            cssVariable("--secondary", "#5856D6")
            cssVariable("--success", "#34C759")
            cssVariable("--danger", "#FF3B30")
            cssVariable("--text", "#000000")
            cssVariable("--text-secondary", "#666666")
        }
    }
}

// Use in components
button { "Primary" }
    .background("var(--primary)")
    .foregroundColor("white")
```

## Next Steps

- Explore the ``HTMLModifiable`` protocol for all available modifiers
- Learn about ``CSS`` for advanced styling
- Check out component examples in <doc:CreatingComponents>
