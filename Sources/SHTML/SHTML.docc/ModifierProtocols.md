# Modifier Protocols

Understand the difference between `HTMLModifiable` and `HTMLContentModifiable`.

## Overview

SHTML modifiers are built on two protocols:

- ``HTMLModifiable``
- ``HTMLContentModifiable``

They look similar, but they solve different problems.

## `HTMLModifiable`

Use `HTMLModifiable` for any element that can carry attributes:

- `id`
- `class`
- `style`
- event handlers (`onclick`, `onchange`, etc.)

If your element stores an `attributes: [String: String]` dictionary and renders it, it should conform.

## `HTMLContentModifiable`

Use `HTMLContentModifiable` when the element also owns child content and needs to support content-replacement helpers:

- ``HTMLModifiable/with(class:content:)``
- ``HTMLModifiable/with(id:content:)``
- ``HTMLModifiable/with(style:content:)``

This protocol requires:

```swift
init(attributes: [String: String], content: @escaping () -> [any HTML])
```

That initializer lets SHTML rebuild the same element type with modified attributes and new children.

## Which One To Conform To

- Leaf/no-content element: usually ``HTMLModifiable``.
- Container/content element: ``HTMLContentModifiable`` (and therefore also ``HTMLModifiable``).

## Example

```swift
struct Card: HTMLPrimitive, HTMLContentModifiable {
    typealias Content = Never
    var attributes: [String: String]
    private let content: () -> [any HTML]

    init(attributes: [String : String] = [:], content: @escaping () -> [any HTML]) {
        self.attributes = attributes
        self.content = content
    }

    var html: String {
        "<div\(HTMLRendering.renderAttributes(attributes))>\(HTMLRendering.renderChildren(content))</div>"
    }
}
```
