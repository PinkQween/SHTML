use std::{fs, io, process::Command};

pub fn run(output: &str) -> io::Result<()> {
    println!("📦 Building SHTML project...\n");

    // Check if Package.swift exists
    if !std::path::Path::new("Package.swift").exists() {
        return Err(io::Error::new(
            io::ErrorKind::NotFound,
            "Package.swift not found. Are you in an SHTML project directory?"
        ));
    }

    // Build Swift package
    println!("🔨 Compiling Swift...");
    let build_result = Command::new("swift")
        .arg("build")
        .arg("--configuration")
        .arg("release")
        .status()?;

    if !build_result.success() {
        return Err(io::Error::new(
            io::ErrorKind::Other,
            "Swift build failed"
        ));
    }

    // Find the executable name from Package.swift
    let package_content = fs::read_to_string("Package.swift")?;
    let exec_name = extract_executable_name(&package_content).unwrap_or("Website".to_string());

    println!("📝 Generating HTML...");
    let run_result = Command::new("swift")
        .arg("run")
        .arg("--configuration")
        .arg("release")
        .arg(&exec_name)
        .status()?;

    if !run_result.success() {
        return Err(io::Error::new(
            io::ErrorKind::Other,
            "Failed to generate HTML"
        ));
    }

    println!("\n✅ Build complete!");
    println!("📁 Output: {}/index.html", output);
    
    // Show file size
    if let Ok(metadata) = fs::metadata(format!("{}/index.html", output)) {
        println!("📏 Size: {} bytes", metadata.len());
    }

    Ok(())
}

fn extract_executable_name(package_swift: &str) -> Option<String> {
    // Simple parser to find .executableTarget name
    for line in package_swift.lines() {
        if line.contains(".executableTarget") {
            if let Some(name_start) = line.find("name:") {
                let after_name = &line[name_start + 5..];
                if let Some(quote_start) = after_name.find('"') {
                    let after_quote = &after_name[quote_start + 1..];
                    if let Some(quote_end) = after_quote.find('"') {
                        return Some(after_quote[..quote_end].to_string());
                    }
                }
            }
        }
    }
    None
}
