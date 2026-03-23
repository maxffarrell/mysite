// Custom resume layout matching target PDF style
#import "@preview/fontawesome:0.6.0": *

// ── Page setup ──────────────────────────────────────────────────────
#set page(paper: "us-letter", margin: (top: 0.5in, bottom: 0.5in, left: 0.5in, right: 0.5in))
#set text(font: "Helvetica Neue", size: 9.5pt, fill: black)
#set par(leading: 0.55em)

// ── Helper functions ────────────────────────────────────────────────

// Section: ALL CAPS label on left + content on right, with horizontal rule above
#let section(label, content) = {
  v(4pt)
  line(length: 100%, stroke: 0.8pt + black)
  v(2pt)
  grid(
    columns: (90pt, 1fr),
    column-gutter: 12pt,
    align(left, text(weight: "bold", tracking: 0.5pt, upper(label))),
    content,
  )
}

// Entry: Company • Role on one line (bold), date right-aligned
#let entry(company, role, date, description: none) = {
  v(2pt)
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    {
      if role != none and role != [] and role != "" {
        text(weight: "bold")[#company #sym.bullet #role]
      } else {
        text(weight: "bold")[#company]
      }
    },
    align(right, text(date)),
  )
  if description != none {
    v(2pt)
    description
  }
}

// Bullet list with filled circle bullets
#let bullets(..items) = {
  for item in items.pos() {
    grid(
      columns: (16pt, 1fr),
      align(left + top, text(size: 5pt, baseline: 2.5pt)[#sym.circle.filled]),
      item,
    )
  }
}

// Education entry: University on left, date on right, degree below
#let edu-entry(school, date, degree: none) = {
  v(2pt)
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    text(weight: "bold", school),
    align(right, text(date)),
  )
  if degree != none {
    degree
  }
}

// ── Header ──────────────────────────────────────────────────────────
#align(center)[
  #text(size: 28pt, weight: "regular", tracking: 0.5pt)[Maximillian Farrell]
  #v(2pt)
  #text(size: 8.5pt, style: "italic")[
    Recent graduate with an ability to collaborate effectively with both technical and non-technical stakeholders.
  ]
  #v(0pt)
  #text(size: 8.5pt, style: "italic")[
    My primary goal is to address complex challenges with scalable solutions that merge the worlds of engineering and business.
  ]
  #v(6pt)
  #box(
    stroke: 0.7pt + black,
    radius: 12pt,
    inset: (x: 14pt, y: 6pt),
  )[
    #set text(size: 10pt)
    #fa-icon("location-dot", solid: true) ATX
    #h(12pt)
    #fa-icon("phone", solid: true) (737) 202-6319
    #h(12pt)
    #fa-icon("envelope", solid: true) maxffarrell\@gmail.com
    #h(12pt)
    #fa-icon("linkedin") maxff.us/linkedin
  ]
]

#v(4pt)

// ── Experience ──────────────────────────────────────────────────────
#section("Experience")[
  #entry("Zello", "Sales Engineer", "February 2026 – Present",
    description: bullets(
      [Partner with Account Executives to win new business through discovery sessions, tailored demos, and proof-of-concept designs for enterprise clients],
      [Design custom solution architectures and integrations addressing SSO, API, SDK, and MDM requirements while articulating ROI and scalability to IT stakeholders],
      [Bridge field sales and product engineering by channeling customer feedback to inform the roadmap and training sales teams on competitive positioning],
    ),
  )
  #entry("Brivo (formerly Eagle Eye Networks)", "Sales Engineer", "Mar 2025 – Feb 2026",
    description: bullets(
      [Engaged with channel partners across the Eastern US and Canada to architect video surveillance and access control solutions],
      [Delivered technical presentations, product demonstrations, and training, showcasing advanced AI features like gun detection, LPR, face match, and object search],
      [Collaborated with sales teams to develop strategies and processes that drive revenue growth],
      [Responded to RFPs and RFIs with detailed technical proposals that align with customer requirements and industry standards],
      [Collaborated with API & technology partners to design integrated solutions that enhance the value proposition of Brivo's cloud-based security platform],
      [Advised content development for internal and external training courses],
    ),
  )
  #entry("Breezy Point Cooperative", "IT Associate", "Summer & Winter 2024",
    description: bullets(
      [Coordinated commercial lease administration using Yardi Voyager],
      [Converted physical paperwork to database entries using Excel + add-ins],
      [Supervised data entry team of three],
      [Presented tallies and statistics to Head of Accounting for monthly close],
      [Developing SvelteKit app for future consideration],
    ),
  )
  #entry("Rockfish Custom Builders", "Construction", "Spring 2024")
  #entry("Breezy Point Cooperative", "Seasonal Worker", "Summers 2019 – 2023")
  #entry("Computer Repair", "Self-Employed", "Jun 2017 – Present",
    description: bullets(
      [Repair/replace home electronics and personal devices],
      [Negotiate contracts with ISPs & carriers on behalf of customers],
    ),
  )
]

// ── Projects ────────────────────────────────────────────────────────
#section("Projects")[
  #entry("IoT & Edge Processing", "HW/SW Team Lead", "Aug 2023 – Dec 2024",
    description: bullets(
      [Developed mesh network of sensor nodes, monitored for hazards],
      [Directed creation of data pipeline using local & cloud SQL databases],
      [Coordinated development using GitHub & GH Projects (Agile)],
      [Utilized Arduino IDE and Shapr3D modeling],
    ),
  )
  #entry("Data Science for Smart Cities", "Student Researcher", "Jan 2022 – Apr 2022",
    description: bullets(
      [Performed vision-based damage detection for roads in West Lafayette],
      [Learned Keras to classify level of damage],
    ),
  )
]

// ── Education ───────────────────────────────────────────────────────
#section("Education")[
  #edu-entry("Purdue University", "Aug 2021 – Dec 2024",
    degree: [B.S. Integrated Business and Engineering],
  )
  #edu-entry("Stuyvesant High School", "Sept 2017 – Jun 2021")
  1530 SAT
]

// ── Skills ──────────────────────────────────────────────────────────
#v(4pt)
#line(length: 100%, stroke: 0.8pt + black)
#v(2pt)
#grid(
  columns: (90pt, 1fr),
  column-gutter: 12pt,
  align(left, text(weight: "bold", tracking: 0.5pt, upper("Skills"))),
  [3D modeling, Agile, C, CLI, CRM, Java, Linux, LV electric, project management, Python, R, solution design],
)
