// og/post.typ
//
// Per-article OG image. Reads article metadata from the JSON produced by
// `tola query` (see scripts/build-og.py); no article data is duplicated here.
// Compile with:
//   typst compile --root . --ppi 144 --input og-font="Noto Sans JP" \
//     --input data=/.og/posts.json --input stem=20260412-first-post \
//     og/post.typ assets/images/og/posts/20260412-first-post.png

#import "brand.typ" as brand
#import "components.typ": *

#let data-path = sys.inputs.at("data")
#let stem = sys.inputs.at("stem")
#let posts = json(data-path)
#let record = posts.find(entry => entry.at("stem", default: none) == stem)
#if record == none {
  panic("OG metadata not found for stem: " + stem)
}

#show: og-page

#let source-path = record.at("path", default: stem)
#let title = record.at("title", default: "")
#let og-title = record.at("og-title", default: none)
#let image-title = if og-title != none and og-title != "" { og-title } else { title }
#let date = record.at("date", default: "")
#let author = record.at("author", default: none)
#let author = if author == none or author == "" { brand.author } else { author }
#let tags = record.at("tags", default: ())

#context {
  let head = text(size: brand.type.small, fill: brand.colors.secondary)[#brand.copy.posts-context]
  let meta = text(size: brand.type.meta, fill: brand.colors.secondary)[#date · #author]
  let tag-row = if tags.len() > 0 { fit-tags(tags, brand.text-width) } else { none }
  let tag-height = if tag-row == none { 0pt } else { measure(tag-row).height + brand.spacing }

  let fixed-height = measure(head).height + brand.spacing + measure(meta).height + tag-height
  let available-with-tags = brand.inner-height - fixed-height - brand.spacing
  let available-without-tags = brand.inner-height - (fixed-height - tag-height) - brand.spacing

  let fitted-with-tags = fit-title(image-title, brand.text-width, available-with-tags, 3)
  let fitted-without-tags = if fitted-with-tags == none {
    fit-title(image-title, brand.text-width, available-without-tags, 4)
  } else {
    none
  }
  let hide-tags = fitted-with-tags == none
  let fitted = if fitted-with-tags != none { fitted-with-tags } else { fitted-without-tags }

  if fitted == none {
    panic(
      "OG title overflow for " + source-path
        + ": shorten the title or set og-title metadata",
    )
  }

  place(center + horizon, card[
    #place(left + horizon, block(width: brand.text-width)[
      #head
      #v(brand.spacing)
      #fitted
      #v(brand.spacing)
      #meta
      #if tag-row != none and not hide-tags {
        v(brand.spacing)
        tag-row
      }
    ])
    #place(right + horizon, mascot-panel())
  ])
}
