# Asset Name Generation

Generate typed `ImageName`, `VideoName`, `AudioName`, and `FontName` symbols from your asset folders so you get dot-autocomplete like `.lily` and `.fascinateInlineRegular`.

## Why

Swift autocomplete requires static symbols. Asset folders are dynamic, so SHTML provides `AssetNameGenerator` to generate those symbols from files.

## Automatic (Build Plugin)

Attach SHTML's build plugin to your app target:

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "SHTML", package: "SHTML")
    ],
    plugins: [
        .plugin(name: "SHTMLAssetNamePlugin", package: "shtml")
    ]
)
```

On build, the plugin scans:

- `Assets/Images`
- `Assets/Videos`
- `Assets/Audio`
- `Assets/Fonts`

and generates typed members into the plugin output directory.

## Manual Generation

```swift
import SHTML

try AssetNameGenerator.generate(
    imagesDirectory: "Assets/Images",
    videosDirectory: "Assets/Videos",
    audioDirectory: "Assets/Audio",
    fontsDirectory: "Assets/Fonts",
    outputDirectory: "Sources/App/Generated"
)
```

This writes:

- `Sources/App/Generated/ImageName+Generated.swift`
- `Sources/App/Generated/VideoName+Generated.swift`
- `Sources/App/Generated/AudioName+Generated.swift`
- `Sources/App/Generated/FontName+Generated.swift`

## Use Generated Names

```swift
Image(.lily)
Video(.intro)
Audio(.theme)

Text("Sender")
    .fontFamily(.fascinateInlineRegular)
```

## Typical Workflow

Run the generator when assets change (or as a pre-build step), then build your app.
