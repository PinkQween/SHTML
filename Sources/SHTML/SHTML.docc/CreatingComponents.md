# Creating Components

Learn how to create reusable, composable HTML components with SHTML.

## Overview

Components in SHTML work just like SwiftUI views. You create a struct that conforms to the `HTML` protocol and define a `body` property that describes the component's structure.

## Basic Components

### Simple Component

The simplest component returns basic HTML elements:

```swift
struct Greeting: HTML {
    var body: some HTML {
        h1 { "Hello, World!" }
    }
}
```

### Component with Properties

Add properties to make your components dynamic:

```swift
struct Greeting: HTML {
    let name: String
    
    var body: some HTML {
        h1 { "Hello, \(name)!" }
    }
}

// Usage
Greeting(name: "Swift")
```

### Component Composition

Combine multiple elements and other components:

```swift
struct Card: HTML {
    let title: String
    let content: String
    let imageURL: String?
    
    var body: some HTML {
        Div {
            if let imageURL = imageURL {
                img().src(imageURL)
                    .style("width: 100%; height: 200px; object-fit: cover;")
            }
            
            VStack(spacing: "12px") {
                h2 { title }
                    .font(size: "24px", weight: "600")
                
                p { content }
                    .foregroundColor("#666")
            }
            .padding("20px")
        }
        .background("white")
        .cornerRadius("12px")
        .shadow(y: "4px", blur: "12px", color: "rgba(0,0,0,0.1)")
    }
}
```

## Layout Components

### Using VStack for Vertical Layout

Stack elements vertically with optional spacing:

```swift
struct ProfileCard: HTML {
    let name: String
    let bio: String
    
    var body: some HTML {
        VStack(spacing: "16px") {
            img().src("avatar.jpg")
                .cornerRadius("50%")
                .frame(width: "100px", height: "100px")
            
            h3 { name }
            p { bio }
                .textAlign("center")
                .foregroundColor("#666")
        }
        .padding("24px")
        .background("white")
        .cornerRadius("12px")
    }
}
```

### Using HStack for Horizontal Layout

Stack elements horizontally:

```swift
struct IconButton: HTML {
    let icon: String
    let label: String
    
    var body: some HTML {
        HStack(spacing: "8px") {
            img().src(icon)
                .frame(width: "20px", height: "20px")
            span { label }
        }
        .padding("10px 20px")
        .background("#007AFF")
        .foregroundColor("white")
        .cornerRadius("8px")
    }
}
```

### Using ZStack for Overlays

Layer elements on top of each other:

```swift
struct HeroSection: HTML {
    var body: some HTML {
        ZStack(alignment: "center") {
            // Background image/color
            Rect()
                .fill("linear-gradient(135deg, #667eea 0%, #764ba2 100%)")
                .frame(width: "100%", height: "400px")
            
            // Content on top
            VStack(spacing: "20px") {
                h1 { "Welcome" }
                    .font(size: "48px", weight: "bold")
                    .foregroundColor("white")
                
                p { "Build amazing things with SHTML" }
                    .font(size: "20px")
                    .foregroundColor("rgba(255,255,255,0.9)")
            }
        }
    }
}
```

## Conditional Content

Use Swift's control flow to conditionally render content:

```swift
struct UserProfile: HTML {
    let user: User
    let isLoggedIn: Bool
    
    var body: some HTML {
        Div {
            if isLoggedIn {
                VStack {
                    h2 { "Welcome back, \(user.name)!" }
                    button { "Logout" }
                }
            } else {
                VStack {
                    h2 { "Please log in" }
                    button { "Login" }
                }
            }
        }
    }
}
```

## Lists and Loops

Use Swift's `for` loops to generate repeated content:

```swift
struct TodoList: HTML {
    let items: [String]
    
    var body: some HTML {
        ul {
            for item in items {
                li { item }
                    .padding("8px")
            }
        }
    }
}
```

## Component Groups

Use `Group` to return multiple root elements:

```swift
struct Navigation: HTML {
    var body: some HTML {
        Group {
            nav {
                HStack(spacing: "20px") {
                    a { "Home" }.href("/")
                    a { "About" }.href("/about")
                    a { "Contact" }.href("/contact")
                }
            }
            
            Div { "Divider" }
                .frame(height: "1px")
                .background("#ddd")
        }
    }
}
```

## Reusable Styles

Create components that encapsulate styling:

```swift
struct PrimaryButton: HTML {
    let text: String
    let action: String
    
    var body: some HTML {
        button { text }
            .padding("12px 24px")
            .background("linear-gradient(135deg, #667eea 0%, #764ba2 100%)")
            .foregroundColor("white")
            .border(width: "0")
            .cornerRadius("8px")
            .font(size: "16px", weight: "600")
            .onclick(action)
    }
}

// Usage
PrimaryButton(text: "Click Me", action: "handleClick()")
```

## Best Practices

1. **Keep components small and focused** - Each component should do one thing well
2. **Use descriptive names** - Name components based on what they represent, not how they look
3. **Make components reusable** - Add parameters for values that might change
4. **Compose components** - Build complex UIs by combining simpler components
5. **Use layout containers** - Leverage VStack, HStack, and ZStack for consistent layouts
6. **Extract common patterns** - If you're repeating the same code, create a component

## Example: Complete Page

Here's a complete example combining multiple components:

```swift
struct LandingPage: HTML {
    var body: some HTML {
        html {
            head {
                Title("My App")
                meta().name("viewport").content("width=device-width, initial-scale=1")
            }
            body {
                VStack(spacing: "0") {
                    Header()
                    HeroSection()
                    FeaturesSection()
                    Footer()
                }
            }
            .background("#ffffff")
        }
    }
}

struct Header: HTML {
    var body: some HTML {
        nav {
            HStack(spacing: "32px") {
                h1 { "MyApp" }
                HStack(spacing: "16px") {
                    a { "Features" }.href("#features")
                    a { "Pricing" }.href("#pricing")
                    a { "Contact" }.href("#contact")
                }
            }
            .padding("20px 40px")
        }
        .background("white")
        .shadow(y: "2px", blur: "8px", color: "rgba(0,0,0,0.05)")
    }
}
```

## Next Steps

- Learn about styling in <doc:StylingElements>
- Explore the full API in ``HTML`` documentation
- See working examples in the repository
