#!/bin/bash
# Build resume PDF using Typst

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
TYPST_DIR="$PROJECT_ROOT/typst"
CONTENT_DIR="$PROJECT_ROOT/content/resume"
STATIC_DIR="$PROJECT_ROOT/static"

# Configuration
STYLE=${1:-"default"}  # default, modern, minimal, classic
OUTPUT_NAME=${2:-"resume.pdf"}

echo "Building resume PDF with style: $STYLE"

# Extract resume data from markdown
echo "Extracting resume data..."
python3 "$SCRIPT_DIR/extract_resume_data.py" \
    "$CONTENT_DIR/_index.md" \
    "$TYPST_DIR/data/resume-data.json"

# Create main.typ with selected style
echo "Generating Typst document..."
cat > "$TYPST_DIR/main.typ" << EOF
// Main resume document
// Imports resume data and generates PDF

#import "templates/resume.typ": resume
#import "styles/styles.typ": default-config, modern-config, minimal-config, classic-config

// Load resume data from JSON
#let resume-data = json("data/resume-data.json")

// Choose configuration
#let config = ${STYLE}-config

// Generate resume
#resume(
  name: resume-data.name,
  contact: resume-data.contact,
  sections: resume-data.sections,
  config: config
)
EOF

# Check if typst is available
if ! command -v typst &> /dev/null; then
    echo "Error: typst command not found. Please install Typst."
    echo "Trying to use cargo installed version..."
    export PATH="$HOME/.cargo/bin:$PATH"
    if ! command -v typst &> /dev/null; then
        echo "Error: typst still not found even after adding cargo bin to PATH"
        exit 1
    fi
fi

# Compile to PDF
echo "Compiling PDF..."
cd "$TYPST_DIR"
typst compile main.typ "$STATIC_DIR/$OUTPUT_NAME"

echo "Resume PDF generated: $STATIC_DIR/$OUTPUT_NAME"
echo "Style used: $STYLE"