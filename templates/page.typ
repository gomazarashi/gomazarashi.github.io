// templates/page.typ

#import "site.typ": site

#let page(title: none, body) = {
  site[
    #html.div(class: "page-layout")[
      #if title != none [
        #html.div(class: "page-header")[
          #html.p(class: "page-title")[#title]
        ]
      ]

      #html.div(class: "page-body")[
        #body
      ]
    ]
  ]
}
