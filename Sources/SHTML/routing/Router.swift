/// A client-side router that renders the matching route for the current URL.
public struct Router: HTML {
    private let routes: [Route]
    private let fallback: (() -> [any HTML])?
    
    /// Creates a router with route definitions and optional fallback content.
    public init(
        @RouteBuilder routes: () -> [Route],
        @HTMLBuilder fallback: @escaping () -> [any HTML] = { [] }
    ) {
        self.routes = routes()
        self.fallback = fallback
    }
    
    /// Renders the router container, route nodes, and client-side navigation script.
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
            JSRaw("""
            function safeDecode(value) {
                try {
                    return decodeURIComponent(value);
                } catch (_) {
                    return value;
                }
            }

            function parseQuery(search) {
                const params = {};
                const query = search.startsWith('?') ? search.slice(1) : search;
                if (!query) return params;
                
                query.split('&').forEach(pair => {
                    if (!pair) return;
                    const [rawKey, rawValue = ''] = pair.split('=');
                    const key = safeDecode(rawKey || '');
                    const value = safeDecode(rawValue || '');
                    if (!key) return;
                    
                    if (Object.prototype.hasOwnProperty.call(params, key)) {
                        const current = params[key];
                        if (Array.isArray(current)) {
                            current.push(value);
                        } else {
                            params[key] = [current, value];
                        }
                    } else {
                        params[key] = value;
                    }
                });
                
                return params;
            }
            
            function normalizePath(path) {
                if (!path) return '/';
                if (path.length > 1 && path.endsWith('/')) {
                    return path.slice(0, -1);
                }
                return path;
            }
            
            function matchRoute(routePath, currentPath) {
                const normalizedRoute = normalizePath(routePath);
                const normalizedPath = normalizePath(currentPath);
                const params = {};
                
                if (normalizedRoute === normalizedPath) {
                    return { matched: true, params };
                }
                
                if (normalizedRoute.endsWith('*')) {
                    const prefix = normalizePath(normalizedRoute.slice(0, -1));
                    if (normalizedPath.startsWith(prefix)) {
                        return { matched: true, params };
                    }
                }
                
                const routeSegments = normalizedRoute.split('/').filter(Boolean);
                const pathSegments = normalizedPath.split('/').filter(Boolean);
                
                if (routeSegments.length !== pathSegments.length) {
                    return { matched: false, params: {} };
                }
                
                for (let i = 0; i < routeSegments.length; i++) {
                    const routeSegment = routeSegments[i];
                    const pathSegment = pathSegments[i];
                    
                    if (routeSegment.startsWith(':')) {
                        const key = routeSegment.slice(1);
                        if (!key) {
                            return { matched: false, params: {} };
                        }
                        params[key] = safeDecode(pathSegment);
                        continue;
                    }
                    
                    if (routeSegment !== pathSegment) {
                        return { matched: false, params: {} };
                    }
                }
                
                return { matched: true, params };
            }
            
            function navigateToPath(target) {
                let path = '/';
                let query = {};
                
                try {
                    const url = new URL(target, window.location.origin);
                    path = url.pathname;
                    query = parseQuery(url.search);
                } catch (_) {
                    const raw = String(target || '/');
                    const qIndex = raw.indexOf('?');
                    if (qIndex >= 0) {
                        path = raw.slice(0, qIndex) || '/';
                        query = parseQuery(raw.slice(qIndex));
                    } else {
                        path = raw || '/';
                    }
                }
                const routes = document.querySelectorAll('.router .route');
                const fallback = document.querySelector('.router .route-fallback');
                let matched = false;
                let routeParams = {};
                
                routes.forEach(route => {
                    const routePath = route.getAttribute('data-path') || '';
                    const result = matchRoute(routePath, path);
                    
                    if (result.matched) {
                        route.style.display = 'block';
                        matched = true;
                        routeParams = result.params;
                    } else {
                        route.style.display = 'none';
                    }
                });
                
                window.routeParams = routeParams;
                window.queryParams = query;
                window.currentPath = path;
                window.dispatchEvent(new CustomEvent('shtml:routechange', {
                    detail: { path, params: routeParams, query }
                }));
                
                if (!matched && fallback) {
                    fallback.style.display = 'block';
                } else if (fallback) {
                    fallback.style.display = 'none';
                }
            }
            
            window.addEventListener('popstate', () => {
                navigateToPath(window.location.pathname + window.location.search);
            });
            
            window.navigate = function(path, replace = false) {
                if (replace) {
                    window.history.replaceState({}, '', path);
                } else {
                    window.history.pushState({}, '', path);
                }
                navigateToPath(path);
            };
            
            navigateToPath(window.location.pathname + window.location.search);
            """)
        }.render()
    }
}
