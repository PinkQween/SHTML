//
//  CSSProtocol.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public protocol CSS {
    func render() -> String
}

// CSS Selector - type-safe selector representation
public struct CSSSelector: ExpressibleByStringLiteral, Sendable {
    let value: String
    
    public init(_ value: String) {
        self.value = value
    }
    
    public init(stringLiteral value: String) {
        self.value = value
    }
    
    // Pseudo-class support
    public var hover: CSSSelector {
        CSSSelector("\(value):hover")
    }
    
    public var active: CSSSelector {
        CSSSelector("\(value):active")
    }
    
    public var focus: CSSSelector {
        CSSSelector("\(value):focus")
    }
    
    public var disabled: CSSSelector {
        CSSSelector("\(value):disabled")
    }
    
    public var firstChild: CSSSelector {
        CSSSelector("\(value):first-child")
    }
    
    public var lastChild: CSSSelector {
        CSSSelector("\(value):last-child")
    }
    
    public var nthChild: CSSSelector {
        CSSSelector("\(value):nth-child")
    }
    
    // Helper to get class name without dot
    public var className: String {
        value.replacingOccurrences(of: ".", with: "")
    }
    
    // MARK: - HTML Tag Selectors
    
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
}

// CSS Rule - represents a selector with properties
public struct CSSRule: CSS {
    let selector: String
    let properties: [CSSProperty]
    
    public init(_ selector: String, @CSSBuilder _ properties: () -> [CSSProperty]) {
        self.selector = selector
        self.properties = properties()
    }
    
    public init(_ selector: CSSSelector, @CSSBuilder _ properties: () -> [CSSProperty]) {
        self.selector = selector.value
        self.properties = properties()
    }
    
    public func render() -> String {
        let props = properties.map { $0.render() }.joined(separator: "\n    ")
        return "\(selector) {\n    \(props)\n}"
    }
}

// CSS Property - represents a single CSS property
public struct CSSProperty: CSS {
    let name: String
    let value: String
    
    public init(_ name: String, _ value: String) {
        self.name = name
        self.value = value
    }
    
    public func render() -> String {
        "\(name): \(value);"
    }
}

// Keyframes animation
public struct CSSKeyframes: CSS {
    let name: String
    let frames: [CSSKeyframe]
    
    public init(_ name: String, @CSSKeyframeBuilder _ frames: () -> [CSSKeyframe]) {
        self.name = name
        self.frames = frames()
    }
    
    public func render() -> String {
        let frameContent = frames.map { $0.render() }.joined(separator: "\n    ")
        return "@keyframes \(name) {\n    \(frameContent)\n}"
    }
}

public struct CSSKeyframe: CSS {
    let position: String
    let properties: [CSSProperty]
    
    public init(_ position: String, @CSSBuilder _ properties: () -> [CSSProperty]) {
        self.position = position
        self.properties = properties()
    }
    
    public func render() -> String {
        let props = properties.map { $0.render() }.joined(separator: " ")
        return "\(position) { \(props) }"
    }
}

// Stylesheet - collection of CSS rules
public struct Stylesheet: CSS {
    let rules: [CSS]
    
    public init(@CSSStyleBuilder _ rules: () -> [CSS]) {
        self.rules = rules()
    }
    
    public func render() -> String {
        rules.map { $0.render() }.joined(separator: "\n")
    }
}
