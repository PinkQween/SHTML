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

static RELOAD_FLAG: AtomicBool = AtomicBool::new(false);

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
    println!("🚀 SHTML Live Server");
    println!("📦 Building Swift package...");

    if !build_swift_package() {
        eprintln!("❌ Initial build failed");
        return Ok(());
    }

    println!("✅ Build successful!");

    let watcher_handle = thread::spawn(|| {
        if let Err(e) = start_file_watcher() {
            eprintln!("❌ File watcher error: {}", e);
        }
    });

    let listener = TcpListener::bind(format!("127.0.0.1:{}", port))?;
    println!("🌐 Server running at http://127.0.0.1:{}", port);
    println!("👀 Watching for file changes...\n");

    for stream in listener.incoming() {
        if let Ok(stream) = stream {
            if let Err(e) = handle_connection(stream) {
                eprintln!("Connection error: {}", e);
            }
        }
    }

    watcher_handle.join().unwrap();
    Ok(())
}

fn build_swift_package() -> bool {
    let output = Command::new("swift")
        .arg("build")
        .output()
        .expect("Failed to run swift build");

    if output.status.success() {
        println!("✅ Build completed");
        
        // Run the Demo executable to generate HTML
        println!("📝 Generating HTML...");
        let demo_output = Command::new("swift")
            .arg("run")
            .arg("Demo")
            .output()
            .expect("Failed to run Demo");
        
        if demo_output.status.success() {
            println!("{}", String::from_utf8_lossy(&demo_output.stdout));
        } else {
            eprintln!("⚠️  Demo generation failed:");
            eprintln!("{}", String::from_utf8_lossy(&demo_output.stderr));
        }
        
        true
    } else {
        eprintln!("❌ Build failed:");
        eprintln!("{}", String::from_utf8_lossy(&output.stderr));
        false
    }
}

fn start_file_watcher() -> notify::Result<()> {
    let (tx, rx) = std::sync::mpsc::channel();
    let mut watcher = RecommendedWatcher::new(tx, Config::default())?;

    watcher.watch(Path::new("Sources"), RecursiveMode::Recursive)?;

    let last_build = Arc::new(Mutex::new(std::time::Instant::now()));

    for res in rx {
        match res {
            Ok(_event) => {
                let mut last = last_build.lock().unwrap();
                let now = std::time::Instant::now();
                
                if now.duration_since(*last) > Duration::from_millis(500) {
                    *last = now;
                    drop(last);

                    println!("\n📝 File changed, rebuilding...");
                    if build_swift_package() {
                        RELOAD_FLAG.store(true, Ordering::Relaxed);
                        println!("🔄 Browser will auto-reload\n");
                    }
                }
            }
            Err(e) => eprintln!("Watch error: {}", e),
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

    let resp = handle_request(&req);
    write_response(&mut stream, resp)?;
    Ok(())
}

fn handle_request(req: &Request) -> Response {
    match req.path.as_str() {
        "/" => serve_generated_html(),
        "/reload-check" => {
            if RELOAD_FLAG.swap(false, Ordering::Relaxed) {
                Response::new(200).text("reload")
            } else {
                Response::new(200).text("ok")
            }
        }
        "/live-reload.js" => serve_live_reload_script(),
        _ => serve_generated_html(), // Serve the generated HTML for all routes (SPA)
    }
}

fn serve_generated_html() -> Response {
    match fs::read_to_string("public/index.html") {
        Ok(mut html) => {
            // Inject live reload script before </body>
            if let Some(pos) = html.rfind("</body>") {
                html.insert_str(pos, r#"<script src="/live-reload.js"></script>"#);
            }
            Response::new(200).html(&html)
        }
        Err(_) => serve_fallback_page(),
    }
}

fn serve_fallback_page() -> Response {
    Response::new(200).html(r#"
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Building...</title>
    <style>
        body {
            font-family: system-ui;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            background: #f5f5f5;
        }
        .message {
            text-align: center;
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div class="message">
        <h1>⏳ Building...</h1>
        <p>Generating HTML from Swift code...</p>
        <p style="color: #666; margin-top: 20px;">This page will auto-reload when ready.</p>
    </div>
    <script src="/live-reload.js"></script>
</body>
</html>
"#)
}


fn serve_live_reload_script() -> Response {
    let script = r#"
(function() {
    let reconnectAttempts = 0;
    const maxReconnectAttempts = 10;
    const statusEl = document.getElementById('status');
    
    function updateStatus(text, color) {
        if (statusEl) {
            statusEl.textContent = '● ' + text;
            statusEl.style.background = color;
        }
    }
    
    function checkReload() {
        fetch('/reload-check')
            .then(res => res.text())
            .then(text => {
                if (text === 'reload') {
                    console.log('🔄 Reloading page...');
                    updateStatus('Reloading...', '#ff9800');
                    setTimeout(() => location.reload(), 100);
                } else {
                    reconnectAttempts = 0;
                    updateStatus('Live', '#4caf50');
                }
            })
            .catch(err => {
                reconnectAttempts++;
                if (reconnectAttempts < maxReconnectAttempts) {
                    updateStatus('Reconnecting...', '#ff9800');
                    console.warn('Connection lost, retrying...');
                } else {
                    updateStatus('Offline', '#f44336');
                    console.error('Max reconnection attempts reached');
                }
            });
    }
    
    // Poll every 500ms
    setInterval(checkReload, 500);
    console.log('✅ Live reload enabled');
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
