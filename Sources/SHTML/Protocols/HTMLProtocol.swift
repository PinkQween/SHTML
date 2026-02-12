public protocol HTML {
    func render() -> String
}

public extension HTML {
    var html: String { render() }

    func mount(to elementID: String) {
        JS.setInnerHTML(elementID: elementID, html: render())
    }
}
