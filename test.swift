import SHTML

struct MyWebsite: Website {
    let server: CSSSelector = ".server"
    
    var content: some HTML {
        html {
            head {
                meta().charset("UTF-8")
                title("SHTML Site")
                Style {
                    CSSRule(.body) {
                        background(#hex("121218"))
                        minHeight(100.vh)
                        maxHeight(100.vh)
                        padding(0)
                        margin(0)
                        overflow(.hidden)
                    }
                    
                    CSSRule(server) {
                        transition(.all(duration: 250.ms, timing: .easeInOut))
                        cursor(.pointer)
                        borderRadius(50.percent)
                        overflow(.hidden)
                        background(.snow)
                    }
                    
                    CSSRule(server.hover) {
                        borderRadius(13.percent)
                    }
                }
            }
            body {
                HStack {
                    Div {
                        SVG {
                            Rect()
                                .fill(#hex("2a2a3e"))
                        }
                        .positionedFill()

                        VStack(spacing: 3.px) {
                            ForEach(1...100) { _ in
                                Div()
                                    .class(server)
                                    .width(3.rem)
                                    .height(3.rem)
                            }
                        }
                        .overflowY(.auto)
                        .maxHeight(100.vh)
                        .width(100.percent)
                        .padding(0.5.rem)
                        .position(.relative)
                        .zIndex(1)
                    }
                    .frame(width: 4.rem)
                    .position(.relative)
                }
                .frame(height: 100.vh)
                .overflow(.hidden)
            }
        }
    }
}

let site = MyWebsite()
print(site.generate())
