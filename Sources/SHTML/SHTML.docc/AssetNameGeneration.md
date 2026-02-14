# Asset Name Generation

Generate typed `ImageName` and `FontName` symbols from your asset folders so you get dot-autocomplete like `.lily` and `.fascinateInlineRegular`.

## Why

Swift autocomplete requires static symbols. Asset folders are dynamic, so SHTML provides `AssetNameGenerator` to generate those symbols from files.

## Generate Files

```swift
import SHTML

try AssetNameGenerator.generate(
    imagesDirectory: "Assets/Images",
    fontsDirectory: "Assets/Fonts",
    outputDirectory: "Sources/App/Generated"
)
```

This writes:

- `Sources/App/Generated/ImageName+Generated.swift`
- `Sources/App/Generated/FontName+Generated.swift`

## Use Generated Names

```swift
Image(.lily)

Text("Sender")
    .fontFamily(.fascinateInlineRegular)
```

## Typical Workflow

Run the generator when assets change (or as a pre-build step), then build your app.
