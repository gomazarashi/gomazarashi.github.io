// templates/site.typ

#import "../utils/meta.typ": page-head

#let site(title: none, description: none, path: "/", meta-type: "website", body) = {
  let nav-link(href, label, active) = {
    if active {
      html.a(href: href, aria-current: "page")[#label]
    } else {
      html.a(href: href)[#label]
    }
  }

  html.html[
    #html.head[
      #page-head(
        title: title,
        description: description,
        path: path,
        meta-type: meta-type,
      )
      #html.script(src: "/styles/theme.js")[]
    ]
    #html.body[
      #html.header(class: "site-header")[
        #html.nav(class: "site-nav", aria-label: "主要ナビゲーション")[
          #html.div(class: "site-nav-inner")[
            #html.div(class: "site-brand")[
              #html.p(class: "site-brand-label")[#link("/")[gomazarashi Lab]]
            ]
            #html.div(class: "site-nav-actions")[
              #html.div(class: "site-nav-links")[
                #nav-link("/", [ホーム], path == "/")
                #nav-link("/posts/", [記事一覧], str(path).starts-with("/posts/"))
                #nav-link("/tools/", [ツール], str(path).starts-with("/tools/"))
              ]
              #html.button(
                class: "theme-toggle",
                id: "theme-toggle",
                type: "button",
                aria-label: "ダークモードに切り替え",
              )[
                #html.span(class: "theme-toggle-track")[
                  #html.span(class: "theme-toggle-icon theme-toggle-icon-sun", aria-hidden: true)[]
                  #html.span(class: "theme-toggle-knob", aria-hidden: true)[
                    #html.span(class: "theme-toggle-icon theme-toggle-icon-moon")[]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
      #html.div(class: "site-shell")[
        #html.main(class: "site-main")[
          #body
        ]
      ]
    ]
  ]
}
