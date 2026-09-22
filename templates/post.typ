// templates/post.typ

#import "site.typ": site
#import "../utils/articles.typ": format-jp-date
#import "@tola/current:0.0.0": filename

#let post(
  title: none,
  summary: none,
  date: none,
  update: none,
  author: none,
  draft: false,
  tags: (),
  permalink: none,
  aliases: (),
  og-title: none,
  path: none,
  body,
) = {
  // Canonical article metadata for Tola (`tola query`, sitemap, draft handling).
  // Date/update must be Typst datetimes; do not pass plain strings.
  [#metadata((
    title: title,
    summary: summary,
    date: date,
    update: update,
    author: author,
    draft: draft,
    tags: tags,
    permalink: permalink,
    aliases: aliases,
    og-title: og-title,
  )) <tola-meta>]

  let file-stem = if filename == none {
    none
  } else {
    let name = str(filename)
    if name.ends-with(".typ") { name.slice(0, name.len() - 4) } else { name }
  }
  // Article OG images are keyed by the source stem under content/posts/.
  let image-path = if file-stem != none {
    "/images/og/posts/" + file-stem + ".png"
  } else {
    none
  }
  let published = if date != none { date.display("[year]-[month]-[day]") } else { none }
  let modified = if update != none { update.display("[year]-[month]-[day]") } else { none }

  site(
    title: title,
    description: summary,
    path: path,
    meta-type: "article",
    social-title: if og-title != none and str(og-title) != "" { og-title } else { title },
    og-image: image-path,
    article: (
      published: published,
      modified: modified,
      tags: tags,
    ),
  )[
    #html.article(class: "post-layout")[
      #if title != none [
        #html.header(class: "post-header")[
          #html.h1(class: "page-title")[#title]
          #if published != none [
            #html.div(class: "post-meta")[
              #html.elem("time", attrs: (datetime: published))[#format-jp-date(published)]
              #if modified != none [
                #html.span(class: "post-meta-update")[
                  更新: #html.elem("time", attrs: (datetime: modified))[#format-jp-date(modified)]
                ]
              ]
            ]
          ]
          #if tags.len() > 0 [
            #html.ul(class: "tag-list")[
              #for tag in tags [
                #html.li[#tag]
              ]
            ]
          ]
        ]
      ]

      #html.div(class: "post-body")[
        #body
      ]
    ]
  ]
}
