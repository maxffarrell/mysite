# Resume PDF Generation System

This system automatically generates professional PDF resumes from the markdown content in `content/resume/_index.md` using Typst.

## Features

- **Automatic extraction** of resume data from markdown
- **Multiple layout styles** (default, modern, minimal, classic)
- **Modular configuration** for easy customization
- **Server-side generation** integrated with the build process

## Quick Start

### Generate PDF Only
```bash
# Default style
./scripts/build_resume.sh

# Specific style
./scripts/build_resume.sh modern
./scripts/build_resume.sh minimal
./scripts/build_resume.sh classic
```

### Build Site + PDF
```bash
# Builds both the Zola site and generates the PDF
./scripts/build_site.sh [style]
```

## Directory Structure

```
typst/
├── data/               # Generated JSON data from markdown
├── styles/            # Style configurations
│   └── styles.typ     # All style definitions
├── templates/         # Typst templates
│   └── resume.typ     # Main resume template
├── config.env         # Configuration file
└── main.typ          # Generated document entry point

scripts/
├── extract_resume_data.py  # Markdown to JSON parser
├── build_resume.sh         # PDF generation script
└── build_site.sh          # Complete build script
```

## Available Styles

### Default
- Blue accent color (#365590)
- Section lines enabled
- Traditional layout

### Modern
- Blue accent color (#2563eb)
- No section lines
- Clean, minimal design
- Larger name font

### Minimal
- Black accent color
- No section lines
- Compact spacing
- Simple typography

### Classic
- Burgundy accent color (#800020)
- Traditional serif fonts
- Justified text
- Formal layout

## Customization

### 1. Edit Configuration
Modify `typst/config.env` to change basic settings.

### 2. Create New Style
Add a new configuration in `typst/styles/styles.typ`:

```typst
#let my-config = {
  let config = default-config
  config.colors.accent = rgb("#your-color")
  // ... customize other properties
  config
}
```

### 3. Modify Template
Edit `typst/templates/resume.typ` to change the layout structure.

## Integration with CI/CD

The build scripts can be integrated into deployment workflows:

```yaml
# Example GitHub Actions step
- name: Build Resume PDF
  run: |
    ./scripts/build_site.sh modern
    
- name: Deploy
  run: |
    # Deploy public/ directory
    # PDF is available at static/resume.pdf
```

## Dependencies

- **Typst** - Install via cargo: `cargo install typst-cli`
- **Python 3** - For markdown parsing
- **Zola** - For site generation (optional)

## Troubleshooting

### Font Warnings
If you see font warnings, the system will fall back to system fonts. This is normal and doesn't affect functionality.

### Build Errors
- Ensure Typst is in your PATH: `export PATH="$HOME/.cargo/bin:$PATH"`
- Check that all required files exist in the typst/ directory
- Verify the JSON data is being generated correctly

### Style Issues
- Check that your style name matches the config names in styles.typ
- Ensure color values are valid Typst rgb() values
- Verify spacing values include units (pt, em, in, etc.)