// templates/page.typ

#import "site.typ": site

#let page(title: none, description: none, path: "/", body) = {
  site(title: title, description: description, path: path, meta-type: "website")[
    #html.div(class: "page-layout")[
      #if title != none [
        #html.header(class: "page-header")[
          #html.h1(class: "page-title")[#title]
        ]
      ]

      #html.div(class: "page-body")[
        #body
      ]
    ]
  ]
}
