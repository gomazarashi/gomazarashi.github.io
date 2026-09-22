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
  og-image-alt: none,
  og-image-width: 1200,
  og-image-height: 630,
  og-image-type: none,
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
        path: current-path,
        meta-type: meta-type,
        social-title: social-title,
        og-image: og-image,
        og-image-alt: og-image-alt,
        og-image-width: og-image-width,
        og-image-height: og-image-height,
        og-image-type: og-image-type,
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
                #nav-link("/", [ホーム], current-path == "/")
                #nav-link("/projects/", [Projects], str(current-path).starts-with("/projects/"))
                #nav-link("/posts/", [記事], str(current-path).starts-with("/posts/"))
                #nav-link("/about/", [About], str(current-path).starts-with("/about/"))
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
