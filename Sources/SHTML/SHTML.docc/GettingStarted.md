# Getting Started with SHTML

Learn how to set up and use SHTML in your project.

## Overview

SHTML is a Swift framework for generating static HTML with type-safe CSS and JavaScript. It uses SwiftUI-like syntax and result builders to provide a familiar and powerful development experience.

## Installation

### Using Swift Package Manager

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

### Using the CLI

Install the SHTML CLI tool for project scaffolding and development:

```bash
git clone https://github.com/pinkqween/SHTML.git
cd SHTML
./install.sh
```

## Creating Your First Page

Create a simple HTML page using SHTML:

```swift
import SHTML

struct MyFirstPage: HTML {
    var body: some HTML {
        html {
            head {
                meta().charset("UTF-8")
                Title("My First SHTML Page")
            }
            body {
                h1 { "Welcome to SHTML!" }
                p { "This page was generated with Swift." }
            }
        }
    }
}

// Render to string
let htmlString = MyFirstPage().render()
print(htmlString)
```

## Using the CLI

### Create a New Project

```bash
shtml init my-website
cd my-website
```

### Start Development Server

```bash
shtml dev
```

Visit `http://localhost:3000` to see your site with live reload!

### Build for Production

```bash
shtml build
```

## Next Steps

- <doc:CreatingComponents> - Learn how to create reusable components
- <doc:StylingElements> - Style your pages with modifiers and CSS
- Read the full documentation for ``HTML``, ``CSS``, and ``JavaScript``
