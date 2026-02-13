# Routing Guide

Learn how to build client-side navigation with `Router`, `Route`, `RouterLink`, and `Navigate`.

## Overview

SHTML includes a lightweight client-side router for multi-page style apps without a full SPA framework. Routes are declared in Swift and rendered to HTML, and navigation is handled in the browser through the History API.

Use routing when you want:
- clean URL paths like `/`, `/about`, `/settings`
- in-app navigation without full page reloads
- simple wildcard matching for nested sections

## Basic Router

Define a router with one or more routes:

```swift
import SHTML

struct App: HTML {
    var body: some HTML {
        Router {
            Route(path: "/") {
                h1 { "Home" }
            }

            Route(path: "/about") {
                h1 { "About" }
            }
        } fallback: {
            h1 { "404 - Not Found" }
        }
    }
}
```

`fallback` is rendered when no route matches the current path.

## Navigation Links

Use `RouterLink` for in-app navigation:

```swift
RouterLink(to: "/about") {
    span { "Go to About" }
}
```

By default, `RouterLink` pushes history entries (`history.pushState`).

Use `replace: true` to replace the current history entry:

```swift
RouterLink(to: "/login", replace: true) {
    span { "Continue" }
}
```

## Programmatic Navigation

Use `Navigate` to trigger navigation in render output:

```swift
Navigate(to: "/dashboard")
Navigate(to: "/profile", replace: true)
```

This renders a script that calls `window.navigate(...)`.

## Wildcard Routes

SHTML supports a simple trailing wildcard match using `*`:

```swift
Router {
    Route(path: "/docs/*") {
        h1 { "Docs Section" }
    }
}
```

`/docs/getting-started` and `/docs/api` will match `/docs/*`.

## Dynamic Path Parameters

Use `:name` segments for dynamic route matching:

```swift
Router {
    Route(path: "/users/:id") {
        h2 { "User Detail" }
    }
}
```

When `/users/42` is active, the route matches and `window.routeParams.id` is set to `"42"`.

## Query Parameters

Query strings are parsed automatically during navigation:

```text
/search?q=shtml&page=2
```

Parsed values are exposed on `window.queryParams`:
- `window.queryParams.q` -> `"shtml"`
- `window.queryParams.page` -> `"2"`

If a key appears multiple times, it becomes an array.

```text
/items?tag=swift&tag=web
```

`window.queryParams.tag` -> `["swift", "web"]`

## Full Example

```swift
import SHTML

struct AppShell: HTML {
    var body: some HTML {
        VStack(spacing: "16px") {
            HStack(spacing: "12px") {
                RouterLink(to: "/") { "Home" }
                RouterLink(to: "/settings") { "Settings" }
                RouterLink(to: "/docs/getting-started") { "Docs" }
            }

            Router {
                Route(path: "/") {
                    h2 { "Home" }
                    p { "Welcome to the app." }
                }

                Route(path: "/settings") {
                    h2 { "Settings" }
                    button { "Save" }
                }

                Route(path: "/docs/*") {
                    h2 { "Documentation" }
                }
            } fallback: {
                h2 { "Page not found" }
            }
        }
        .padding("24px")
    }
}
```

## Notes

- Routing is path-based and currently does exact match or trailing `*` prefix match.
- Query parameters and hash handling are available through browser APIs (`window.location`) in JavaScript when needed.
- `RouterLink` prevents default anchor navigation and delegates to `window.navigate(...)`.
