#!/bin/bash
# SHTML CLI Installer

set -e

echo "⚡ Installing SHTML CLI..."

# Build the CLI
cargo build --release

# Create bin directory if it doesn't exist
mkdir -p ~/.local/bin

# Copy the binary
cp target/release/shtml ~/.local/bin/shtml

# Make it executable
chmod +x ~/.local/bin/shtml

echo "✅ SHTML CLI installed!"
echo ""
echo "Make sure ~/.local/bin is in your PATH:"
echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
echo ""
echo "Usage:"
echo "  shtml init my-project    # Create new project"
echo "  shtml dev                # Start dev server"
echo "  shtml build              # Build production HTML"
echo "  shtml new About          # Create new page"
