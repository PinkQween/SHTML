//
//  HTMLModifiable+Scrollbar.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/13/26.
//

public extension HTMLModifiable {
    /// Set scrollbar width (CSS scrollbar-width property)
    func scrollbarWidth(_ value: ScrollbarWidth) -> Self {
        appendingStyle("scrollbar-width: \(value.rawValue)")
    }
    
    /// Set scrollbar width with custom value
    func scrollbarWidth(_ value: String) -> Self {
        appendingStyle("scrollbar-width: \(value)")
    }
    
    /// Set scrollbar width with length value
    func scrollbarWidth(_ value: any CSSLengthConvertible) -> Self {
        appendingStyle("scrollbar-width: \(value.cssLength)")
    }
    
    /// Set scrollbar color (thumb and track)
    func scrollbarColor(_ thumbColor: Color, _ trackColor: Color) -> Self {
        appendingStyle("scrollbar-color: \(thumbColor.css) \(trackColor.css)")
    }
    
    /// Set scrollbar color with single color
    func scrollbarColor(_ color: Color) -> Self {
        appendingStyle("scrollbar-color: \(color.css)")
    }
    
    /// Set scrollbar color with string
    func scrollbarColor(_ value: String) -> Self {
        appendingStyle("scrollbar-color: \(value)")
    }
    
    /// Set scrollbar gutter
    func scrollbarGutter(_ value: ScrollbarGutter) -> Self {
        appendingStyle("scrollbar-gutter: \(value.rawValue)")
    }
    
    /// Set scrollbar gutter with string
    func scrollbarGutter(_ value: String) -> Self {
        appendingStyle("scrollbar-gutter: \(value)")
    }
}
