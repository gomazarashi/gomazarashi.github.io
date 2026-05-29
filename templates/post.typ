// templates/post.typ

#import "site.typ": site

#let post(title: none, body) = {
  site[
    html.div(class: "post-layout")[
      if title != none [
        html.div(class: "post-header tile tile-accent")[
          html.p(class: "section-kicker")[post]
          html.p(class: "page-title")[title]
          html.div(class: "post-meta")[
            html.p(class: "meta-chip")[typst / tola]
            html.p(class: "meta-text")[個人サイトの記事ページ]
          ]
        ]
      ]

      html.div(class: "post-body tile")[
        body
      ]
    ]
  ]
}
