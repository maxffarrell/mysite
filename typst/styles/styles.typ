// Resume Styling Configuration
// Modular and customizable design system

// Default configuration
#let default-config = (
  // Page settings
  paper: "us-letter",
  margins: (x: 0.75in, y: 0.75in),
  
  // Typography
  fonts: (
    heading: ("Liberation Sans",),
    body: ("Liberation Sans",)
  ),
  
  // Font sizes
  sizes: (
    name: 24pt,
    section: 14pt,
    contact: 11pt,
    body: 11pt,
    item-title: 11pt,
    item-details: 10pt
  ),
  
  // Colors
  colors: (
    background: white,
    text: black,
    accent: rgb("#365590"),
    section: rgb("#365590"),
    item-title: black,
    item-details: rgb("#555555")
  ),
  
  // Spacing
  spacing: (
    after-name: 4pt,
    after-header: 16pt,
    after-section-heading: 4pt,
    after-section-line: 8pt,
    after-section-content: 12pt,
    after-item-title: 3pt,
    between-items: 10pt
  ),
  
  // Layout options
  justify: false,
  section-line: true,
  list-tight: true
)

// Alternative modern configuration
#let modern-config = {
  let config = default-config
  config.colors.accent = rgb("#2563eb")
  config.colors.section = rgb("#2563eb")
  config.section-line = false
  config.fonts.heading = ("Liberation Sans",)
  config.sizes.name = 28pt
  config.spacing.after-header = 20pt
  config
}

// Minimal configuration
#let minimal-config = {
  let config = default-config
  config.colors.accent = rgb("#000000")
  config.colors.section = rgb("#000000")
  config.section-line = false
  config.sizes.name = 20pt
  config.spacing = (
    after-name: 3pt,
    after-header: 12pt,
    after-section-heading: 3pt,
    after-section-line: 6pt,
    after-section-content: 10pt,
    after-item-title: 2pt,
    between-items: 8pt
  )
  config
}

// Classic configuration
#let classic-config = {
  let config = default-config
  config.colors.accent = rgb("#800020")
  config.colors.section = rgb("#800020")
  config.fonts = (
    heading: ("Liberation Serif",),
    body: ("Liberation Serif",)
  )
  config.sizes.name = 22pt
  config.justify = true
  config
}