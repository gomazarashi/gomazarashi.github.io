// templates/post.typ

#import "site.typ": site

#let post(title: none, body) = {
  site[
    #if title != none [
      = #title
    ]

    #body
  ]
}
