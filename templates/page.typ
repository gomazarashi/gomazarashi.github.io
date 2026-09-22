// templates/page.typ

#import "site.typ": site

#let page(
  title: none,
  heading: none,
  heading-sub: none,
  description: none,
  path: none,
  show-title: true,
  og-image: none,
  og-image-alt: none,
  noindex: false,
  body,
) = {
  let h1-label = if heading != none { heading } else { title }
  let h1-content = html.span(class: "page-title-label", lang: "en")[#h1-label]
  if heading-sub != none {
    h1-content += html.span(class: "page-title-sub")[#heading-sub]
  }

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
          #html.h1(class: "page-title")[#h1-content]
        ]
      ]

      #html.div(class: "page-body")[
        #body
      ]
    ]
  ]
}
