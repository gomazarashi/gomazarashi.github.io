// utils/meta.typ
//
// Central responsibility for <head> metadata: canonical URL, Open Graph,
// Twitter Card, and article-specific tags. Site-level values come from
// tola.toml via @tola/site; the current page path comes from @tola/current.
// Do not hardcode site URL/title here.

#import "@tola/site:0.0.0": info as site-info
#import "@tola/current:0.0.0": current-permalink

#let site-name = site-info.title
#let site-url = if site-info.url == none { "" } else { str(site-info.url) }
#let default-description = site-info.description
#let site-author = site-info.author
#let og-locale = site-info.extra.at("og_locale", default: "ja_JP")

// v1: every fixed page shares this image; one PNG per published article.
#let default-og-image = "/images/og/default.png"

#let ensure-leading-slash(path) = {
  let path = str(path)
  if path == "" or path == "/" {
    "/"
  } else if path.starts-with("/") {
    path
  } else {
    "/" + path
  }
}

#let absolute-url(path) = {
  let path = str(path)
  if path.starts-with("https://") or path.starts-with("http://") {
    path
  } else {
    site-url + ensure-leading-slash(path)
  }
}

#let page-title(title, path: "/") = {
  let normalized = ensure-leading-slash(path)
  if normalized == "/" or title == none {
    site-name
  } else {
    str(title) + " | " + site-name
  }
}

#let image-type(path) = {
  let path = str(path)
  if path.ends-with(".jpg") or path.ends-with(".jpeg") {
    "image/jpeg"
  } else if path.ends-with(".webp") {
    "image/webp"
  } else if path.ends-with(".gif") {
    "image/gif"
  } else {
    "image/png"
  }
}

#let default-og-image-alt = site-name + " — Network research, Typst, and small web tools のOG画像"

#let head-meta(attrs, content) = {
  if content != none and str(content) != "" {
    html.elem("meta", attrs: attrs + (content: str(content)))
  }
}

// Structured data (JSON-LD). Only values already available from site config
// and page metadata are emitted; never invent facts.
#let json-ld-script(data) = {
  html.elem("script", attrs: (type: "application/ld+json"))[#json.encode(data)]
}

#let person-structured-data() = {
  let base = (
    ("@type"): "Person",
    name: site-author,
    url: absolute-url("/about/"),
  )
  let github = site-info.extra.at("github", default: none)
  if github != none and str(github) != "" {
    (..base, sameAs: (str(github),))
  } else {
    base
  }
}

#let page-head(
  title: none,
  description: none,
  path: none,
  meta-type: "website",
  social-title: none,
  og-image: none,
  og-image-alt: none,
  og-image-width: 1200,
  og-image-height: 630,
  og-image-type: none,
  article: none,
  noindex: false,
) = {
  let current-path = if path != none {
    path
  } else if current-permalink != none {
    current-permalink
  } else {
    "/"
  }
  let description = if description == none or str(description) == "" {
    default-description
  } else {
    str(description)
  }
  let canonical = absolute-url(current-path)
  let resolved-title = page-title(title, path: current-path)
  let social = if social-title != none and str(social-title) != "" {
    str(social-title)
  } else {
    resolved-title
  }
  let image-path = if og-image == none or str(og-image) == "" {
    default-og-image
  } else {
    str(og-image)
  }
  let image-url = absolute-url(image-path)
  let image-type-value = if og-image-type != none {
    str(og-image-type)
  } else {
    image-type(image-path)
  }
  let image-alt = if og-image-alt != none and str(og-image-alt) != "" {
    str(og-image-alt)
  } else if article != none and title != none {
    "「" + str(title) + "」— " + site-author + " の記事OG画像"
  } else {
    default-og-image-alt
  }

  [
    #html.elem("meta", attrs: (charset: "utf-8"))
    #html.title[#resolved-title]
    #html.elem("meta", attrs: (name: "viewport", content: "width=device-width, initial-scale=1"))
    #html.elem("link", attrs: (rel: "preconnect", href: "https://fonts.googleapis.com"))
    #html.elem("link", attrs: (rel: "preconnect", href: "https://fonts.gstatic.com", crossorigin: "anonymous"))
    #html.elem("link", attrs: (rel: "stylesheet", href: "https://fonts.googleapis.com/css2?family=Gugi&family=Noto+Sans+JP:wght@400;500;700;800&display=swap"))
    #head-meta((name: "description"), description)
    #html.elem("link", attrs: (rel: "canonical", href: canonical))
    #html.elem("link", attrs: (rel: "icon", href: "/images/favicon.ico", sizes: "any"))
    #html.elem("link", attrs: (rel: "icon", type: "image/png", sizes: "96x96", href: "/images/favicon-96.png"))
    #html.elem("link", attrs: (rel: "apple-touch-icon", sizes: "180x180", href: "/images/apple-touch-icon.png"))
    #head-meta((property: "og:title"), social)
    #head-meta((property: "og:description"), description)
    #head-meta((property: "og:url"), canonical)
    #head-meta((property: "og:type"), meta-type)
    #head-meta((property: "og:site_name"), site-name)
    #head-meta((property: "og:locale"), og-locale)
    #head-meta((property: "og:image"), image-url)
    #head-meta((property: "og:image:width"), og-image-width)
    #head-meta((property: "og:image:height"), og-image-height)
    #head-meta((property: "og:image:type"), image-type-value)
    #head-meta((property: "og:image:alt"), image-alt)
    #head-meta((name: "twitter:card"), "summary_large_image")
    #head-meta((name: "twitter:title"), social)
    #head-meta((name: "twitter:description"), description)
    #head-meta((name: "twitter:image"), image-url)
    #head-meta((name: "twitter:image:alt"), image-alt)
    #if article != none [
      #head-meta((property: "article:published_time"), article.at("published", default: none))
      #head-meta((property: "article:modified_time"), article.at("modified", default: none))
      #for tag in article.at("tags", default: ()) [
        #head-meta((property: "article:tag"), tag)
      ]
    ]
    #if noindex [
      #html.elem("meta", attrs: (name: "robots", content: "noindex"))
    ]
    #if current-path == "/" [
      #json-ld-script((
        ("@context"): "https://schema.org",
        ("@graph"): (
          (
            ("@type"): "WebSite",
            name: site-name,
            url: absolute-url("/"),
            description: description,
            inLanguage: site-info.language,
          ),
          person-structured-data(),
        ),
      ))
    ]
    #if article != none [
      #json-ld-script((
        ("@context"): "https://schema.org",
        ("@type"): "BlogPosting",
        headline: title,
        description: description,
        inLanguage: site-info.language,
        mainEntityOfPage: canonical,
        author: person-structured-data(),
        ..(if article.at("published", default: none) != none { (datePublished: article.at("published")) } else { (:) }),
        ..(if article.at("modified", default: none) != none { (dateModified: article.at("modified")) } else { (:) }),
        ..(if article.at("tags", default: ()).len() > 0 { (keywords: article.at("tags")) } else { (:) }),
      ))
    ]
  ]
}
