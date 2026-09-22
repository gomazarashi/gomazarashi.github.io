// utils/components.typ
//
// Shared markup components used by multiple pages. CSS classes live in
// assets/styles/site.css.

#import "@preview/booticons:0.0.1": bsicon

// GitHub link with a decorative icon hidden from assistive technology.
#let github-link(url, label) = link(url)[
  #html.span(class: "github-link")[
    #html.span(class: "github-link-icon", aria-hidden: true)[#bsicon("github", height: 0.9em)]
    #html.span(class: "github-link-label")[#label]
  ]
]
