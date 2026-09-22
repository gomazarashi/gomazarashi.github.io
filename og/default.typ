// og/default.typ
//
// Shared OG image for fixed pages: /, /posts/, /tools/, /banners/, 404.
// Compile with:
//   typst compile --root . --ppi 144 --input og-font="Noto Sans JP" \
//     og/default.typ assets/images/og/default.png

#import "brand.typ" as brand
#import "components.typ": *

#show: og-page

#let inner-width = brand.card.width - 2 * brand.card.inset
#let inner-height = brand.card.height - 2 * brand.card.inset
#let text-width = inner-width - brand.mascot.panel-width - 16pt

#context {
  let title = fit-title(
    brand.copy.title,
    text-width,
    inner-height,
    1,
    sizes: brand.default-title-sizes,
  )
  if title == none {
    panic("default OG title overflow: " + brand.copy.title)
  }

  place(center + horizon, card[
    #place(left + horizon, block(width: text-width)[
      #text(size: brand.type.small, fill: brand.colors.secondary)[#brand.copy.domain]
      #v(brand.spacing)
      #title
      #v(brand.spacing)
      #text(size: brand.type.description, fill: brand.colors.secondary)[#brand.copy.description]
    ])
    #place(right + horizon, mascot-panel())
  ])
}
