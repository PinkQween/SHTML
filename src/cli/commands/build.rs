use std::{fs, io, process::Command, time::Instant};

pub fn run(output: &str) -> io::Result<()> {
    println!("╔══════════════════════════════════════╗");
    println!("║   📦 SHTML Production Build          ║");
    println!("╚══════════════════════════════════════╝\n");

    // Check if Package.swift exists
    if !std::path::Path::new("Package.swift").exists() {
        eprintln!("❌ Error: Package.swift not found");
        eprintln!("   Are you in an SHTML project directory?\n");
        return Err(io::Error::new(
            io::ErrorKind::NotFound,
            "Package.swift not found"
        ));
    }

    let total_start = Instant::now();

    // Build Swift package
    println!("🔨 Step 1/2: Compiling Swift...");
    let build_start = Instant::now();
    
    let build_output = Command::new("swift")
        .arg("build")
        .arg("--configuration")
        .arg("release")
        .output()?;

    if !build_output.status.success() {
        eprintln!("\n❌ Build failed!\n");
        eprintln!("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
        eprintln!("{}", String::from_utf8_lossy(&build_output.stderr));
        eprintln!("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n");
        return Err(io::Error::new(
            io::ErrorKind::Other,
            "Swift build failed"
        ));
    }

    let build_time = build_start.elapsed();
    println!("   ✅ Compiled in {:.2}s", build_time.as_secs_f64());

    // Find the executable name from Package.swift
    let package_content = fs::read_to_string("Package.swift")?;
    let exec_name = extract_executable_name(&package_content).unwrap_or("Website".to_string());

    // Generate HTML
    println!("\n📝 Step 2/2: Generating HTML...");
    let gen_start = Instant::now();
    
    let run_output = Command::new("swift")
        .arg("run")
        .arg("--configuration")
        .arg("release")
        .arg(&exec_name)
        .output()?;

    if !run_output.status.success() {
        eprintln!("\n❌ HTML generation failed!\n");
        eprintln!("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
        eprintln!("{}", String::from_utf8_lossy(&run_output.stderr));
        eprintln!("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n");
        return Err(io::Error::new(
            io::ErrorKind::Other,
            "Failed to generate HTML"
        ));
    }

    let gen_time = gen_start.elapsed();
    println!("   ✅ Generated in {:.2}s", gen_time.as_secs_f64());

    // Show results
    let total_time = total_start.elapsed();
    println!("\n╔══════════════════════════════════════╗");
    println!("║   ✅ Build Successful!                ║");
    println!("╚══════════════════════════════════════╝");
    println!("\n📊 Build Summary:");
    println!("   ⏱️  Total time: {:.2}s", total_time.as_secs_f64());
    println!("   📁 Output: {}/index.html", output);
    
    // Show file size with nice formatting
    if let Ok(metadata) = fs::metadata(format!("{}/index.html", output)) {
        let size = metadata.len();
        let size_str = if size < 1024 {
            format!("{} B", size)
        } else if size < 1024 * 1024 {
            format!("{:.1} KB", size as f64 / 1024.0)
        } else {
            format!("{:.2} MB", size as f64 / (1024.0 * 1024.0))
        };
        println!("   📏 Size: {}", size_str);
    }
    
    println!("\n💡 Tip: Use 'shtml dev' for live development mode\n");

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
