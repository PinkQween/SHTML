use notify::{Config, RecommendedWatcher, RecursiveMode, Watcher};
use std::{
    collections::HashMap,
    fs,
    io::{self, BufRead, BufReader, Write},
    net::{TcpListener, TcpStream},
    path::Path,
    process::Command,
    sync::{
        atomic::{AtomicBool, Ordering},
        Arc, Mutex,
    },
    thread,
    time::Duration,
};

// Global channels for SSE broadcasting
lazy_static::lazy_static! {
    static ref SSE_CLIENTS: Mutex<Vec<std::sync::mpsc::Sender<String>>> = Mutex::new(Vec::new());
}

#[derive(Debug, Clone)]
enum BuildStatus {
    Building,
    Success,
    Failed(String),
}

static BUILD_STATUS: Mutex<Option<BuildStatus>> = Mutex::new(None);

#[derive(Debug, Clone)]
struct Request {
    method: String,
    path: String,
    headers: HashMap<String, String>,
}

struct Response {
    status: u16,
    headers: HashMap<String, String>,
    body: Vec<u8>,
}

impl Response {
    fn new(status: u16) -> Self {
        Self {
            status,
            headers: HashMap::new(),
            body: Vec::new(),
        }
    }

    fn html(mut self, content: &str) -> Self {
        self.body = content.as_bytes().to_vec();
        self.headers
            .insert("Content-Type".into(), "text/html; charset=utf-8".into());
        self
    }

    fn js(mut self, content: &str) -> Self {
        self.body = content.as_bytes().to_vec();
        self.headers
            .insert("Content-Type".into(), "application/javascript".into());
        self
    }

    fn text(mut self, content: &str) -> Self {
        self.body = content.as_bytes().to_vec();
        self.headers
            .insert("Content-Type".into(), "text/plain".into());
        self
    }
}

pub fn start_server(port: u16) -> io::Result<()> {
    println!("╔═══════════════════════════════════════════╗");
    println!("║  🚀 SHTML Live Development Server        ║");
    println!("╚═══════════════════════════════════════════╝\n");

    set_build_status(BuildStatus::Building);
    build_swift_package();

    // Start file watcher in background thread
    thread::spawn(|| {
        if let Err(e) = start_file_watcher() {
            eprintln!("❌ File watcher error: {}", e);
        }
    });

    thread::sleep(Duration::from_millis(100));

    let listener = TcpListener::bind(format!("127.0.0.1:{}", port))?;
    listener.set_nonblocking(false)?;
    
    println!("╔═══════════════════════════════════════════╗");
    println!("║  🌐 Server Ready                          ║");
    println!("╚═══════════════════════════════════════════╝");
    println!("  URL: http://127.0.0.1:{}", port);
    println!("  Press Ctrl+C to stop\n");

    for stream in listener.incoming() {
        match stream {
            Ok(stream) => {
                thread::spawn(move || {
                    if let Err(e) = handle_connection(stream) {
                        eprintln!("Connection error: {}", e);
                    }
                });
            }
            Err(e) => eprintln!("Accept error: {}", e),
        }
    }

    Ok(())
}

fn set_build_status(status: BuildStatus) {
    if let Ok(mut guard) = BUILD_STATUS.lock() {
        *guard = Some(status);
    }
}

fn broadcast_reload() {
    if let Ok(mut clients) = SSE_CLIENTS.lock() {
        clients.retain(|sender| {
            sender.send("reload".to_string()).is_ok()
        });
    }
}

fn get_build_status() -> Option<BuildStatus> {
    BUILD_STATUS.lock().ok()?.clone()
}

fn build_swift_package() -> bool {
    println!("╔═══════════════════════════════════════════╗");
    println!("║  🔨 Building...                           ║");
    println!("╚═══════════════════════════════════════════╝");
    
    let start = std::time::Instant::now();
    
    let output = Command::new("swift")
        .arg("build")
        .output()
        .expect("Failed to run swift build");

    if !output.status.success() {
        let stderr = String::from_utf8_lossy(&output.stderr);
        let stdout = String::from_utf8_lossy(&output.stdout);
        
        println!("\n╔═══════════════════════════════════════════╗");
        println!("║  ❌ Build Failed                          ║");
        println!("╚═══════════════════════════════════════════╝");
        eprintln!("{}", stderr);
        
        let error_msg = if !stderr.trim().is_empty() {
            stderr.to_string()
        } else if !stdout.trim().is_empty() {
            stdout.to_string()
        } else {
            "Build failed with no output.".to_string()
        };
        
        set_build_status(BuildStatus::Failed(format!("Build Error:\n\n{}", error_msg)));
        return false;
    }
    
    println!("  ✅ Compilation successful ({:.1}s)", start.elapsed().as_secs_f32());
    
    // Run the executable to generate HTML
    let output = Command::new("swift")
        .arg("run")
        .output()
        .expect("Failed to run swift run");
    
    let stdout = String::from_utf8_lossy(&output.stdout);
    let stderr = String::from_utf8_lossy(&output.stderr);
    
    if output.status.success() {
        println!("  ✅ HTML generated ({:.1}s total)", start.elapsed().as_secs_f32());
        
        if let Ok(metadata) = fs::metadata("public/index.html") {
            let size = metadata.len();
            let size_str = if size < 1024 {
                format!("{} B", size)
            } else if size < 1024 * 1024 {
                format!("{:.1} KB", size as f64 / 1024.0)
            } else {
                format!("{:.2} MB", size as f64 / (1024.0 * 1024.0))
            };
            println!("  📊 {}", size_str);
        }
        
        // Copy Assets to public if they exist
        if Path::new("Assets").exists() {
            let _ = fs::remove_dir_all("public/Assets");
            if let Err(e) = copy_dir_all("Assets", "public/Assets") {
                eprintln!("  ⚠️  Warning: Failed to copy assets: {}", e);
            }
        }
        
        println!("\n╔═══════════════════════════════════════════╗");
        println!("║  ✅ Build Complete!                       ║");
        println!("╚═══════════════════════════════════════════╝\n");
        
        set_build_status(BuildStatus::Success);
        true
    } else {
        println!("\n╔═══════════════════════════════════════════╗");
        println!("║  ❌ HTML Generation Failed                ║");
        println!("╚═══════════════════════════════════════════╝");
        
        if !stdout.trim().is_empty() {
            println!("{}", stdout);
        }
        if !stderr.trim().is_empty() {
            eprintln!("{}", stderr);
        }
        
        let mut error_parts = Vec::new();
        if !stdout.trim().is_empty() {
            error_parts.push(format!("Output:\n{}", stdout));
        }
        if !stderr.trim().is_empty() {
            error_parts.push(format!("Errors:\n{}", stderr));
        }
        
        let full_output = if error_parts.is_empty() {
            "Generation failed with no output.".to_string()
        } else {
            format!("Generation Error:\n\n{}", error_parts.join("\n\n"))
        };
        
        set_build_status(BuildStatus::Failed(full_output));
        false
    }
}

// Silent version for TUI mode - no console output
fn build_swift_package_silent() -> bool {
    // Ensure public directory exists
    let _ = fs::create_dir_all("public");
    
    let output = Command::new("swift")
        .arg("build")
        .stdout(std::process::Stdio::null())
        .stderr(std::process::Stdio::null())
        .output()
        .expect("Failed to run swift build");

    if !output.status.success() {
        return false;
    }
    
    // Run the executable to generate HTML (it writes to public/index.html via SHTML framework)
    let output = Command::new("swift")
        .arg("run")
        .stdout(std::process::Stdio::null())
        .stderr(std::process::Stdio::null())
        .output()
        .expect("Failed to run swift run");
    
    if !output.status.success() {
        return false;
    }
    
    // Copy Assets to public if they exist
    if std::path::Path::new("Assets").exists() {
        let _ = fs::remove_dir_all("public/Assets");
        let _ = copy_dir_all("Assets", "public/Assets");
    }
    
    true
}

fn start_file_watcher() -> notify::Result<()> {
    use notify::{Event, PollWatcher};
    
    println!("🔧 Initializing file watcher (polling mode for macOS compatibility)...");
    
    let (tx, rx) = std::sync::mpsc::channel::<notify::Result<Event>>();
    
    // Use PollWatcher to avoid macOS focus issues
    let config = Config::default()
        .with_poll_interval(Duration::from_millis(500));
    
    let mut watcher = PollWatcher::new(tx, config)?;

    watcher.watch(Path::new("Sources"), RecursiveMode::Recursive)?;
    
    println!("✅ File watcher active (no terminal focus required)\n");

    let last_build = Arc::new(Mutex::new(std::time::Instant::now()));

    loop {
        match rx.recv() {
            Ok(Ok(event)) => {
                // Filter out certain file types
                let should_skip = event.paths.iter().any(|path| {
                    let path_str = path.to_string_lossy();
                    path_str.ends_with(".swp") 
                        || path_str.ends_with("~") 
                        || path_str.contains(".git")
                        || path_str.contains("/.build/")
                });
                
                if should_skip {
                    continue;
                }
                
                let mut last = last_build.lock().unwrap();
                let now = std::time::Instant::now();
                
                // Debounce
                if now.duration_since(*last) < Duration::from_millis(300) {
                    continue;
                }
                
                *last = now;
                drop(last);

                // Log the file change
                if let Some(path) = event.paths.first() {
                    println!("\n╔═══════════════════════════════════════════╗");
                    println!("║  🔔 File Changed                          ║");
                    println!("╚═══════════════════════════════════════════╝");
                    println!("📄 {}\n", path.display());
                }

                // Set building status (but don't broadcast yet)
                set_build_status(BuildStatus::Building);
                
                // Build
                if build_swift_package() {
                    // Only broadcast once after complete success
                    broadcast_reload();
                } else {
                    // Only broadcast once to show error
                    broadcast_reload();
                }
            }
            Ok(Err(e)) => {
                eprintln!("Watch error: {:?}", e);
            }
            Err(e) => {
                eprintln!("Channel error: {:?}", e);
                break;
            }
        }
    }

    Ok(())
}

fn handle_connection(mut stream: TcpStream) -> io::Result<()> {
    stream.set_read_timeout(Some(Duration::from_secs(10)))?;
    let mut reader = BufReader::new(stream.try_clone()?);

    let req = match read_request(&mut reader) {
        Ok(Some(r)) => r,
        Ok(None) => return Ok(()),
        Err(_) => {
            write_response(&mut stream, Response::new(400).text("Bad Request"))?;
            return Ok(());
        }
    };

    // Special handling for SSE endpoint
    if req.path == "/events" {
        return handle_sse_connection(stream);
    }

    let resp = handle_request(&req);
    write_response(&mut stream, resp)?;
    Ok(())
}

fn handle_sse_connection(mut stream: TcpStream) -> io::Result<()> {
    // Set no timeout for SSE connections
    stream.set_read_timeout(None)?;
    stream.set_write_timeout(Some(Duration::from_secs(5)))?;
    
    // Send SSE headers
    let headers = "HTTP/1.1 200 OK\r\n\
                   Content-Type: text/event-stream\r\n\
                   Cache-Control: no-cache\r\n\
                   Connection: keep-alive\r\n\
                   X-Accel-Buffering: no\r\n\
                   \r\n";
    stream.write_all(headers.as_bytes())?;
    stream.flush()?;
    
    // Send initial connection event
    stream.write_all(b"data: connected\n\n")?;
    stream.flush()?;
    
    // Create channel for this client
    let (tx, rx) = std::sync::mpsc::channel();
    
    // Register client
    if let Ok(mut clients) = SSE_CLIENTS.lock() {
        clients.push(tx);
    }
    
    // Keep connection alive and send events
    loop {
        match rx.recv_timeout(Duration::from_secs(30)) {
            Ok(msg) => {
                let event = format!("data: {}\n\n", msg);
                if stream.write_all(event.as_bytes()).is_err() {
                    break;
                }
                if stream.flush().is_err() {
                    break;
                }
            }
            Err(std::sync::mpsc::RecvTimeoutError::Timeout) => {
                // Send keepalive
                if stream.write_all(b": keepalive\n\n").is_err() {
                    break;
                }
                stream.flush().ok();
            }
            Err(_) => break,
        }
    }
    
    Ok(())
}

fn handle_request(req: &Request) -> Response {
    match req.path.as_str() {
        "/" => serve_generated_html(),
        "/events" => {
            // SSE endpoint - keep connection open
            Response::new(200).text("") // Placeholder, handled specially
        }
        "/build-status" => {
            let mut resp = match get_build_status() {
                Some(BuildStatus::Building) => Response::new(200).text("building"),
                Some(BuildStatus::Success) => Response::new(200).text("success"),
                Some(BuildStatus::Failed(_)) => Response::new(200).text("failed"),
                None => Response::new(200).text("unknown"),
            };
            resp.headers.insert("Cache-Control".into(), "no-cache".into());
            resp
        }
        _ => {
            // Try to serve static file from public directory
            let file_path = format!("public{}", req.path);
            let static_response = serve_static_file(&file_path);
            if static_response.status != 404 {
                return static_response;
            }

            // SPA fallback: serve generated HTML for client-side routes
            let path = req.path.split('?').next().unwrap_or(&req.path);
            let looks_like_file = path.rsplit('/').next().unwrap_or("").contains('.');
            if !looks_like_file {
                return serve_generated_html();
            }

            static_response
        }
    }
}

fn serve_generated_html() -> Response {
    // Check build status first
    match get_build_status() {
        Some(BuildStatus::Building) => serve_building_page(),
        Some(BuildStatus::Failed(error)) => serve_error_page(&error),
        _ => {
            match fs::read_to_string("public/index.html") {
                Ok(html) => {
                    // Inject SSE live reload script
                    let injected = if html.contains("</body>") {
                        html.replace("</body>", &format!(r#"
<script>
console.log('🔧 SHTML Live Reload (SSE) initializing...');
const evtSource = new EventSource('/events');
evtSource.onopen = () => console.log('✅ SSE connected');
evtSource.onmessage = (e) => {{
    console.log('📡 SSE event:', e.data);
    if (e.data === 'reload') {{
        console.log('🔄 RELOADING NOW!');
        location.reload();
    }}
}};
evtSource.onerror = (e) => {{
    console.error('❌ SSE error:', e);
    setTimeout(() => location.reload(), 1000);
}};

// Status bar
const bar = document.createElement('div');
bar.style.cssText = 'position:fixed;bottom:20px;right:20px;padding:10px 20px;border-radius:20px;font-family:system-ui;font-size:14px;font-weight:600;color:white;background:#4caf50;box-shadow:0 4px 12px rgba(0,0,0,0.15);z-index:999999;cursor:pointer;';
bar.textContent = '● Live';
bar.onclick = () => bar.style.opacity = bar.style.opacity === '0.3' ? '1' : '0.3';
document.body.appendChild(bar);

setInterval(() => {{
    fetch('/build-status')
        .then(res => res.text())
        .then(s => {{
            if (s === 'building') {{ bar.style.background = '#ff9800'; bar.textContent = '● Building...'; }}
            else if (s === 'success') {{ bar.style.background = '#4caf50'; bar.textContent = '● Live'; }}
            else if (s === 'failed') {{ bar.style.background = '#f44336'; bar.textContent = '● Error'; }}
        }});
}}, 500);
</script>
</body>"#))
                    } else {
                        format!("{}\n<script>const e=new EventSource('/events');e.onmessage=m=>{{if(m.data==='reload')location.reload()}};</script>", html)
                    };
                    Response::new(200).html(&injected)
                }
                Err(_) => serve_no_output_page(),
            }
        }
    }
}

fn serve_building_page() -> Response {
    Response::new(200).html(r#"
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Building - SHTML</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .container {
            text-align: center;
            max-width: 600px;
            padding: 60px 40px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
        }
        .spinner {
            width: 60px;
            height: 60px;
            border: 4px solid rgba(255, 255, 255, 0.3);
            border-top-color: white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto 30px;
        }
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        h1 {
            font-size: 2.5em;
            margin-bottom: 20px;
            font-weight: 700;
        }
        p {
            font-size: 1.2em;
            opacity: 0.9;
            line-height: 1.6;
        }
        .dots::after {
            content: '';
            animation: dots 1.5s steps(4, end) infinite;
        }
        @keyframes dots {
            0%, 20% { content: ''; }
            40% { content: '.'; }
            60% { content: '..'; }
            80%, 100% { content: '...'; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="spinner"></div>
        <h1>⚡ Building</h1>
        <p>Compiling Swift code<span class="dots"></span></p>
        <p style="margin-top: 20px; opacity: 0.7; font-size: 0.9em;">
            This page will automatically refresh when ready
        </p>
    </div>
    <script src="/live-reload.js"></script>
</body>
</html>
"#)
}

fn serve_error_page(error: &str) -> Response {
    let error_html = html_escape(error);
    Response::new(200).html(&format!(r#"
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Build Error - SHTML</title>
    <style>
        * {{ margin: 0; padding: 0; box-sizing: border-box; }}
        body {{
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, monospace;
            background: #1e1e1e;
            color: #d4d4d4;
            padding: 40px 20px;
            min-height: 100vh;
        }}
        .container {{
            max-width: 1200px;
            margin: 0 auto;
        }}
        .header {{
            background: #ff3b30;
            color: white;
            padding: 30px;
            border-radius: 12px 12px 0 0;
            display: flex;
            align-items: center;
            gap: 20px;
        }}
        .header h1 {{
            font-size: 2em;
            font-weight: 700;
        }}
        .icon {{
            font-size: 3em;
        }}
        .error-content {{
            background: #2d2d2d;
            padding: 30px;
            border-radius: 0 0 12px 12px;
            overflow-x: auto;
        }}
        pre {{
            background: #1e1e1e;
            padding: 20px;
            border-radius: 8px;
            overflow-x: auto;
            line-height: 1.6;
            border-left: 4px solid #ff3b30;
            font-size: 14px;
            font-family: 'SF Mono', Monaco, 'Cascadia Code', 'Roboto Mono', Consolas, monospace;
        }}
        .error-line {{
            color: #ff6b6b;
            font-weight: bold;
        }}
        .help {{
            margin-top: 30px;
            padding: 20px;
            background: rgba(102, 126, 234, 0.1);
            border-radius: 8px;
            border-left: 4px solid #667eea;
        }}
        .help h2 {{
            color: #667eea;
            margin-bottom: 15px;
            font-size: 1.2em;
        }}
        .help ul {{
            list-style-position: inside;
            line-height: 2;
        }}
        .watching {{
            margin-top: 20px;
            padding: 15px;
            background: rgba(255, 152, 0, 0.1);
            border-radius: 8px;
            border-left: 4px solid #ff9800;
            text-align: center;
            font-weight: 600;
            color: #ff9800;
        }}
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="icon">❌</div>
            <div>
                <h1>Build Failed</h1>
                <p>Fix the errors below and save to rebuild</p>
            </div>
        </div>
        <div class="error-content">
            <pre>{}</pre>
            
            <div class="help">
                <h2>💡 Quick Tips</h2>
                <ul>
                    <li>Check for syntax errors in your Swift code</li>
                    <li>Make sure all imports are correct</li>
                    <li>Verify that all types conform to required protocols</li>
                    <li>The server will auto-rebuild when you save changes</li>
                </ul>
            </div>
            
            <div class="watching">
                👀 Watching for changes - will auto-rebuild and refresh
            </div>
        </div>
    </div>
    <script src="/live-reload.js"></script>
</body>
</html>
"#, error_html))
}

fn serve_no_output_page() -> Response {
    Response::new(200).html(r#"
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>No Output - SHTML</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            padding: 20px;
        }
        .container {
            text-align: center;
            max-width: 600px;
            padding: 60px 40px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-radius: 24px;
        }
        h1 {
            font-size: 3em;
            margin-bottom: 20px;
        }
        p {
            font-size: 1.2em;
            line-height: 1.8;
            opacity: 0.9;
        }
        code {
            background: rgba(0, 0, 0, 0.2);
            padding: 4px 8px;
            border-radius: 4px;
            font-family: monospace;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📭</h1>
        <h1>No HTML Output</h1>
        <p style="margin-top: 30px;">
            The build succeeded but no HTML file was found at <code>public/index.html</code>
        </p>
        <p style="margin-top: 20px;">
            Make sure your code calls <code>.generate()</code> on your Website
        </p>
    </div>
    <script src="/live-reload.js"></script>
</body>
</html>
"#)
}

fn html_escape(s: &str) -> String {
    s.replace('&', "&amp;")
        .replace('<', "&lt;")
        .replace('>', "&gt;")
        .replace('"', "&quot;")
        .replace('\'', "&#x27;")
}

fn serve_status_bar_script() -> Response {
    let script = r#"
(function() {
    // Create status bar
    const statusBar = document.createElement('div');
    statusBar.id = 'shtml-status';
    statusBar.style.cssText = `
        position: fixed;
        bottom: 20px;
        right: 20px;
        padding: 10px 20px;
        border-radius: 20px;
        font-family: -apple-system, system-ui, sans-serif;
        font-size: 14px;
        font-weight: 600;
        color: white;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        z-index: 999999;
        transition: all 0.3s ease;
        cursor: pointer;
    `;
    statusBar.innerHTML = '● Live';
    document.body.appendChild(statusBar);
    
    function setStatus(text, color) {
        statusBar.innerHTML = '● ' + text;
        statusBar.style.background = color;
    }
    
    // Status check - poll at same rate as reload (100ms)
    setInterval(() => {
        fetch('/build-status')
            .then(res => res.text())
            .then(status => {
                if (status === 'building') {
                    setStatus('Building...', '#ff9800');
                } else if (status === 'success') {
                    setStatus('Live', '#4caf50');
                } else if (status === 'failed') {
                    setStatus('Error', '#f44336');
                }
            })
            .catch(() => {
                setStatus('Offline', '#9e9e9e');
            });
    }, 100);
    
    // Click to hide/show
    statusBar.addEventListener('click', () => {
        if (statusBar.style.opacity === '0.3') {
            statusBar.style.opacity = '1';
        } else {
            statusBar.style.opacity = '0.3';
        }
    });
})();
"#;
    Response::new(200).js(script)
}

fn serve_live_reload_script() -> Response {
    let script = r#"
(function() {
    let reconnectAttempts = 0;
    const maxReconnectAttempts = 10;
    let lastCheck = Date.now();
    
    function checkReload() {
        const now = Date.now();
        const elapsed = now - lastCheck;
        
        fetch('/reload-check?t=' + now) // Cache bust
            .then(res => res.text())
            .then(text => {
                console.log(`[${elapsed}ms] Reload check: ${text}`);
                if (text === 'reload') {
                    console.log('🔄 RELOADING NOW!');
                    location.reload();
                } else {
                    reconnectAttempts = 0;
                }
                lastCheck = now;
            })
            .catch(err => {
                reconnectAttempts++;
                console.error('Reload check failed:', err);
                if (reconnectAttempts >= maxReconnectAttempts) {
                    console.error('Max reconnection attempts reached');
                }
            });
    }
    
    // Poll aggressively (100ms = 10x per second)
    setInterval(checkReload, 100);
    console.log('✅ SHTML Live Reload enabled (100ms polling)');
    checkReload(); // Check immediately
})();
"#;

    Response::new(200).js(script)
}

fn read_request(reader: &mut BufReader<TcpStream>) -> io::Result<Option<Request>> {
    let mut request_line = String::new();
    let n = reader.read_line(&mut request_line)?;
    if n == 0 {
        return Ok(None);
    }

    let request_line = request_line.trim_end();
    let mut parts = request_line.split_whitespace();
    let method = parts
        .next()
        .ok_or_else(|| io::Error::new(io::ErrorKind::InvalidData, "no method"))?;
    let path = parts
        .next()
        .ok_or_else(|| io::Error::new(io::ErrorKind::InvalidData, "no path"))?;

    let mut headers = HashMap::new();
    loop {
        let mut line = String::new();
        let n = reader.read_line(&mut line)?;
        if n == 0 {
            return Err(io::Error::new(io::ErrorKind::UnexpectedEof, "eof"));
        }
        let line = line.trim_end();
        if line.is_empty() {
            break;
        }
        if let Some((k, v)) = line.split_once(':') {
            headers.insert(k.trim().to_ascii_lowercase(), v.trim().to_string());
        }
    }

    Ok(Some(Request {
        method: method.to_string(),
        path: path.to_string(),
        headers,
    }))
}

fn write_response(stream: &mut TcpStream, mut resp: Response) -> io::Result<()> {
    let reason = match resp.status {
        200 => "OK",
        400 => "Bad Request",
        404 => "Not Found",
        _ => "OK",
    };

    resp.headers
        .entry("Content-Length".into())
        .or_insert_with(|| resp.body.len().to_string());
    resp.headers
        .entry("Connection".into())
        .or_insert_with(|| "close".into());

    let mut head = format!("HTTP/1.1 {} {}\r\n", resp.status, reason);
    for (k, v) in &resp.headers {
        head.push_str(&format!("{}: {}\r\n", k, v));
    }
    head.push_str("\r\n");

    stream.write_all(head.as_bytes())?;
    stream.write_all(&resp.body)?;
    stream.flush()?;
    Ok(())
}

// TUI-integrated server
pub fn start_server_with_tui(
    port: u16,
    app_state: Arc<Mutex<crate::tui::AppState>>,
    rebuild_flag: Arc<std::sync::atomic::AtomicBool>,
) -> io::Result<()> {
    use crate::tui::BuildState;
    use std::sync::atomic::Ordering;
    
    // Initial build
    {
        let mut state = app_state.lock().unwrap();
        state.build_state = BuildState::Building;
    }
    
    let start = std::time::Instant::now();
    let success = build_swift_package_silent();
    
    {
        let mut state = app_state.lock().unwrap();
        if success {
            state.build_state = BuildState::Success {
                duration: start.elapsed().as_secs_f32(),
                size: "N/A".to_string(),
            };
        } else {
            state.build_state = BuildState::Failed {
                error: "Build failed".to_string(),
            };
        }
    }
    
    // Start file watcher
    let app_state_clone = app_state.clone();
    let rebuild_flag_clone = rebuild_flag.clone();
    thread::spawn(move || {
        if let Err(e) = start_file_watcher_with_tui(app_state_clone, rebuild_flag_clone) {
            eprintln!("File watcher error: {}", e);
        }
    });
    
    thread::sleep(Duration::from_millis(100));
    
    // Bind to 0.0.0.0 to accept connections from all network interfaces (including mobile devices)
    let listener = TcpListener::bind(format!("0.0.0.0:{}", port))?;
    listener.set_nonblocking(false)?;
    
    {
        let mut state = app_state.lock().unwrap();
    }
    
    for stream in listener.incoming() {
        match stream {
            Ok(stream) => {
                thread::spawn(move || {
                    if let Err(e) = handle_connection(stream) {
                        eprintln!("Connection error: {}", e);
                    }
                });
            }
            Err(e) => eprintln!("Accept error: {}", e),
        }
    }
    
    Ok(())
}

fn start_file_watcher_with_tui(
    app_state: Arc<Mutex<crate::tui::AppState>>,
    rebuild_flag: Arc<std::sync::atomic::AtomicBool>,
) -> notify::Result<()> {
    use notify::{Event, PollWatcher};
    use crate::tui::BuildState;
    use std::sync::atomic::Ordering;
    
    let (tx, rx) = std::sync::mpsc::channel::<notify::Result<Event>>();
    
    // Use PollWatcher with 50ms polling - very aggressive to catch changes immediately
    let config = Config::default()
        .with_poll_interval(Duration::from_millis(50));
    
    let mut watcher = PollWatcher::new(tx, config)?;
    watcher.watch(Path::new("Sources"), RecursiveMode::Recursive)?;
    
    // Keep watcher alive
    let _watcher_handle = watcher;
    
    let last_build = Arc::new(Mutex::new(std::time::Instant::now()));
    let last_mtime = Arc::new(Mutex::new(std::time::SystemTime::UNIX_EPOCH));
    
    loop {
        // Check manual rebuild flag
        if rebuild_flag.swap(false, Ordering::SeqCst) {
            let mut state = app_state.lock().unwrap();
            state.build_state = BuildState::Building;
            drop(state);
            
            let start = std::time::Instant::now();
            let success = build_swift_package_silent();
            
            let mut state = app_state.lock().unwrap();
            if success {
                state.build_state = BuildState::Success {
                    duration: start.elapsed().as_secs_f32(),
                    size: "N/A".to_string(),
                };
                state.last_build_time = Some(chrono::Local::now().format("%H:%M:%S").to_string());
                drop(state);
                broadcast_reload();
            } else {
                state.build_state = BuildState::Failed {
                    error: "Build failed".to_string(),
                };
                drop(state);
                broadcast_reload();
            }
        }
        
        // Backup: Check file modification times directly (in case FS events are delayed)
        if let Ok(entries) = fs::read_dir("Sources") {
            let mut latest_mtime = std::time::SystemTime::UNIX_EPOCH;
            
            for entry in entries.flatten() {
                if let Ok(metadata) = entry.metadata() {
                    if let Ok(mtime) = metadata.modified() {
                        if mtime > latest_mtime {
                            latest_mtime = mtime;
                        }
                    }
                }
                
                // Check subdirectories recursively
                if entry.path().is_dir() {
                    if let Ok(sub_entries) = fs::read_dir(entry.path()) {
                        for sub_entry in sub_entries.flatten() {
                            if let Ok(metadata) = sub_entry.metadata() {
                                if let Ok(mtime) = metadata.modified() {
                                    if mtime > latest_mtime {
                                        latest_mtime = mtime;
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            let mut last_known = last_mtime.lock().unwrap();
            if latest_mtime > *last_known && latest_mtime > std::time::SystemTime::UNIX_EPOCH {
                *last_known = latest_mtime;
                drop(last_known);
                
                // Trigger rebuild
                let mut last = last_build.lock().unwrap();
                let now = std::time::Instant::now();
                
                if now.duration_since(*last) >= Duration::from_millis(300) {
                    *last = now;
                    drop(last);
                    
                    let mut state = app_state.lock().unwrap();
                    state.file_changed = Some("Source files".to_string());
                    state.build_state = BuildState::Building;
                    drop(state);
                    
                    let start = std::time::Instant::now();
                    let success = build_swift_package_silent();
                    
                    let mut state = app_state.lock().unwrap();
                    if success {
                        state.build_state = BuildState::Success {
                            duration: start.elapsed().as_secs_f32(),
                            size: "N/A".to_string(),
                        };
                        state.last_build_time = Some(chrono::Local::now().format("%H:%M:%S").to_string());
                        drop(state);
                        broadcast_reload();
                    } else {
                        state.build_state = BuildState::Failed {
                            error: "Build failed".to_string(),
                        };
                        drop(state);
                        broadcast_reload();
                    }
                }
            }
        }
        
        // Check file system events
        match rx.recv_timeout(Duration::from_millis(50)) {
            Ok(Ok(event)) => {
                let should_skip = event.paths.iter().any(|path| {
                    let path_str = path.to_string_lossy();
                    path_str.ends_with(".swp") 
                        || path_str.ends_with("~") 
                        || path_str.contains(".git")
                        || path_str.contains("/.build/")
                });
                
                if should_skip {
                    continue;
                }
                
                let mut last = last_build.lock().unwrap();
                let now = std::time::Instant::now();
                
                if now.duration_since(*last) < Duration::from_millis(300) {
                    continue;
                }
                
                *last = now;
                drop(last);
                
                // Update UI
                if let Some(path) = event.paths.first() {
                    let full_path = path.to_string_lossy().to_string();
                    
                    let mut state = app_state.lock().unwrap();
                    state.file_changed = Some(full_path);
                    state.build_state = BuildState::Building;
                    drop(state);
                }
                
                // Build
                let start = std::time::Instant::now();
                let success = build_swift_package_silent();
                
                let mut state = app_state.lock().unwrap();
                if success {
                    state.build_state = BuildState::Success {
                        duration: start.elapsed().as_secs_f32(),
                        size: "N/A".to_string(),
                    };
                    state.last_build_time = Some(chrono::Local::now().format("%H:%M:%S").to_string());
                    drop(state);
                    broadcast_reload();
                } else {
                    state.build_state = BuildState::Failed {
                        error: "Build failed".to_string(),
                    };
                    drop(state);
                    broadcast_reload();
                }
            }
            Ok(Err(e)) => {
                eprintln!("Watch error: {:?}", e);
            }
            Err(std::sync::mpsc::RecvTimeoutError::Timeout) => {
                // Continue polling
            }
            Err(e) => {
                eprintln!("Channel error: {:?}", e);
                break;
            }
        }
    }
    
    Ok(())
}


fn copy_dir_all(src: impl AsRef<Path>, dst: impl AsRef<Path>) -> io::Result<()> {
    fs::create_dir_all(&dst)?;
    for entry in fs::read_dir(src)? {
        let entry = entry?;
        let ty = entry.file_type()?;
        if ty.is_dir() {
            copy_dir_all(entry.path(), dst.as_ref().join(entry.file_name()))?;
        } else {
            fs::copy(entry.path(), dst.as_ref().join(entry.file_name()))?;
        }
    }
    Ok(())
}


fn serve_static_file(path: &str) -> Response {
    // Security: prevent directory traversal
    if path.contains("..") {
        return Response::new(404).text("Not Found");
    }
    
    match fs::read(path) {
        Ok(contents) => {
            let mut resp = Response::new(200);
            resp.body = contents;
            
            // Set content type based on extension
            let content_type = if path.ends_with(".html") {
                "text/html; charset=utf-8"
            } else if path.ends_with(".css") {
                "text/css; charset=utf-8"
            } else if path.ends_with(".js") {
                "application/javascript; charset=utf-8"
            } else if path.ends_with(".json") {
                "application/json; charset=utf-8"
            } else if path.ends_with(".png") {
                "image/png"
            } else if path.ends_with(".jpg") || path.ends_with(".jpeg") {
                "image/jpeg"
            } else if path.ends_with(".gif") {
                "image/gif"
            } else if path.ends_with(".svg") {
                "image/svg+xml"
            } else if path.ends_with(".webp") {
                "image/webp"
            } else if path.ends_with(".woff") {
                "font/woff"
            } else if path.ends_with(".woff2") {
                "font/woff2"
            } else if path.ends_with(".ttf") {
                "font/ttf"
            } else if path.ends_with(".otf") {
                "font/otf"
            } else {
                "application/octet-stream"
            };
            
            resp.headers.insert("Content-Type".to_string(), content_type.to_string());
            resp
        }
        Err(_) => {
            // File not found - return 404
            Response::new(404).html(r#"
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>404 - Not Found</title>
    <style>
        body { font-family: system-ui; display: flex; align-items: center; justify-content: center; height: 100vh; margin: 0; background: #1a1a1a; color: #fff; }
        .container { text-align: center; }
        h1 { font-size: 72px; margin: 0; }
        p { font-size: 24px; color: #888; }
    </style>
</head>
<body>
    <div class="container">
        <h1>404</h1>
        <p>File Not Found</p>
    </div>
</body>
</html>
"#)
        }
    }
}
