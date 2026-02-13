# SHTML Assets

This directory contains static assets for your SHTML website.

## Directory Structure

```
Assets/
├── Images/       # Image assets (.png, .jpg, .svg, etc.)
├── Fonts/        # Font files (.woff2, .woff, .ttf, .otf)
└── README.md     # This file
```

## Usage

### 1. Add Assets to Directories

Place your image files in `Assets/Images/` and font files in `Assets/Fonts/`.

### 2. Register Assets in Your Code

```swift
// Configure assets once at app startup
configureAssets {
    // Images
    Image("logo")                    // Uses default path: Assets/Images/logo
    Image("hero", path: "Assets/Images/hero.jpg")
    
    // Fonts
    Font("Inter-Regular", format: .woff2)
    Font("Montserrat-Bold", format: .woff2)
    
    // Colors (with dark mode support)
    ColorPair("primary", light: #hex("#007AFF"), dark: #hex("#0A84FF"))
    ColorPair("background", light: .white, dark: #hex("#1C1C1E"))
    ColorPair("text", light: .black, dark: .white)
}
```

### 3. Use Assets in Your HTML

```swift
// Images
Assets.image("logo")?.image(alt: "Logo", width: 200.px, height: 100.px)

// Colors
div()
    .background(Assets.color("primary")!.color)
    .foregroundColor(Assets.color("text")!.color)

// In CSS
Style {
    CSSRule(.body) {
        background(Assets.color("background")!.color)
        color(Assets.color("text")!.color)
    }
}

// Fonts in CSS
Style(Assets.generateFontCSS())
Style(Assets.generateColorCSS())
```

## Asset Types

### Images
- Supports all common image formats
- Automatically resolved to `Assets/Images/` directory
- Can specify custom paths

### Fonts
- Supports: `.woff2`, `.woff`, `.ttf`, `.otf`, `.eot`
- Generates @font-face CSS automatically
- WOFF2 is recommended for best compression

### Colors
- Automatic dark mode support
- CSS custom properties (variables)
- Type-safe color references

## Best Practices

1. **Use WOFF2** for fonts (best compression and browser support)
2. **Optimize images** before adding them
3. **Use SVG** for icons and logos when possible
4. **Define color palette** once and reference via CSS variables
5. **Use descriptive names** for assets
