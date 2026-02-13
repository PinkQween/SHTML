public struct Image: HTMLPrimitive, HTMLModifiable {
    public typealias Body = Never
    
    public var src: String
    public var alt: String
    
    public init(src: ImageName, alt: String = "") {
        self.src = src.path
        self.alt = alt
    }
    
    public func render() -> String {
        let attrs = HTMLRendering.renderAttributes(attributes)
        return {
                img(src: src, alt: alt)
        }
    }
}

public typealias img = Img
