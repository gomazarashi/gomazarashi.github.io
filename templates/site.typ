// templates/site.typ

#let site(body) = {
  html.div(class: "site-shell")[
    html.div(class: "site-frame")[
      body
    ]
  ]
}
