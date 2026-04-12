// templates/page.typ

#import "site.typ": site

#let page(title: none, body) = {
  site[
    #if title != none [
      = #title
    ]

    #body
  ]
}
