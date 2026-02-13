use clap::{Parser, Subcommand};
use std::process;

mod server;
mod commands;

#[derive(Parser)]
#[command(name = "shtml")]
#[command(about = "⚡ SHTML - SwiftUI-style HTML framework with live development", long_about = None)]
#[command(version)]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    /// Initialize a new SHTML project
    Init {
        /// Project name
        name: Option<String>,
    },
    /// Start development server with auto-reload
    Dev {
        /// Port to run on (default: 3000)
        #[arg(short, long, default_value = "3000")]
        port: u16,
    },
    /// Build production HTML
    Build {
        /// Output directory (default: public)
        #[arg(short, long, default_value = "public")]
        output: String,
    },
}

fn main() {
    let cli = Cli::parse();

    let result = match cli.command {
        Commands::Init { name } => commands::init::run(name),
        Commands::Dev { port } => commands::dev::run(port),
        Commands::Build { output } => commands::build::run(&output),
    };

    if let Err(e) = result {
        eprintln!("❌ Error: {}", e);
        process::exit(1);
    }
}
