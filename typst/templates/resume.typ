// Modern Resume Template for Typst
// Configurable layout and styling

#import "../styles/styles.typ": *

#let format_item(item, config) = {
  // Company and role
  if "company" in item and item.company != "" [
    #grid(
      columns: (1fr, auto),
      [
        #text(
          weight: "bold",
          size: config.sizes.item-title,
          fill: config.colors.item-title
        )[#item.company]
        
        #if "role" in item and item.role != "" [
          #text(
            size: config.sizes.item-details,
            fill: config.colors.item-details
          )[ • #item.role]
        ]
      ],
      [
        #if "dates" in item and item.dates != "" [
          #text(
            size: config.sizes.item-details,
            fill: config.colors.item-details,
            style: "italic"
          )[#item.dates]
        ]
      ]
    )
    
    #v(config.spacing.after-item-title)
  ]
  
  // Description bullets
  if "description" in item and item.description.len() > 0 [
    #for bullet in item.description [
      #list.item[#bullet]
    ]
  ]
}

#let resume(
  name: "Name",
  contact: (:),
  sections: (:),
  config: default-config
) = {
  
  // Page setup
  set page(
    paper: config.paper,
    margin: config.margins,
    fill: config.colors.background
  )
  
  set text(
    font: config.fonts.body,
    size: config.sizes.body,
    fill: config.colors.text
  )
  
  set par(justify: config.justify)
  
  // Header with name and contact
  align(center)[
    #text(
      font: config.fonts.heading,
      size: config.sizes.name,
      weight: "bold",
      fill: config.colors.accent
    )[#name]
    
    #if contact.keys().len() > 0 [
      #v(config.spacing.after-name)
      #text(size: config.sizes.contact)[
        #contact.values().join(" • ")
      ]
    ]
  ]
  
  v(config.spacing.after-header)
  
  // Process sections
  for (section-name, section-data) in sections {
    if section-name != "" {
      // Section heading
      text(
        font: config.fonts.heading,
        size: config.sizes.section,
        weight: "bold",
        fill: config.colors.section
      )[#section-name]
      
      v(config.spacing.after-section-heading)
      
      // Section line (if enabled)
      if config.section-line {
        line(length: 100%, stroke: config.colors.accent + 0.5pt)
        v(config.spacing.after-section-line)
      }
      
      // Section content
      if "items" in section-data and section-data.items.len() > 0 {
        // Structured items (Experience, Projects, etc.)
        for item in section-data.items {
          format_item(item, config)
          v(config.spacing.between-items)
        }
      } else {
        // Plain content
        [#section-data.content]
        v(config.spacing.after-section-content)
      }
    }
  }
}