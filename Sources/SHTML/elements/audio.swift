/// Audio type.
public struct Audio: HTMLPrimitive, HTMLModifiable {
    /// Type alias.
    public typealias Content = Never

    /// Property.
    public var attributes: [String: String]

    /// Creates a new instance.
    public init(src: String) {
        self.attributes = ["src": src]
    }

    /// Creates a new instance.
    public init(_ name: AudioName) {
        self.attributes = ["src": name.path]
    }

    /// render function.
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        return "<audio\(attrs)></audio>"
    }

    /// controls function.
    public func controls(_ value: Bool = true) -> Self {
        var copy = self
        if value { copy.attributes["controls"] = "" } else { copy.attributes.removeValue(forKey: "controls") }
        return copy
    }

    /// autoplay function.
    public func autoplay(_ value: Bool = true) -> Self {
        var copy = self
        if value { copy.attributes["autoplay"] = "" } else { copy.attributes.removeValue(forKey: "autoplay") }
        return copy
    }

    /// loop function.
    public func loop(_ value: Bool = true) -> Self {
        var copy = self
        if value { copy.attributes["loop"] = "" } else { copy.attributes.removeValue(forKey: "loop") }
        return copy
    }

    /// muted function.
    public func muted(_ value: Bool = true) -> Self {
        var copy = self
        if value { copy.attributes["muted"] = "" } else { copy.attributes.removeValue(forKey: "muted") }
        return copy
    }

    /// preload function.
    public func preload(_ value: String) -> Self {
        var copy = self
        copy.attributes["preload"] = value
        return copy
    }
}

/// Type alias.
public typealias audio = Audio
