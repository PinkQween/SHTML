import XCTest
@testable import SHTML

/// Tests for the routing system
final class RouterTests: XCTestCase {
    
    // MARK: - Route Tests
    
    func testSimpleRoute() {
        let route = Route(path: "/") {
            h1 { "Home" }
        }
        
        XCTAssertEqual(route.path, "/")
    }
    
    func testRouteWithContent() {
        let route = Route(path: "/about") {
            h1 { "About" }
            p { "About page content" }
        }
        
        let content = route.content()
        XCTAssertEqual(content.count, 2)
    }
    
    // MARK: - Router Tests
    
    func testRouterRendering() {
        let router = Router {
            Route(path: "/") {
                h1 { "Home" }
            }
        }
        
        let result = router.render()
        XCTAssertTrue(result.contains("<div class=\"router\">"))
        XCTAssertTrue(result.contains("data-path=\"/\""))
        XCTAssertTrue(result.contains("<h1>Home</h1>"))
    }
    
    func testMultipleRoutes() {
        let router = Router {
            Route(path: "/") {
                h1 { "Home" }
            }
            Route(path: "/about") {
                h1 { "About" }
            }
            Route(path: "/contact") {
                h1 { "Contact" }
            }
        }
        
        let result = router.render()
        XCTAssertTrue(result.contains("data-path=\"/\""))
        XCTAssertTrue(result.contains("data-path=\"/about\""))
        XCTAssertTrue(result.contains("data-path=\"/contact\""))
    }
    
    func testRouterWithFallback() {
        let router = Router {
            Route(path: "/") {
                h1 { "Home" }
            }
        } fallback: {
            h1 { "404 Not Found" }
            p { "Page not found" }
        }
        
        let result = router.render()
        XCTAssertTrue(result.contains("route-fallback"))
        XCTAssertTrue(result.contains("404 Not Found"))
    }
    
    func testRouterGeneratesJavaScript() {
        let router = Router {
            Route(path: "/") {
                h1 { "Home" }
            }
        }
        
        let result = router.render()
        XCTAssertTrue(result.contains("<script>"))
        XCTAssertTrue(result.contains("navigateToPath"))
        XCTAssertTrue(result.contains("addEventListener"))
    }
    
    func testWildcardRoute() {
        let router = Router {
            Route(path: "/blog/*") {
                h1 { "Blog Posts" }
            }
        }
        
        let result = router.render()
        XCTAssertTrue(result.contains("data-path=\"/blog/*\""))
    }

    func testDynamicPathParamRoute() {
        let router = Router {
            Route(path: "/users/:id") {
                h1 { "User Profile" }
            }
        }

        let result = router.render()
        XCTAssertTrue(result.contains("data-path=\"/users/:id\""))
        XCTAssertTrue(result.contains("routeSegment.startsWith(':')"))
    }

    func testRouterGeneratesQueryAndParamState() {
        let router = Router {
            Route(path: "/search") {
                h1 { "Search" }
            }
        }

        let result = router.render()
        XCTAssertTrue(result.contains("parseQuery"))
        XCTAssertTrue(result.contains("window.routeParams"))
        XCTAssertTrue(result.contains("window.queryParams"))
        XCTAssertTrue(result.contains("new URL(target, window.location.origin)"))
        XCTAssertTrue(result.contains("shtml:routechange"))
    }
    
    // MARK: - RouterLink Tests
    
    func testRouterLink() {
        let link = RouterLink(to: "/about") { "About Us" }
        let result = link.render()
        
        XCTAssertTrue(result.contains("<a"))
        XCTAssertTrue(result.contains("href=\"/about\""))
        XCTAssertTrue(result.contains("About Us"))
    }
    
    func testRouterLinkWithModifiers() {
        let link = RouterLink(to: "/") { "Home" }
            .class("nav-link")
        
        let result = link.render()
        XCTAssertTrue(result.contains("class=\"nav-link\""))
        XCTAssertTrue(result.contains("href=\"/\""))
    }
    
    func testRouterLinkGeneratesClickHandler() {
        let link = RouterLink(to: "/test") { "Test" }
        let result = link.render()
        
        XCTAssertTrue(result.contains("onclick"))
        XCTAssertTrue(result.contains("window.navigate"))
        XCTAssertTrue(result.contains("/test"))
    }
    
    // MARK: - Integration Tests
    
    func testCompleteRouterSetup() {
        let router = Router {
            Route(path: "/") {
                h1 { "Home" }
                RouterLink(to: "/about") { "Go to About" }
            }
            
            Route(path: "/about") {
                h1 { "About" }
                RouterLink(to: "/") { "Go to Home" }
            }
        } fallback: {
            h1 { "404" }
            RouterLink(to: "/") { "Back to Home" }
        }
        
        let result = router.render()
        
        // Check routes exist
        XCTAssertTrue(result.contains("data-path=\"/\""))
        XCTAssertTrue(result.contains("data-path=\"/about\""))
        
        // Check navigation links
        XCTAssertTrue(result.contains("Go to About"))
        XCTAssertTrue(result.contains("Go to Home"))
        XCTAssertTrue(result.contains("Back to Home"))
        
        // Check JavaScript
        XCTAssertTrue(result.contains("navigateToPath"))
        XCTAssertTrue(result.contains("window.navigate"))
        
        // Check fallback
        XCTAssertTrue(result.contains("route-fallback"))
    }
    
    func testRouterHidesRoutesInitially() {
        let router = Router {
            Route(path: "/test") {
                h1 { "Test" }
            }
        }
        
        let result = router.render()
        XCTAssertTrue(result.contains("display: none"))
    }
}
