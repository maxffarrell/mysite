#!/bin/bash
# Enhanced build script that builds both the Zola site and the PDF resume

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Configuration
RESUME_STYLE=${1:-"default"}  # default, modern, minimal, classic
OUTPUT_NAME="resume.pdf"

echo "Building Zola site with updated resume..."

# Build the resume PDF
echo "1. Generating resume PDF..."
cd "$PROJECT_ROOT"
export PATH="$HOME/.cargo/bin:$PATH"
./scripts/build_resume.sh "$RESUME_STYLE" "$OUTPUT_NAME"

# Check if zola is available
if ! command -v zola &> /dev/null; then
    echo "Warning: zola command not found. Skipping site build."
    echo "PDF generation complete. Resume available at: static/$OUTPUT_NAME"
    exit 0
fi

# Build the Zola site
echo "2. Building Zola site..."
zola build

echo "Build complete!"
echo "- Resume PDF: static/$OUTPUT_NAME (style: $RESUME_STYLE)"
echo "- Site: public/"