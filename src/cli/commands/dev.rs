use crate::server;
use crate::tui::{AppState, BuildState};
use std::{io, sync::{Arc, Mutex, atomic::{AtomicBool, Ordering}}};

pub fn run(port: u16) -> io::Result<()> {
    let app_state = Arc::new(Mutex::new(AppState::new(port)));
    let rebuild_flag = Arc::new(AtomicBool::new(false));
    
    // Clone for trigger function
    let rebuild_flag_clone = rebuild_flag.clone();
    let trigger_rebuild: Arc<dyn Fn() + Send + Sync> = Arc::new(move || {
        rebuild_flag_clone.store(true, Ordering::SeqCst);
    });
    
    // Start server in background
    let app_state_clone = app_state.clone();
    let rebuild_flag_clone = rebuild_flag.clone();
    std::thread::spawn(move || {
        if let Err(e) = server::start_server_with_tui(port, app_state_clone, rebuild_flag_clone) {
            eprintln!("Server error: {}", e);
        }
    });
    
    // Small delay to let server start
    std::thread::sleep(std::time::Duration::from_millis(500));
    
    // Run TUI
    crate::tui::run_tui(app_state, trigger_rebuild)?;
    
    Ok(())
}
