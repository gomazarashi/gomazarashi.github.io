// templates/site.typ

#import "../utils/meta.typ": page-head

#let site(title: none, description: none, path: "/", meta-type: "website", body) = {
  html.html[
    #html.head[
      #page-head(
        title: title,
        description: description,
        path: path,
        meta-type: meta-type,
      )
    ]
    #html.body[
      #html.script(src: "/styles/theme.js")[]
      #html.div(class: "site-shell")[
        #html.div(class: "site-frame")[
          #html.header(class: "site-header")[
            #html.nav(class: "site-nav", aria-label: "主要ナビゲーション")[
              #html.div(class: "site-nav-inner")[
                #html.a(class: "site-brand", href: "/")[gomazarashi Lab]
                #html.div(class: "site-nav-actions")[
                  #html.div(class: "site-nav-links")[
                    #html.a(href: "/")[ホーム]
                    #html.a(href: "/posts/")[記事一覧]
                    #html.a(href: "/tools/")[ツール]
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
          #html.main(class: "site-main")[
            #body
          ]
        ]
      ]
    ]
  ]
}
