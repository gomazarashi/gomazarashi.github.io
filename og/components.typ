// og/components.typ
//
// Reusable visual primitives for OG images. og/default.typ and og/post.typ
// must compose these helpers instead of duplicating layout code.

#import "brand.typ" as brand

// Document-level setup. Use as `#show: og-page`.
#let og-page(body) = {
  set page(
    width: brand.canvas.width,
    height: brand.canvas.height,
    margin: 0pt,
    fill: brand.colors.background,
  )
  // `fallback: false` makes a missing Japanese glyph an explicit compile
  // error instead of a silent fallback to another font.
  set text(font: brand.font, fallback: false, fill: brand.colors.primary)
  body
}

#let card-surface(body) = block(
  width: brand.card.width,
  height: brand.card.height,
  radius: brand.card.radius,
  fill: brand.colors.card,
  stroke: 1pt + brand.colors.border,
  clip: true,
)[
  #place(
    bottom + left,
    rect(
      width: brand.card.width,
      height: brand.rainbow-strip-height,
      fill: brand.rainbow-gradient,
    ),
  )
  #place(
    top + left,
    dx: brand.card.inset,
    dy: brand.card.inset,
    block(
      width: brand.card.width - 2 * brand.card.inset,
      height: brand.card.height - 2 * brand.card.inset,
      body,
    ),
  )
]

// The centered white card with a soft shadow and the fixed rainbow strip.
#let card(body) = {
  let layers = brand.card.shadow-layers
  box(width: brand.card.width, height: brand.card.height)[
    #for layer in layers {
      place(
        top + left,
        dx: -layer.grow,
        dy: layer.dy,
        rect(
          width: brand.card.width + 2 * layer.grow,
          height: brand.card.height + 2 * layer.grow,
          radius: brand.card.radius + layer.grow,
          fill: layer.color,
        ),
      )
    }
    #place(top + left, card-surface(body))
  ]
}

// Light blue panel with the brand mascot, right side of the card.
#let mascot-panel() = {
  let pw = brand.mascot.panel-width
  let ph = brand.mascot.panel-height
  let pi = brand.mascot.panel-inset
  block(
    width: pw,
    height: ph,
    radius: brand.mascot.panel-radius,
    fill: brand.colors.mascot-panel,
    clip: true,
  )[
    #place(
      top + left,
      dx: pi,
      dy: pi,
      block(
        width: pw - 2 * pi,
        height: ph - 2 * pi,
        radius: brand.mascot.image-radius,
        clip: true,
      )[
        #image(
          brand.mascot.source,
          width: pw - 2 * pi,
          height: ph - 2 * pi,
          fit: "cover",
        )
      ],
    )
  ]
}

// Low-saturation tag chip. Every tag uses the same style on purpose.
#let tag-chip(label, size: brand.type.tag) = box(
  fill: brand.colors.tag-bg,
  radius: 20pt,
  inset: (x: 8pt, y: 4pt),
)[
  #text(size: size, fill: brand.colors.tag-text, label)
]

// Long tags: normal size, then slightly smaller, then (image only) ellipsis.
// Article metadata tags are never modified; this helper only affects the PNG.
#let fit-chip(label, max-width) = {
  for size in (brand.type.tag, brand.type.tag - 1pt) {
    let chip = tag-chip(label, size: size)
    if measure(chip).width <= max-width {
      return chip
    }
  }
  let clusters = label.clusters()
  let n = clusters.len()
  while n > 1 {
    let chip = tag-chip(clusters.slice(0, n).join() + "…", size: brand.type.tag - 1pt)
    if measure(chip).width <= max-width {
      return chip
    }
    n -= 1
  }
  tag-chip("…", size: brand.type.tag - 1pt)
}

// Tag row rules:
// - 0 tags    -> no row
// - 1..4 tags -> all tags
// - 5+ tags   -> first three + "+N"
// Tags keep their metadata order. Must be called from a context block.
#let fit-tags(tags, width) = {
  let shown = if tags.len() > 4 {
    tags.slice(0, 3) + ("+" + str(tags.len() - 3),)
  } else {
    tags
  }
  let spacing = 8pt
  let budget = (width - (shown.len() - 1) * spacing) / shown.len()
  let chips = shown.map(tag => fit-chip(tag, budget))
  stack(dir: ltr, spacing: spacing, ..chips)
}

// Add invisible break opportunities to long ASCII tokens (URLs, identifiers)
// for the image only. The HTML title string is never modified.
#let breakable-chars = ("/", ".", "-", "_", ":", "+")

#let break-tokens(value) = {
  let clusters = str(value).clusters()
  let parts = ()
  let run = 0
  for cluster in clusters {
    parts.push(cluster)
    if breakable-chars.contains(cluster) {
      parts.push(h(0pt, weak: true))
      run = 0
    } else {
      run += 1
      if run >= 14 {
        parts.push(h(0pt, weak: true))
        run = 0
      }
    }
  }
  parts.join()
}

// Reference height of exactly `lines` lines at `size`, used to reject
// candidates that would exceed the allowed line count.
#let lines-height(size, width, lines) = {
  let sample = text(size: size)[Ag]
  measure(block(width: width)[
    #set par(leading: brand.title-leading)
    #for index in range(lines) [
      #if index > 0 {
        linebreak()
      }
      #sample
    ]
  ]).height
}

#let title-block(value, size, width) = block(width: width)[
  #set par(leading: brand.title-leading)
  #text(size: size, weight: 700, break-tokens(value))
]

// Try title sizes from largest to smallest.
// Prefers a large size, but accepts one step (2pt) smaller when it saves at
// least one line, so short titles stay on a single line like the brand design.
// Returns a content block that fits `height` and `max-lines`, or `none`.
// Must be called from a context block.
#let fit-title(value, width, height, max-lines, sizes: brand.title-sizes) = {
  let best = none
  for size in sizes {
    let candidate = title-block(value, size, width)
    let measured = measure(candidate).height
    if measured > height {
      continue
    }
    let lines = none
    for count in range(1, max-lines + 1) {
      if measured <= lines-height(size, width, count) {
        lines = count
        break
      }
    }
    if lines == none {
      continue
    }
    if best == none {
      best = (size: size, lines: lines, content: candidate)
    } else if lines < best.lines and best.size - size <= 2pt {
      best = (size: size, lines: lines, content: candidate)
    }
  }
  if best == none { none } else { best.content }
}
