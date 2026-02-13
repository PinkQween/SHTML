# ``SHTML``

A SwiftUI-inspired framework for generating HTML, CSS, and JavaScript with complete type safety.

## Overview

SHTML brings SwiftUI's declarative syntax and type safety to web development. Write HTML, CSS, and JavaScript using Swift's powerful result builders and enjoy full IDE support with autocomplete and type checking.

```swift
import SHTML

struct MyPage: HTML {
    var body: some HTML {
        html {
            head {
                Title("My Website")
            }
            body {
                Div {
                    h1 { "Hello, World!" }
                    p { "Built with SHTML" }
                }
                .padding("20px")
                .background("#f0f0f0")
            }
        }
    }
}
```

## Features

- **SwiftUI-Style Components** - Use `var body: some HTML` pattern
- **Type-Safe CSS** - Declarative CSS using result builders
- **Natural JavaScript API** - Write JS with type safety
- **Client-Side Routing** - React Router-like navigation
- **Modifier System** - SwiftUI-style modifiers for styling
- **Zero Dependencies** - Pure Swift code generation

## Topics

### Essentials

- <doc:GettingStarted>
- <doc:CreatingComponents>
- <doc:StylingElements>

### HTML Generation

- ``HTML``
- ``HTMLPrimitive``
- ``HTMLModifiable``
- ``Group``

### Core Elements

- ``Div``
- ``h1``
- ``h2``
- ``h3``
- ``p``
- ``span``
- ``button``

### CSS System

- ``CSS``
- ``CSSRule``
- ``CSSProperty``
- ``CSSKeyframes``
- ``Style``

### JavaScript System

- ``JavaScript``
- ``JSExpr``
- ``JSArg``
- ``JSFunc``
- ``JSRaw``

### Routing

- ``Router``
- ``Route``
- ``RouterLink``

### Modifiers

- ``HTMLModifiable/padding(_:)``
- ``HTMLModifiable/margin(_:)``
- ``HTMLModifiable/background(_:)``
- ``HTMLModifiable/foregroundColor(_:)``
- ``HTMLModifiable/cornerRadius(_:)``
