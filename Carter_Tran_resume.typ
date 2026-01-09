// Config variables
#let config = yaml("config.yaml")
#let name = config.name
#let email = config.email
#let phone = config.phone
#let tel = config.tel
#let website = config.website
#let website_display = config.website_display
#let linkedin = config.linkedin
#let linkedin_display = config.linkedin_display
#let github = config.github
#let github_display = config.github_display

// Spacing constants - adjust these to change spacing throughout
#let entry-spacing = 1pt  // Space between different entries (experiences/projects)
#let bullet-spacing = 0.65em  // Space between bullet points
#let bullet-line-height = 0.5em  // Line height within bullet points
#let heading-after-spacing = -6pt  // Space after subheading before bullets
#let heading-row-gap = 3pt  // Gap between title and subtitle rows in headings
#let heading-before-spacing = -2pt  // Space before subheading
#let section-title-spacing = -7pt  // Spacing around section titles

// Font size constants
#let base-font-size = 10pt  // Main document font size
#let name-font-size = 24pt  // Name in header
#let section-font-size = 12pt  // Section titles
#let body-font-size = 9pt  // Bullet points and descriptions

// Indentation constants
#let bullet-indent = 0.05in  // Left margin for bullets
#let list-body-indent = 0.05in  // Indent for bullet text
#let awards-indent = 0.05in  // Indent for awards/skills sections

// Page setup
#set page(
  paper: "us-letter",
  margin: (x: 0.5in, y: 0.3in),
)

#set text(
  font: "Latin Modern Roman",
  size: base-font-size,
)

#set par(justify: false)

// Section formatting
#let section(title) = {
  v(section-title-spacing)
  text(size: section-font-size, weight: "regular", smallcaps(title))
  v(section-title-spacing)
  line(length: 100%, stroke: 0.5pt + black)
  v(section-title-spacing)
}

// Apply standard list formatting for resume items
#let resume-list-start(content) = {
  set text(size: body-font-size)
  set par(leading: bullet-line-height)
  set list(marker: [•], indent: bullet-indent, body-indent: list-body-indent, spacing: bullet-spacing)
  content
}

// Resume heading
#let resumeSubheading(title, date, subtitle, location) = {
  v(heading-before-spacing)
  table(
    columns: (1fr, auto),
    stroke: none,
    align: (left, right),
    inset: 0pt,
    column-gutter: 0pt,
    row-gutter: heading-row-gap,
    [*#title*], [#date],
    [#text(style: "italic", size: body-font-size)[#subtitle]], [#text(style: "italic", size: body-font-size)[#location]]
  )
  v(heading-after-spacing)
}

// Project heading
#let resumeProjectHeading(title, date) = {
  table(
    columns: (1fr, auto),
    stroke: none,
    align: (left, right),
    inset: 0pt,
    column-gutter: 0pt,
    [#text(size: body-font-size)[#title]], [#text(size: body-font-size)[#date]]
  )
  v(heading-after-spacing)
}

// Document content
#align(center)[
  #text(size: name-font-size, weight: "regular")[#smallcaps[#name]] \
  #v(1pt)
  #link(tel)[#phone] |
  #link("mailto:" + email)[#email] |
  #link(website)[#website_display] |
  #link(linkedin)[#linkedin_display] |
  #link(github)[#github_display]
]

#section("Education")

#for edu in config.education {
  resumeSubheading(
    edu.institution,
    edu.date,
    edu.degree,
    edu.location
  )
  resume-list-start([
    #for item in edu.items [
      - #eval(item, mode: "markup")
    ]
  ])
}

#section("Experience")

#for (i, exp) in config.experience.enumerate() {
  resumeSubheading(
    eval(exp.company, mode: "markup"),
    exp.date,
    eval(exp.role, mode: "markup"),
    exp.location
  )
  resume-list-start([
    #for item in exp.items [
      - #eval(item, mode: "markup")
    ]
  ])
  if i < config.experience.len() - 1 {
    v(entry-spacing)
  }
}

#section("Extracurriculars and Projects")

#for (i, project) in config.projects.enumerate() {
  resumeProjectHeading(
    eval(project.title, mode: "markup"),
    project.date
  )
  resume-list-start([
    #for item in project.items [
      - #eval(item, mode: "markup")
    ]
  ])
  if i < config.projects.len() - 1 {
    v(entry-spacing)
  }
}

#section("Awards")
#set list(marker: none, indent: awards-indent, body-indent: 0in)
#set text(size: body-font-size)
#for award in config.awards [
  - #eval(award, mode: "markup")
]

#section("Skills")
#set list(marker: none, indent: awards-indent, body-indent: 0in)
#set text(size: body-font-size)
#for skill_group in config.skills [
  - *#skill_group.category*: #eval(skill_group.skills, mode: "markup")
]

