// templates/page.typ

#import "site.typ": site

#let page(
  title: none,
  description: none,
  path: none,
  show-title: true,
  og-image: none,
  og-image-alt: none,
  noindex: false,
  body,
) = {
  site(
    title: title,
    description: description,
    path: path,
    meta-type: "website",
    og-image: og-image,
    og-image-alt: og-image-alt,
    noindex: noindex,
  )[
    #html.div(class: "page-layout")[
      #if show-title and title != none [
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
