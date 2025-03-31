#import "@preview/drafting:0.2.2": *
#import "@preview/glossy:0.7.0": *
#import "glossary.typ": myGlossary

#let typst-logo = text(rgb("#349cb4"), font: "libertinus serif", size: 13pt)[*typst*]

#let special-heading(title, outlined: false) = { // isto precisa de ser corrigido
pagebreak(weak: true)
show heading.where(
  level: 1
): it => block(width: 100%)[
  #set text(21pt, weight: "regular")
  #it.body
  #v(0.8cm)
]
heading(numbering: none, outlined: outlined)[#title]
}

#let margin-note-s(content) = margin-note({ // wrapper fn for smaller text
  set text(size: 7pt)
  content
})

#let block-quote(content, attribution) = align(right, block(width: 88%, [
  #set par(justify: false)
  #set text(size: 10pt, font: "Arial", style: "italic")
  #content
  #v(4pt)
  #line(length: 100%, stroke:0.7pt)
  #set text(style: "normal")
  #v(-14pt)
  #attribution
  #v(10pt)
]))

#let displayquote(content) = block(width: 100%, inset:(left: 0.9cm, right: 0.9cm), [
  #v(10pt)
  #set par(justify: true)
  #content
  #v(10pt)
])

#let heading_sizes = (21pt, 13pt,10pt, 11pt)

#let in-outline = state("in-outline", false) // outline shenanigans

#let flex-caption(long: none, short: none) = context if in-outline.get() { short } else { long } // allow short version of figure captions for outlines

#let figure-outline(glossary, doc) = {
  show outline.entry: it => {
    show ref: r => {
      let entry_label = str(r.target).split(":")
      let term = entry_label.at(0)
      if term == "a" or term == "an" {
        term = entry_label.at(1)
      }
      if term in glossary {
          if "short" not in entry_label and "long" not in entry_label and "both" not in entry_label {
            entry_label.push("short")
            if "noref" not in entry_label {
              entry_label.push("noref")
              ref(label(entry_label.join(":")))
            } else {ref(label(entry_label.join(":")))}
          } else {
            if "noref" not in entry_label {
              entry_label.push("noref")
              ref(label(entry_label.join(":")))
            } else {r}
            }
      } else {r}
    }
      
  block[#it.prefix().at("children").at(-1): #it.body()#box(width: 1fr, repeat[.]) #it.page()]}
    
  outline(title: none, target: figure.where(kind: image))
  doc
}


#let prepare-preamble(header_title: [MyThesis Title], doc) = {
  set page(header:[
    #set text(size: 8pt)
    #align(right)[
      #grid(rows:2, columns: 2, row-gutter: 4pt, column-gutter: 6pt,
      [FCUP], grid.vline(start: 0, end: 2, stroke: 0.3pt), [#h(6pt) #context {
        counter(page).display("i")}], 
        par(leading: 3pt)[#header_title]
      )]], header-ascent: 0.5cm, footer: none)

  set page(numbering: (..n) => context {
    if in-outline.get() {
      numbering("i", ..n)
    } else {
      none
    }
  })
  set par(justify: true)

  counter(page).update(2)
  doc
}

#let prepare-thesis-body(header_title: [MyThesis Title], doc) = {
  set page(header:[
    #set text(size: 8pt)
    #align(right)[
      #grid(rows:2, columns: 2, row-gutter: 4pt, column-gutter: 6pt,
      [FCUP], grid.vline(start: 0, end: 2, stroke: 0.3pt), [#h(6pt) #context {
        counter(page).display("1")}], header_title)]], header-ascent: 0.5cm, 
  )
  counter(page).update(1)
  set page(numbering: "1", footer: none)

  show heading: it => {
    set text(heading_sizes.at(it.depth -1), weight: "regular")
    if it.level == 4 {
    [ #v(4pt)
      #block(strong[#counter(heading).display("1.") #h(0.9 * heading_sizes.at(it.depth -1)) #it.body])
      #v(8pt)
    ]} else {[ #v(6pt)
      #block([#counter(heading).display("1.") #h(0.9 * heading_sizes.at(it.depth -1)) #it.body])
      #v(8pt)
    ]}
  }

  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    pagebreak()
    it
  }
  set math.equation(numbering: (..num) =>
    text(font: "Arial")[#numbering("(1.1)", counter(heading).get().first(), num.pos().first())]
  )
  set figure(numbering: (..num) =>
    numbering("1.1", counter(heading).get().first(), num.pos().first()))
  
  show figure.caption: it =>{ 
  set par(leading: 0.60em, justify: false)
  box(width: 86%, align(left)[#text(10pt, it)])
}
    
  set par(justify: true)

  doc
}


#let my-theme = ( // glossary styling
  // Main glossary section
  section: (title, body) => {
    body
  },

  // Group of related terms
  group: (name, index, total, body) => {
    // index = group index, total = total groups
    if name != "" and total > 1 {
      heading(level: 2, name)
    }
    body
  },

  // Individual glossary entry
  entry: (entry, index, total) => {
    // index = entry index, total = total entries in group
    let output = [#strong(entry.short)#entry.label] // **NOTE:** Label here!
    if entry.long != none {
      output = [#output #h(4pt) #entry.long]
    }
    block([#output.#h(8pt)#entry.pages]
    )
  }
)


#let template(
  thesis_title: [Insert the title of the dissertation, project or internship report, font Arial Bold, font size adjusted to the text box 12x12cm, left aligned],
  thesis_author: [Author’s name, Arial Plain, 18],
  course_name: [Course’s Name, Arial Plain, 12],
  department: [Department, Arial Plain, 10],
  faculty: [Faculty of Sciences of University of Porto and [name of\ the Faculty/Institution], Arial Plain, 10],
  year: [Year],
  thesis_type: [Dissertation/Internship/Project Report carried out as part of
the \[course 's name\], Arial Plain, 12],
  supervisor: [Supervisor’s Name, Category, Institution],
  co-supervisor: [Supervisor’s Name, Category, Institution],
  ext-supervisor: [Name, Professional status, Company’s name],
  theme_fig: align(center, text(size:12pt)[Insert a figure related to the theme\
    #h(2pt)
    
    (optional)]),
  Logo1: rect(width: 93%, height: 22%, fill: rgb(223, 220, 220))[
    #align(center+horizon)[
      #text(size: 14pt)[Logo]

      (company/research unit)

      #text(size: 10pt)[*[if applicable]*]
    ]],
  Logo2: rect(width: 93%, height: 22%, fill: rgb(223, 220, 220))[
    #align(center+horizon)[
      #text(size: 14pt)[Logo]

      (company/research unit)

      #text(size: 10pt)[*[if applicable]*]
    ]],
  Acknowledge: [Acknowledge ALL the people!],
  Resumo: [Esta tese é sobre alguma coisa],
  palavras-chave: [física (keywords em português)],
  Abstract: [This thesis is about something, I guess.],
  keywords: [physics],
  header-title: [MyThesis Title],
  doc
) = {
  
set-margin-note-defaults(rect: rect.with(fill: rgb(255, 150, 150, 40), radius:2pt)) 
  
set page(paper: "a4", margin: (top: 1.5cm, bottom: 1.5cm, left: 1.5cm, right: 0.08cm))

set heading(numbering: "1.")

set text(font: "Arial")

//---------------------------------------------------------

// Cover Page

v(24.2%)

grid(columns: (1.6fr, 0.83fr), rows: (1.5fr, 1.5fr), column-gutter: 1.8cm, row-gutter: 2.6cm,
align(bottom)[
    #set par(leading: 15pt)
  #text(size: 35pt, font: "Arial", weight: "bold",thesis_title)],
  [#v(1.26cm)
    #pad(align(right)[#image("Logos/FCUP.svg", width: 5.2cm)], right: 5pt )
#v(0.3cm)
#pad(align(right)[#image("Logos/FEUP.svg", width: 5.2cm)], right: 5pt )
#v(0.6cm)
#align(right)[#image("Logos/MSc.png", height: 124%)]
],
[ #text(size: 18pt, thesis_author)\
  #text(size: 12pt, course_name)\
  #text(size: 10pt, department)\
  #text(size: 10pt, faculty)\
  #text(size: 10pt, year)
]
)
pagebreak(weak: true)

//---------------------------------------------------------

// 2nd Cover Page

set page(margin: (right: 0.7cm))
v(10%)
align(right)[ #box(width: 40%, height: 18%, theme_fig)]

grid(columns: (2fr, 1fr), rows: (1.1fr, 1.6fr), column-gutter: 1.5cm, row-gutter: 1.5cm,
align(bottom)[
    #set par(leading: 15pt)
  #text(size: 35pt, font: "Arial", weight: "bold",thesis_title)], [],
[
  #text(size: 18pt,thesis_author)\
  #text(size: 12pt, thesis_type)\
  #text(size: 10pt, department)\
  #text(size: 10pt, year)

  *Supervisor*\
  #text(size: 11pt, supervisor)

  *Co-supervisor [if applicable]*\
  #text(size: 11pt, co-supervisor)

  *External Host Supervisor [if applicable]*\
  #text(size: 11pt, ext-supervisor)
],[
  #align(right)[
    #Logo1
    #v(-4pt)
    #Logo2
]])

pagebreak(weak: true)

counter(page).update(1)
set page(margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 3cm))

show raw: set text(font: "New Computer Modern Mono")
let code-line-num(num) = {
  if calc.odd(num) [#num] else {none}
}

show raw.where(block: true): it => {
  block(fill: rgb(240, 240, 240), width: 100%, inset: (top: 6pt, bottom: 6pt))[#set par.line(numbering: code-line-num)
  #it]
}

show math.equation: set text(font: "TeX Gyre Pagella Math")
set math.mat(delim: "[", row-gap: 1em, column-gap: 1em)

set text(size: 11pt)

set par(leading: 1.1em, spacing: 1.85em)

set list(spacing: 1.85em, indent: 1.57em)

show outline.entry.where(level:1, ): it => {
  v(18pt, weak: true)
  if it.body().fields() == "References" [Bibliography #box(width: 1fr, repeat[.]) #it.page] else {
  it}
}

show: init-glossary.with(myGlossary)

// Acknowledgments
special-heading[Acknowledgments]

Acknowledge
pagebreak(weak: true)

show: prepare-preamble.with(header_title: header-title)

// Abstract
special-heading[Resumo]

Resumo

v(8pt)
[Palavras-chave: #palavras-chave]

pagebreak(weak: true)

special-heading[Abstract]

Abstract

v(8pt)
[Keywords: #keywords]

pagebreak(weak: true)

// Table of Contents
in-outline.update(true)
special-heading[Table of Contents]

outline(title:none, indent: auto)

pagebreak(weak: true)

// List of Figures
special-heading(outlined: true)[List of Figures]

show: figure-outline.with(myGlossary)

pagebreak(weak: true)

// List of Abbreviations
special-heading(outlined: true)[List of Abbreviations]

glossary(theme: my-theme, sort: true)

show: prepare-thesis-body.with(header_title: header-title)

in-outline.update(false)

pagebreak(weak: true)

// THESIS BODY START

doc
}
