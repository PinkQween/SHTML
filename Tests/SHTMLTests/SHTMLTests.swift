import Testing
@testable import SHTML

@Test
func swiftUILikeCompositionRendersExpectedHTML() {
    let showSubtitle = true

    let html = Body {
        H1 { "Welcome" }

        if showSubtitle {
            H2 { Text("Build <safe> HTML") }
        }

        A {
            "Docs"
        }
        .href("https://example.com?q=swift&lang=en")
        .target("_blank")
        .rel("noopener")

        for index in 1...2 {
            H2 { "Section \(index)" }
        }

        Br()
        "Done"
    }
    .render()

    #expect(
        html ==
            "<body><h1>Welcome</h1><h2>Build &lt;safe&gt; HTML</h2><a href=\"https://example.com?q=swift&amp;lang=en\" rel=\"noopener\" target=\"_blank\">Docs</a><h2>Section 1</h2><h2>Section 2</h2><br />Done</body>"
    )
}

@Test
func lowercaseAPIStillWorks() {
    let html = body {
        h1 { "Legacy API" }
        a { "Click" }.href("/home")
    }
    .render()

    #expect(html == "<body><h1>Legacy API</h1><a href=\"/home\">Click</a></body>")
}

@Test
func mountCompilesInNonWasmTargets() {
    Body {
        H1 { "Mounted" }
    }
    .mount(to: "app")

    #expect(Bool(true))
}
