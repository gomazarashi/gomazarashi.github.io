// templates/site.typ

#import "../utils/meta.typ": page-head
#import "@tola/current:0.0.0": current-permalink

#let site(
  title: none,
  description: none,
  path: none,
  meta-type: "website",
  social-title: none,
  og-image: none,
  article: none,
  noindex: false,
  body,
) = {
  let current-path = if path != none {
    path
  } else if current-permalink != none {
    current-permalink
  } else {
    "/"
  }

  let nav-link(href, label, sub, active) = {
    let label-content = html.span(class: "site-nav-label")[#label]
    let sub-content = html.span(class: "site-nav-sub", lang: "ja", aria-hidden: true)[#sub]
    if active {
      html.a(href: href, aria-current: "page", lang: "en")[#label-content#sub-content]
    } else {
      html.a(href: href, lang: "en")[#label-content#sub-content]
    }
  }

  html.html[
    #html.head[
      #page-head(
        title: title,
        description: description,
        path: current-path,
        meta-type: meta-type,
        social-title: social-title,
        og-image: og-image,
        article: article,
        noindex: noindex,
      )
      #html.script(src: "/styles/theme.js")[]
    ]
    #html.body[
      #html.div(class: "skip-link-wrap")[
        #html.a(class: "skip-link", href: "#main-content")[メインコンテンツへスキップ]
      ]
      #html.header(class: "site-header")[
        #html.nav(class: "site-nav", aria-label: "主要ナビゲーション")[
          #html.div(class: "site-nav-inner")[
            #html.div(class: "site-brand")[
              #html.p(class: "site-brand-label")[#link("/")[gomazarashi Lab]]
            ]
            #html.div(class: "site-nav-actions")[
              #html.div(class: "site-nav-links")[
                #nav-link("/", [Home], [ホーム], current-path == "/")
                #nav-link("/projects/", [Projects], [プロジェクト], str(current-path).starts-with("/projects/"))
                #nav-link("/posts/", [Posts], [記事], str(current-path).starts-with("/posts/"))
                #nav-link("/about/", [About], [サイトについて], str(current-path).starts-with("/about/"))
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
        #html.main(class: "site-main", id: "main-content")[
          #body
        ]
      ]
      #html.footer(class: "site-footer")[
        #html.div(class: "site-footer-inner")[
          #html.p(class: "site-footer-note")[© gomazarashi — Built with Typst + Tola]
          #html.nav(class: "site-footer-nav", aria-label: "フッターナビゲーション")[
            #link("/projects/")[Projects]
            #link("/tools/")[Tools]
            #link("/about/")[About]
            #link("https://github.com/gomazarashi")[GitHub]
            #link("https://github.com/gomazarashi/gomazarashi.github.io")[Source]
          ]
        ]
      ]
    ]
  ]
}
