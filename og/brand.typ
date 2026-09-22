// og/brand.typ
//
// Single source of truth for OG image branding.
// Layout code must not hardcode colors, sizes, font families, or the mascot
// asset path; keep those here so the mascot source can be swapped (e.g. to an
// SVG) without touching og/components.typ, og/default.typ, or og/post.typ.

// Font is injected by scripts/build-og.py through `--input og-font=...`.
// The script fails the build unless "Noto Sans JP" or "Noto Sans CJK JP" is
// available, so Typst never silently falls back to another Japanese font.
#let font = sys.inputs.at("og-font", default: "Noto Sans JP")

// Default author used when an article has no `author` metadata.
// Injected by scripts/build-og.py from tola.toml ([site.info].author).
#let author = sys.inputs.at("og-author", default: "gomazarashi")

#let colors = (
  background: rgb("#FBFCFE"),
  card: rgb("#FFFFFF"),
  border: rgb("#D9E2EA"),
  shadow: rgb(20, 37, 58, 10),
  primary: rgb("#14253A"),
  secondary: rgb("#64748B"),
  tag-bg: rgb("#EEF2F6"),
  tag-text: rgb("#5F6F82"),
  mascot-panel: rgb("#E9F1F9"),
  rainbow: (
    rgb("#E58F9D"), // rose
    rgb("#E9A77F"), // orange
    rgb("#E3CF80"), // yellow
    rgb("#B9CE91"), // sage
    rgb("#85C5BA"), // aqua
    rgb("#88A9CC"), // dusty blue
    rgb("#AA96CE"), // violet
  ),
)

// Fixed brand element shared by every OG image. Horizontal, smooth gradient.
// Not data encoding: do not map article tags or categories onto these colors.
#let rainbow-gradient = gradient.linear(
  angle: 0deg,
  (colors.rainbow.at(0), 0%),
  (colors.rainbow.at(1), 100% / 6 * 1),
  (colors.rainbow.at(2), 100% / 6 * 2),
  (colors.rainbow.at(3), 100% / 6 * 3),
  (colors.rainbow.at(4), 100% / 6 * 4),
  (colors.rainbow.at(5), 100% / 6 * 5),
  (colors.rainbow.at(6), 100%),
)

// 600pt x 315pt at 144 ppi = exactly 1200 x 630 px.
#let canvas = (
  width: 600pt,
  height: 315pt,
)

#let card = (
  width: 567pt,
  height: 215pt,
  radius: 12pt,
  inset: 24pt,
  // Typst 0.14 has no shadow primitive; stack translucent rects to fake one.
  shadow-layers: (
    (dy: 2pt, grow: 0pt, color: rgb(20, 37, 58, 12)),
    (dy: 4pt, grow: 1.5pt, color: rgb(20, 37, 58, 10)),
    (dy: 7pt, grow: 3pt, color: rgb(20, 37, 58, 6)),
  ),
)

#let rainbow-strip-height = 14pt

// Mascot visual source (v1: the existing gomazarashi.jpg).
// Only this file references the asset path directly.
#let mascot = (
  source: "/assets/images/gomazarashi.jpg",
  panel-width: 146pt,
  panel-height: 149pt,
  panel-radius: 12pt,
  panel-inset: 10pt,
  image-radius: 8pt,
)

// Type scale, tuned against the reference OG designs.
#let type = (
  small: 13pt,
  meta: 13pt,
  description: 16pt,
  tag: 10.5pt,
  default-title: 44pt,
)

// Article title candidate sizes in pt (60..36 px at 144 ppi).
#let title-sizes = (30pt, 28pt, 26pt, 24pt, 22pt, 20pt, 18pt)

// The default card has fixed copy, so it can start larger.
#let default-title-sizes = (44pt, 40pt, 36pt, 32pt, 28pt)

// Tight leading for headlines.
#let title-leading = 0.5em

// Vertical rhythm between text blocks.
#let spacing = 12pt

#let copy = (
  domain: "gomazarashi.com",
  title: "gomazarashi Lab",
  description: "Network research, Typst, and small web tools",
  posts-context: "gomazarashi / posts",
)
