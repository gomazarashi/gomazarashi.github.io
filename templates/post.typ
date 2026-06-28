// templates/post.typ

#import "site.typ": site

#let post(title: none, description: none, path: "/", body) = {
  site(title: title, description: description, path: path, meta-type: "article")[
    #html.article(class: "post-layout")[
      #if title != none [
        #html.header(class: "post-header")[
          #html.h1(class: "page-title")[#title]
        ]
      ]

      #html.div(class: "post-body")[
        #body
      ]
    ]
  ]
}
