public struct Router: HTML {
    private let routes: [Route]
    private let fallback: (() -> [any HTML])?
    
    public init(
        @RouteBuilder routes: () -> [Route],
        @HTMLBuilder fallback: @escaping () -> [any HTML] = { [] }
    ) {
        self.routes = routes()
        self.fallback = fallback
    }
    
    public func render() -> String {
        let routeElements = routes.map { route in
            """
            <div class="route" data-path="\(route.path)" style="display: none;">
            \(route.content().map { $0.render() }.joined())
            </div>
            """
        }.joined()
        
        let fallbackElement = """
        <div class="route-fallback" style="display: none;">
        \(fallback?().map { $0.render() }.joined() ?? "")
        </div>
        """
        
        return """
        <div class="router">
        \(routeElements)
        \(fallbackElement)
        \(renderScript())
        </div>
        """
    }
    
    private func renderScript() -> String {
        script {
            JSFunc(params: ["path"]) {
                const("routes", .raw("document.querySelectorAll('.router .route')"))
                const("fallback", .raw("document.querySelector('.router .route-fallback')"))
                let_("matched", .bool(false))
                
                JSRaw("""
                routes.forEach(route => {
                    const routePath = route.getAttribute('data-path');
                    if (routePath === path || (routePath.endsWith('*') && path.startsWith(routePath.slice(0, -1)))) {
                        route.style.display = 'block';
                        matched = true;
                    } else {
                        route.style.display = 'none';
                    }
                });
                
                if (!matched && fallback) {
                    fallback.style.display = 'block';
                } else if (fallback) {
                    fallback.style.display = 'none';
                }
                """)
            }
            
            JSRaw("""
            window.addEventListener('popstate', () => {
                navigateToPath(window.location.pathname);
            });
            
            window.navigate = function(path, replace = false) {
                if (replace) {
                    window.history.replaceState({}, '', path);
                } else {
                    window.history.pushState({}, '', path);
                }
                navigateToPath(path);
            };
            
            navigateToPath(window.location.pathname);
            """)
        }.render()
    }
}
