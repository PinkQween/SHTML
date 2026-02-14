#!/bin/bash
set -e

echo "🔨 Building DocC documentation..."

# Build documentation using xcodebuild
xcodebuild docbuild \
    -scheme Math \
    -destination 'platform=macOS' \
    2>&1 | grep -E "BUILD|SUCCEEDED|FAILED|Error" || true

# Find the generated .doccarchive
DOCC_ARCHIVE=$(find ~/Library/Developer/Xcode/DerivedData -name "SHTML.doccarchive" -type d 2>/dev/null | head -1)

if [ -z "$DOCC_ARCHIVE" ]; then
    echo "❌ Error: Could not find SHTML.doccarchive"
    exit 1
fi

echo "✅ Documentation built successfully at: $DOCC_ARCHIVE"

# Clear old docs and copy new ones
echo "📦 Deploying documentation to docs/..."
rm -rf docs/*
cp -R "$DOCC_ARCHIVE"/* docs/

# Add CNAME for custom domain
echo "shtml.hannaskairipa.com" > docs/CNAME

# Disable Jekyll for GitHub Pages
touch docs/.nojekyll

# Add redirect index.html to documentation/math
cat > docs/index.html <<'EOF'
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Redirecting...</title>
    <meta http-equiv="refresh" content="0; url=documentation/shtml/">
    <link rel="canonical" href="documentation/SHTML/">
  </head>
  <body>
    <p>If you are not redirected, <a href="documentation/shtml/">click here</a>.</p>
  </body>
</html>
EOF

echo "✅ Documentation deployed to docs/ directory"
echo "📝 Files ready for git commit"
