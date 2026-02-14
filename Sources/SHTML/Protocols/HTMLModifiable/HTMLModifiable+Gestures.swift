// SwiftUI-style gesture convenience modifiers for HTML elements

public extension HTMLModifiable {
    /// Handles tap-like interaction using click / double-click DOM events.
    func onTapGesture(count: Int = 1, perform action: String) -> Self {
        if count <= 1 {
            return onclick(action)
        }
        if count == 2 {
            return ondblclick(action)
        }
        return onclick("if ((event.detail || 0) >= \(count)) { \(action) }")
    }

    /// Handles pointer hover enter/leave.
    func onHover(enter: String, leave: String = "") -> Self {
        var copy = self
        copy = copy.appendingEventHandler(named: "onmouseenter", script: enter)
        if !leave.isEmpty {
            copy = copy.appendingEventHandler(named: "onmouseleave", script: leave)
        }
        return copy
    }

    /// Applies CSS declarations while hovered, then restores the previous inline style.
    func onHoverCSS(_ css: CSS...) -> Self {
        let declarations = hoverCSSDeclarations(css)
        return onHoverCSS(withDeclarations: declarations)
    }

    /// Applies CSS declarations while hovered, then restores the previous inline style.
    func onHoverCSS(@CSSBuilder _ css: () -> [CSS]) -> Self {
        let declarations = hoverCSSDeclarations(css())
        return onHoverCSS(withDeclarations: declarations)
    }

    private func onHoverCSS(withDeclarations declarations: String) -> Self {
        guard !declarations.isEmpty else { return self }
        let escaped = escapeForSingleQuotedJS(declarations)
        let enter = """
        this.__shtmlHoverPrevStyle = this.getAttribute('style') || '';
        this.style.cssText = this.__shtmlHoverPrevStyle;
        this.style.cssText += (this.style.cssText && !this.style.cssText.trim().endsWith(';') ? '; ' : '') + '\(escaped)';
        """
        let leave = """
        if (this.__shtmlHoverPrevStyle !== undefined) {
            this.setAttribute('style', this.__shtmlHoverPrevStyle);
            this.__shtmlHoverPrevStyle = undefined;
        }
        """

        var copy = self
        copy = copy.appendingEventHandler(named: "onmouseenter", script: enter)
        copy = copy.appendingEventHandler(named: "onmouseleave", script: leave)
        return copy
    }

    /// Handles drag updates and optional drag end, and enables dragging.
    func onDragGesture(onChanged: String, onEnded: String = "") -> Self {
        var copy = self
        let startScript = "this.__shtmlDragGestureActive = true;"
        let moveScript = "if (!this.__shtmlDragGestureActive) { return; } \(onChanged)"

        let endScript: String
        if onEnded.isEmpty {
            endScript = "if (!this.__shtmlDragGestureActive) { return; } this.__shtmlDragGestureActive = false;"
        } else {
            endScript = "if (!this.__shtmlDragGestureActive) { return; } this.__shtmlDragGestureActive = false; \(onEnded)"
        }

        copy = copy.appendingEventHandler(named: "onpointerdown", script: startScript)
        copy = copy.appendingEventHandler(named: "onpointermove", script: moveScript)
        copy = copy.appendingEventHandler(named: "onpointerup", script: endScript)
        copy = copy.appendingEventHandler(named: "onpointercancel", script: endScript)
        copy = copy.appendingEventHandler(named: "onpointerleave", script: endScript)
        return copy
    }

    /// Handles drag updates using SHTML JavaScript DSL.
    func onDragGesture(onChanged: any JavaScript, onEnded: (any JavaScript)? = nil) -> Self {
        onDragGesture(onChanged: onChanged.render(), onEnded: onEnded?.render() ?? "")
    }

    /// Handles drag updates using JSBuilder.
    func onDragGesture(@JSBuilder onChanged: () -> [any JavaScript]) -> Self {
        onDragGesture(onChanged: JSRendering.renderStatements(onChanged), onEnded: "")
    }

    /// Handles drag updates/end using JSBuilder.
    func onDragGesture(
        @JSBuilder onChanged: () -> [any JavaScript],
        @JSBuilder onEnded: () -> [any JavaScript]
    ) -> Self {
        onDragGesture(
            onChanged: JSRendering.renderStatements(onChanged),
            onEnded: JSRendering.renderStatements(onEnded)
        )
    }

    /// Handles long-press by scheduling action after the minimum duration.
    func onLongPressGesture(minimumDuration: Double = 0.5, perform action: String) -> Self {
        var copy = self
        let durationMs = max(0, Int((minimumDuration * 1000.0).rounded()))
        let startScript = "this.__shtmlLongPressTimer = setTimeout(function(){ \(action) }, \(durationMs));"
        let clearScript = "if (this.__shtmlLongPressTimer) { clearTimeout(this.__shtmlLongPressTimer); this.__shtmlLongPressTimer = null; }"

        copy = copy.appendingEventHandler(named: "onmousedown", script: startScript)
        copy = copy.appendingEventHandler(named: "onmouseup", script: clearScript)
        copy = copy.appendingEventHandler(named: "onmouseleave", script: clearScript)
        copy = copy.appendingEventHandler(named: "ontouchstart", script: startScript)
        copy = copy.appendingEventHandler(named: "ontouchend", script: clearScript)
        copy = copy.appendingEventHandler(named: "ontouchcancel", script: clearScript)
        return copy
    }

    /// Merges a new script into an event attribute without removing existing handlers.
    private func appendingEventHandler(named attribute: String, script: String) -> Self {
        guard !script.isEmpty else { return self }
        var copy = self
        if let existing = copy.attributes[attribute], !existing.isEmpty {
            copy.attributes[attribute] = "\(existing); \(script)"
        } else {
            copy.attributes[attribute] = script
        }
        return copy
    }

    private func hoverCSSDeclarations(_ values: [CSS]) -> String {
        var declarations: [String] = []
        for value in values {
            if let property = value as? CSSProperty {
                declarations.append("\(property.name): \(property.value)")
                continue
            }
            if let group = value as? CSSPropertyGroup {
                for property in group.properties {
                    declarations.append("\(property.name): \(property.value)")
                }
            }
        }
        return declarations.joined(separator: "; ")
    }

    private func escapeForSingleQuotedJS(_ value: String) -> String {
        value
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "'", with: "\\'")
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\r", with: " ")
    }
}
