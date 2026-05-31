// templates/post.typ

#import "site.typ": site

#let post(title: none, description: none, path: "/", body) = {
  site(title: title, description: description, path: path, meta-type: "article")[
    #html.div(class: "post-layout")[
      #if title != none [
        #html.div(class: "post-header")[
          #html.p(class: "section-kicker")[post]
          #html.p(class: "page-title")[#title]
          #html.div(class: "post-meta")[
            #html.p(class: "meta-chip")[typst / tola]
            #html.p(class: "meta-text")[個人サイトの記事ページ]
          ]
        ]
      ]

      #html.div(class: "post-body")[
        #body
      ]
    ]
  ]
}
