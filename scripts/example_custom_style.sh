#!/bin/bash
# Example: Create a custom style and generate PDF

# This script demonstrates how to create a custom style configuration

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Add a custom style to the styles.typ file
cat >> "$PROJECT_ROOT/typst/styles/styles.typ" << 'EOF'

// Custom teal configuration
#let teal-config = {
  let config = default-config
  config.colors.accent = rgb("#14b8a6")
  config.colors.section = rgb("#14b8a6")
  config.section-line = true
  config.sizes.name = 26pt
  config.spacing.after-header = 18pt
  config
}
EOF

# Temporarily update the build script to support the new style
sed -i 's/classic-config/teal-config/' "$PROJECT_ROOT/typst/main.typ"

# Build with the custom style
cd "$PROJECT_ROOT"
export PATH="$HOME/.cargo/bin:$PATH"
./scripts/build_resume.sh teal "resume-teal.pdf"

echo "Custom teal style PDF generated: static/resume-teal.pdf"