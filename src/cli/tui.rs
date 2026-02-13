use crossterm::{
    event::{self, DisableMouseCapture, EnableMouseCapture, Event, KeyCode},
    execute,
    terminal::{disable_raw_mode, enable_raw_mode, EnterAlternateScreen, LeaveAlternateScreen},
};
use ratatui::{
    backend::{Backend, CrosstermBackend},
    layout::{Constraint, Direction, Layout, Rect},
    style::{Color, Modifier, Style},
    text::{Line, Span},
    widgets::{Block, Borders, Paragraph},
    Frame, Terminal,
};
use std::{
    io,
    sync::{Arc, Mutex},
    time::Duration,
};

#[derive(Clone, Debug)]
pub enum BuildState {
    Idle,
    Building,
    Success { duration: f32, size: String },
    Failed { error: String },
}

pub struct AppState {
    pub build_state: BuildState,
    pub last_build_time: Option<String>,
    pub file_changed: Option<String>,
    pub server_url: String,
    pub local_ip: String,
    pub port: u16,
}

impl AppState {
    pub fn new(port: u16) -> Self {
        let local_ip = get_local_ip().unwrap_or_else(|| "127.0.0.1".to_string());
        Self {
            build_state: BuildState::Idle,
            last_build_time: None,
            file_changed: None,
            server_url: format!("http://{}:{}", local_ip, port),
            local_ip,
            port,
        }
    }
}

fn get_local_ip() -> Option<String> {
    use std::net::UdpSocket;
    
    // Try to get local network IP by connecting to a public DNS
    let socket = UdpSocket::bind("0.0.0.0:0").ok()?;
    socket.connect("8.8.8.8:80").ok()?;
    let addr = socket.local_addr().ok()?;
    Some(addr.ip().to_string())
}

pub fn run_tui(state: Arc<Mutex<AppState>>, trigger_rebuild: Arc<dyn Fn() + Send + Sync>) -> io::Result<()> {
    // Setup terminal
    enable_raw_mode()?;
    let mut stdout = io::stdout();
    execute!(stdout, EnterAlternateScreen, EnableMouseCapture)?;
    let backend = CrosstermBackend::new(stdout);
    let mut terminal = Terminal::new(backend)?;

    let res = run_app(&mut terminal, state, trigger_rebuild);

    // Restore terminal
    disable_raw_mode()?;
    execute!(
        terminal.backend_mut(),
        LeaveAlternateScreen,
        DisableMouseCapture
    )?;
    terminal.show_cursor()?;

    if let Err(err) = res {
        println!("Error: {:?}", err);
    }

    Ok(())
}

fn run_app<B: Backend>(
    terminal: &mut Terminal<B>,
    state: Arc<Mutex<AppState>>,
    trigger_rebuild: Arc<dyn Fn() + Send + Sync>,
) -> io::Result<bool> {
    loop {
        terminal.draw(|f| ui(f, &state))?;

        if event::poll(Duration::from_millis(50))? {
            if let Event::Key(key) = event::read()? {
                match key.code {
                    KeyCode::Char('q') => return Ok(false), // Quit without build
                    KeyCode::Char('d') => {
                        // Production build before exit
                        if let Ok(mut s) = state.lock() {
                            s.build_state = BuildState::Building;
                        }
                        
                        terminal.draw(|f| ui(f, &state))?;
                        
                        // Run production build
                        let result = std::process::Command::new("swift")
                            .arg("build")
                            .arg("--configuration")
                            .arg("release")
                            .output();
                        
                        match result {
                            Ok(output) if output.status.success() => {
                                // Generate HTML
                                let gen_result = std::process::Command::new("swift")
                                    .arg("run")
                                    .arg("--configuration")
                                    .arg("release")
                                    .output();
                                
                                if let Ok(gen) = gen_result {
                                    if gen.status.success() {
                                        terminal.draw(|f| ui(f, &state))?;
                                        std::thread::sleep(std::time::Duration::from_secs(1));
                                        return Ok(true);
                                    }
                                }
                            }
                            _ => {
                                // Build failed, still exit
                            }
                        }
                        
                        terminal.draw(|f| ui(f, &state))?;
                        std::thread::sleep(std::time::Duration::from_secs(1));
                        return Ok(true);
                    }
                    KeyCode::Char('r') => {
                        trigger_rebuild();
                    }
                    KeyCode::Char('c') if key.modifiers.contains(event::KeyModifiers::CONTROL) => {
                        return Ok(false);
                    }
                    KeyCode::Char('b') => {
                        // Open browser
                        if let Ok(s) = state.lock() {
                            let url = s.server_url.clone();
                            std::thread::spawn(move || {
                                let _ = std::process::Command::new("open")
                                    .arg(&url)
                                    .spawn();
                            });
                        }
                    }
                    _ => {}
                }
            }
        }
    }
}

fn ui(f: &mut Frame, state: &Arc<Mutex<AppState>>) {
    let chunks = Layout::default()
        .direction(Direction::Vertical)
        .constraints([
            Constraint::Length(3),
            Constraint::Min(10),
            Constraint::Length(20),
            Constraint::Length(3),
        ])
        .split(f.size());

    // Title
    render_title(f, chunks[0]);

    // Status
    if let Ok(s) = state.lock() {
        render_status(f, chunks[1], &s);
        render_qr_code(f, chunks[2], &s);
        render_controls(f, chunks[3]);
    }
}

fn render_title(f: &mut Frame, area: Rect) {
    let title = Paragraph::new("🚀 SHTML Live Development Server")
        .style(Style::default().fg(Color::Cyan).add_modifier(Modifier::BOLD))
        .block(Block::default().borders(Borders::ALL).border_style(Style::default().fg(Color::Cyan)));
    f.render_widget(title, area);
}

fn render_status(f: &mut Frame, area: Rect, state: &AppState) {
    let (status_text, status_color) = match &state.build_state {
        BuildState::Idle => ("⏸️  Idle", Color::Gray),
        BuildState::Building => ("🔨 Building...", Color::Yellow),
        BuildState::Success { duration, size } => {
            (format!("✅ Build Successful ({:.1}s, {})", duration, size).leak() as &str, Color::Green)
        }
        BuildState::Failed { .. } => ("❌ Build Failed", Color::Red),
    };

    let mut lines = vec![
        Line::from(vec![
            Span::styled("Status: ", Style::default().fg(Color::Gray)),
            Span::styled(status_text, Style::default().fg(status_color).add_modifier(Modifier::BOLD)),
        ]),
        Line::from(vec![
            Span::styled("Server: ", Style::default().fg(Color::Gray)),
            Span::styled(&state.server_url, Style::default().fg(Color::Blue).add_modifier(Modifier::UNDERLINED)),
        ]),
    ];

    if let Some(file) = &state.file_changed {
        lines.push(Line::from(vec![
            Span::styled("Changed: ", Style::default().fg(Color::Gray)),
            Span::styled(file, Style::default().fg(Color::Magenta)),
        ]));
    }

    if let Some(time) = &state.last_build_time {
        lines.push(Line::from(vec![
            Span::styled("Last Build: ", Style::default().fg(Color::Gray)),
            Span::styled(time, Style::default().fg(Color::Green)),
        ]));
    }

    let status = Paragraph::new(lines)
        .block(Block::default().borders(Borders::ALL).title("Status"));
    f.render_widget(status, area);
}

fn render_qr_code(f: &mut Frame, area: Rect, state: &AppState) {
    use qrcode::QrCode;
    use qrcode::render::unicode;
    
    let url = format!("http://{}:{}", state.local_ip, state.port);
    
    let mut lines = vec![
        Line::from(Span::styled(
            format!("Scan to open on mobile: {}", url),
            Style::default().fg(Color::Cyan).add_modifier(Modifier::BOLD)
        )),
    ];
    
    match QrCode::new(&url) {
        Ok(code) => {
            let qr_string = code
                .render::<unicode::Dense1x2>()
                .dark_color(unicode::Dense1x2::Light)
                .light_color(unicode::Dense1x2::Dark)
                .build();
            
            // Split QR code into separate lines
            for line in qr_string.lines() {
                lines.push(Line::from(line.to_string()));
            }
        }
        Err(_) => {
            lines.push(Line::from(Span::styled(
                "⚠️  QR code generation failed",
                Style::default().fg(Color::Red)
            )));
        }
    };
    
    let qr_widget = Paragraph::new(lines)
        .block(Block::default().borders(Borders::ALL).title("📱 Mobile Access"));
    f.render_widget(qr_widget, area);
}

fn render_controls(f: &mut Frame, area: Rect) {
    let controls = Paragraph::new("  [R] Rebuild  [B] Open Browser  [D] Production Build & Exit  [Q] Quit  [Ctrl+C] Force Exit")
        .style(Style::default().fg(Color::DarkGray))
        .block(Block::default().borders(Borders::ALL));
    f.render_widget(controls, area);
}
