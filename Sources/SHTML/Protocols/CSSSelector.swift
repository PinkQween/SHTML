//
//  CSSSelector.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

// CSS Selector - type-safe selector representation
public struct CSSSelector: ExpressibleByStringLiteral, Sendable {
    let value: String
    
    /// Creates a new instance.
    public init(_ value: String) {
        self.value = value
    }
    
    /// Creates a new instance.
    public init(stringLiteral value: String) {
        self.value = value
    }
    
    // Pseudo-class support
    public var hover: CSSSelector {
        CSSSelector("\(value):hover")
    }
    
    /// Property.
    public var active: CSSSelector {
        CSSSelector("\(value):active")
    }
    
    /// Property.
    public var focus: CSSSelector {
        CSSSelector("\(value):focus")
    }
    
    /// Property.
    public var disabled: CSSSelector {
        CSSSelector("\(value):disabled")
    }
    
    /// Property.
    public var firstChild: CSSSelector {
        CSSSelector("\(value):first-child")
    }
    
    /// Property.
    public var lastChild: CSSSelector {
        CSSSelector("\(value):last-child")
    }
    
    /// Property.
    public var nthChild: CSSSelector {
        CSSSelector("\(value):nth-child")
    }
    
    // MARK: - Webkit Scrollbar Pseudo-elements
    
    public var webkitScrollbar: CSSSelector {
        CSSSelector("\(value)::-webkit-scrollbar")
    }
    
    /// Property.
    public var webkitScrollbarTrack: CSSSelector {
        CSSSelector("\(value)::-webkit-scrollbar-track")
    }
    
    /// Property.
    public var webkitScrollbarThumb: CSSSelector {
        CSSSelector("\(value)::-webkit-scrollbar-thumb")
    }
    
    /// Property.
    public var webkitScrollbarButton: CSSSelector {
        CSSSelector("\(value)::-webkit-scrollbar-button")
    }
    
    /// Property.
    public var webkitScrollbarCorner: CSSSelector {
        CSSSelector("\(value)::-webkit-scrollbar-corner")
    }
    
    // Helper to get class name without dot
    public var className: String {
        value.replacingOccurrences(of: ".", with: "")
    }
    
    // MARK: - HTML Tag Selectors
    
    // Universal selector
    public static let all = CSSSelector("*")
    
    // Document & Metadata
    public static let html = CSSSelector("html")
    public static let head = CSSSelector("head")
    public static let title = CSSSelector("title")
    public static let meta = CSSSelector("meta")
    public static let link = CSSSelector("link")
    public static let style = CSSSelector("style")
    public static let script = CSSSelector("script")
    
    // Sections
    public static let body = CSSSelector("body")
    public static let header = CSSSelector("header")
    public static let nav = CSSSelector("nav")
    public static let main = CSSSelector("main")
    public static let section = CSSSelector("section")
    public static let article = CSSSelector("article")
    public static let aside = CSSSelector("aside")
    public static let footer = CSSSelector("footer")
    public static let h1 = CSSSelector("h1")
    public static let h2 = CSSSelector("h2")
    public static let h3 = CSSSelector("h3")
    public static let h4 = CSSSelector("h4")
    public static let h5 = CSSSelector("h5")
    public static let h6 = CSSSelector("h6")
    
    // Content Grouping
    public static let div = CSSSelector("div")
    public static let p = CSSSelector("p")
    public static let hr = CSSSelector("hr")
    public static let pre = CSSSelector("pre")
    public static let blockquote = CSSSelector("blockquote")
    public static let ol = CSSSelector("ol")
    public static let ul = CSSSelector("ul")
    public static let li = CSSSelector("li")
    public static let dl = CSSSelector("dl")
    public static let dt = CSSSelector("dt")
    public static let dd = CSSSelector("dd")
    
    // Text-level Semantics
    public static let a = CSSSelector("a")
    public static let span = CSSSelector("span")
    public static let strong = CSSSelector("strong")
    public static let em = CSSSelector("em")
    public static let b = CSSSelector("b")
    public static let i = CSSSelector("i")
    public static let u = CSSSelector("u")
    public static let s = CSSSelector("s")
    public static let code = CSSSelector("code")
    public static let kbd = CSSSelector("kbd")
    public static let mark = CSSSelector("mark")
    public static let small = CSSSelector("small")
    public static let sub = CSSSelector("sub")
    public static let sup = CSSSelector("sup")
    
    // Forms
    public static let form = CSSSelector("form")
    public static let input = CSSSelector("input")
    public static let button = CSSSelector("button")
    public static let select = CSSSelector("select")
    public static let option = CSSSelector("option")
    public static let textarea = CSSSelector("textarea")
    public static let label = CSSSelector("label")
    public static let fieldset = CSSSelector("fieldset")
    public static let legend = CSSSelector("legend")
    
    // Media
    public static let img = CSSSelector("img")
    public static let video = CSSSelector("video")
    public static let audio = CSSSelector("audio")
    public static let source = CSSSelector("source")
    public static let canvas = CSSSelector("canvas")
    public static let svg = CSSSelector("svg")
    public static let path = CSSSelector("path")
    public static let rect = CSSSelector("rect")
    public static let circle = CSSSelector("circle")
    public static let ellipse = CSSSelector("ellipse")
    public static let line = CSSSelector("line")
    public static let polygon = CSSSelector("polygon")
    public static let polyline = CSSSelector("polyline")
    
    // Tables
    public static let table = CSSSelector("table")
    public static let thead = CSSSelector("thead")
    public static let tbody = CSSSelector("tbody")
    public static let tfoot = CSSSelector("tfoot")
    public static let tr = CSSSelector("tr")
    public static let th = CSSSelector("th")
    public static let td = CSSSelector("td")
    public static let caption = CSSSelector("caption")
    public static let colgroup = CSSSelector("colgroup")
    public static let col = CSSSelector("col")
    
    // Interactive
    public static let details = CSSSelector("details")
    public static let summary = CSSSelector("summary")
    public static let dialog = CSSSelector("dialog")
    
    // Embedded Content
    public static let iframe = CSSSelector("iframe")
    public static let embed = CSSSelector("embed")
    public static let object = CSSSelector("object")
    public static let param = CSSSelector("param")
    
    // MARK: - Pseudo-elements
    
    // Common pseudo-elements
    public static let before = CSSSelector("::before")
    public static let after = CSSSelector("::after")
    public static let firstLine = CSSSelector("::first-line")
    public static let firstLetter = CSSSelector("::first-letter")
    public static let selection = CSSSelector("::selection")
    public static let placeholder = CSSSelector("::placeholder")
    public static let marker = CSSSelector("::marker")
    public static let backdrop = CSSSelector("::backdrop")
    
    // Webkit scrollbar pseudo-elements
    public static let webkitScrollbar = CSSSelector("::-webkit-scrollbar")
    public static let webkitScrollbarButton = CSSSelector("::-webkit-scrollbar-button")
    public static let webkitScrollbarTrack = CSSSelector("::-webkit-scrollbar-track")
    public static let webkitScrollbarTrackPiece = CSSSelector("::-webkit-scrollbar-track-piece")
    public static let webkitScrollbarThumb = CSSSelector("::-webkit-scrollbar-thumb")
    public static let webkitScrollbarCorner = CSSSelector("::-webkit-scrollbar-corner")
    public static let webkitResizer = CSSSelector("::-webkit-resizer")
}
