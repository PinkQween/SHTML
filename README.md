# SHTML

> A SwiftUI-inspired framework for generating HTML, CSS, and JavaScript with complete type safety.

SHTML brings SwiftUI's declarative syntax and type safety to web development. Write HTML, CSS, and JavaScript using Swift's powerful result builders and enjoy full IDE support with autocomplete and type checking.

## ✨ Features

- **SwiftUI-Style Components** - Use the familiar `var body: some HTML` pattern
- **Type-Safe CSS** - Declarative CSS using result builders with no magic strings
- **Natural JavaScript API** - Write JavaScript with full type safety
- **Client-Side Routing** - React Router-like navigation built-in
- **Modifier System** - SwiftUI-style modifiers for styling (`.padding()`, `.background()`, etc.)
- **Stack Layouts** - VStack, HStack, and ZStack for flexible layouts
- **Zero Dependencies** - Pure Swift code generation
- **Live Reload** - Development server with hot reload

## 🚀 Quick Start

### Installation

#### Using Swift Package Manager

Add SHTML to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/pinkqween/SHTML.git", from: "1.0.0")
],
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["SHTML"]
    )
]
```

#### Using the CLI

Install the SHTML CLI tool for project scaffolding and development:

```bash
git clone https://github.com/pinkqween/SHTML.git
cd SHTML
./install.sh
```

### Your First Page

```swift
import SHTML

struct MyPage: HTML {
    var body: some HTML {
        html {
            head {
                meta().charset("UTF-8")
                Title("My First SHTML Page")
            }
            body {
                VStack(spacing: "20px") {
                    h1 { "Welcome to SHTML!" }
                    p { "Build web apps with Swift's type safety" }
                    
                    button { "Click Me" }
                        .padding("10px 20px")
                        .background("#007AFF")
                        .foregroundColor("white")
                        .cornerRadius("8px")
                        .onclick("alert('Hello from SHTML!')")
                }
                .padding("40px")
                .background("#f5f5f5")
            }
        }
    }
}

// Render to HTML string
let html = MyPage().render()
print(html)
```

## 📚 Core Concepts

### Components

Create reusable components by conforming to the `HTML` protocol:

```swift
struct Card: HTML {
    let title: String
    let content: String
    
    var body: some HTML {
        Div {
            h2 { title }
            p { content }
        }
        .padding("20px")
        .background("white")
        .cornerRadius("12px")
        .shadow(y: "4px", blur: "12px", color: "rgba(0,0,0,0.1)")
    }
}

// Use it
Card(title: "Hello", content: "This is a card component")
```

### Layout Stacks

SHTML provides three layout primitives inspired by SwiftUI:

#### VStack - Vertical Stack

```swift
VStack(spacing: "16px") {
    h1 { "Title" }
    p { "Subtitle" }
    button { "Action" }
}
.padding("20px")
```

#### HStack - Horizontal Stack

```swift
HStack(spacing: "12px") {
    img().src("icon.png")
    span { "Label" }
}
```

#### ZStack - Overlay Stack

```swift
ZStack(alignment: "center") {
    Rect()
        .fill("#007AFF")
        .frame(width: "300px", height: "200px")
    
    VStack {
        h2 { "Overlay Title" }
        p { "Content on top" }
    }
    .foregroundColor("white")
}
.cornerRadius("12px")
```

### Modifiers

Style your elements with SwiftUI-inspired modifiers:

```swift
Div {
    h1 { "Styled Content" }
}
// Layout
.padding("20px")
.margin("10px")
.frame(width: "300px", height: "200px")

// Colors
.background("#007AFF")
.foregroundColor("white")

// Typography
.font(size: "18px", weight: "bold")
.textAlign("center")

// Visual Effects
.cornerRadius("12px")
.shadow(y: "4px", blur: "12px")
.opacity(0.9)
.border(width: "2px", color: "#ddd")

// Events
.onclick("handleClick()")
.onhover("this.style.opacity='0.8'")
```

### Type-Safe CSS

Write CSS with full type safety using result builders:

```swift
struct MyStyles: CSS {
    var body: some CSS {
        CSSRule(".card") {
            background("white")
            padding("20px")
            borderRadius("12px")
            boxShadow("0 4px 12px rgba(0,0,0,0.1)")
        }
        
        CSSRule(".button") {
            background("linear-gradient(135deg, #667eea 0%, #764ba2 100%)")
            color("white")
            padding("12px 24px")
            border("none")
            borderRadius("8px")
            cursor("pointer")
            transition("transform 0.2s")
        }
        
        CSSRule(".button:hover") {
            transform("translateY(-2px)")
        }
    }
}

// Use in your page
html {
    head {
        Style { MyStyles() }
    }
    body {
        Div { "Content" }.class("card")
    }
}
```

### Natural JavaScript

Write JavaScript with type safety:

```swift
struct MyScript: JavaScript {
    var body: some JavaScript {
        JSFunc("handleClick") {
            JSVar("element") = JS.getElementById("myElement")
            element.style.background = "blue"
            JS.console.log("Clicked!")
        }
        
        JSFunc("fetchData") {
            JS.async {
                JSVar("response") = JS.await(JS.fetch("/api/data"))
                JSVar("data") = JS.await(response.json())
                JS.console.log(data)
            }
        }
    }
}

// Include in page
html {
    head {
        ScriptElement { MyScript() }
    }
}
```

### Client-Side Routing

Build single-page applications with built-in routing:

```swift
Router {
    Route("/") { HomePage() }
    Route("/about") { AboutPage() }
    Route("/contact") { ContactPage() }
}

// Navigation links
RouterLink(to: "/about") {
    "Go to About Page"
}
```

## 🔧 CLI Commands

### Create a New Project

```bash
shtml init my-website
cd my-website
```

### Start Development Server

```bash
shtml dev
```

The dev server runs at `http://localhost:3000` with automatic live reload.

### Build for Production

```bash
shtml build
```

Generates optimized HTML, CSS, and JavaScript in the `dist/` directory.

## 📖 Examples

### Landing Page

```swift
struct LandingPage: HTML {
    var body: some HTML {
        html {
            head {
                Title("My Awesome Site")
                meta().name("viewport").content("width=device-width, initial-scale=1")
                Style {
                    CSSRule("*") {
                        margin("0")
                        padding("0")
                        boxSizing("border-box")
                    }
                    CSSRule("body") {
                        fontFamily("system-ui, -apple-system, sans-serif")
                    }
                }
            }
            body {
                // Hero Section
                VStack(spacing: "24px") {
                    h1 { "Build Amazing Web Apps" }
                        .font(size: "48px", weight: "bold")
                    
                    p { "With the power of Swift and SwiftUI syntax" }
                        .font(size: "20px")
                        .foregroundColor("#666")
                    
                    HStack(spacing: "16px") {
                        button { "Get Started" }
                            .padding("14px 28px")
                            .background("#007AFF")
                            .foregroundColor("white")
                            .cornerRadius("8px")
                            .border(width: "0")
                        
                        button { "Learn More" }
                            .padding("14px 28px")
                            .background("transparent")
                            .foregroundColor("#007AFF")
                            .cornerRadius("8px")
                            .border(width: "2px", color: "#007AFF")
                    }
                }
                .padding("80px 20px")
                .textAlign("center")
                
                // Features Section
                VStack(spacing: "40px") {
                    h2 { "Features" }
                        .font(size: "36px", weight: "bold")
                    
                    HStack(spacing: "32px") {
                        FeatureCard(
                            title: "Type Safe",
                            description: "Full Swift type safety for HTML, CSS, and JS"
                        )
                        FeatureCard(
                            title: "SwiftUI-like",
                            description: "Familiar syntax if you know SwiftUI"
                        )
                        FeatureCard(
                            title: "Zero Config",
                            description: "Start building immediately with no setup"
                        )
                    }
                }
                .padding("60px 20px")
                .background("#f9f9f9")
            }
            .background("white")
        }
    }
}

struct FeatureCard: HTML {
    let title: String
    let description: String
    
    var body: some HTML {
        VStack(spacing: "12px") {
            h3 { title }
                .font(size: "24px", weight: "600")
            p { description }
                .foregroundColor("#666")
        }
        .padding("24px")
        .background("white")
        .cornerRadius("12px")
        .shadow(y: "4px", blur: "12px", color: "rgba(0,0,0,0.08)")
    }
}
```

### Form with Validation

```swift
struct ContactForm: HTML {
    var body: some HTML {
        Form {
            VStack(spacing: "16px") {
                Input()
                    .type("text")
                    .placeholder("Your name")
                    .padding("12px")
                    .cornerRadius("6px")
                    .border(width: "1px", color: "#ddd")
                
                Input()
                    .type("email")
                    .placeholder("your@email.com")
                    .padding("12px")
                    .cornerRadius("6px")
                    .border(width: "1px", color: "#ddd")
                
                button { "Submit" }
                    .type("submit")
                    .padding("12px 24px")
                    .background("#007AFF")
                    .foregroundColor("white")
                    .cornerRadius("6px")
            }
        }
        .onsubmit("handleSubmit(event); return false;")
    }
}
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License.

## 🔗 Links

- [Documentation](https://github.com/pinkqween/SHTML)
- [Examples](https://github.com/pinkqween/SHTML/tree/main/Examples)
- [Issues](https://github.com/pinkqween/SHTML/issues)

---

Made with ❤️ using Swift
