// templates/site.typ

#let site(body) = {
  [
    #html.script(src: "/styles/theme.js")[]
    #html.div(class: "site-shell")[
      #html.div(class: "site-frame")[
        #html.nav(class: "site-nav")[
          #html.div(class: "site-nav-inner")[
            #html.div(class: "site-nav-links")[
              #html.a(href: "/")[ホーム]
              #html.span(class: "site-nav-separator")[#text("/")]
              #html.a(href: "/posts/")[記事一覧]
            ]
            #html.button(class: "theme-toggle", id: "theme-toggle", type: "button")[Dark]
          ]
        ]
        #body
      ]
    ]
  ]
}
