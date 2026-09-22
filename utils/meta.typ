// utils/meta.typ

#let site-name = "gomazarashi Lab"
#let site-url = "https://gomazarashi.com"
#let default-description = "gomazarashiのWebサイトです。"
#let site-locale = "ja_JP"
#let twitter-card = "summary_large_image"

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

#let canonical-url(path) = {
  let normalized = ensure-leading-slash(path)
  if normalized == "/" {
    site-url + "/"
  } else {
    site-url + normalized
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

#let head-meta(attrs, content) = {
  if content != none and str(content) != "" {
    html.elem("meta", attrs: attrs + (content: str(content)))
  }
}

#let canonical-link(url) = {
  html.elem("link", attrs: (rel: "canonical", href: url))
}

#let viewport-meta() = {
  html.elem("meta", attrs: (name: "viewport", content: "width=device-width, initial-scale=1"))
}

#let page-head(title: none, description: none, path: "/", meta-type: "website") = {
  let description = if description == none or str(description) == "" {
    default-description
  } else {
    str(description)
  }
  let canonical = canonical-url(path)
  let resolved-title = page-title(title, path: path)

  [
    #html.elem("meta", attrs: (charset: "utf-8"))
    #html.title[#resolved-title]
    #viewport-meta()
    #html.elem("link", attrs: (rel: "preconnect", href: "https://fonts.googleapis.com"))
    #html.elem("link", attrs: (rel: "preconnect", href: "https://fonts.gstatic.com", crossorigin: "anonymous"))
    #html.elem("link", attrs: (rel: "stylesheet", href: "https://fonts.googleapis.com/css2?family=Gugi&family=Noto+Sans+JP:wght@400;500;700;800&display=swap"))
    #head-meta((name: "description"), description)
    #canonical-link(canonical)
    #html.elem("link", attrs: (rel: "icon", href: "/images/favicon.ico", sizes: "any"))
    #html.elem("link", attrs: (rel: "icon", type: "image/png", sizes: "96x96", href: "/images/favicon-96.png"))
    #html.elem("link", attrs: (rel: "apple-touch-icon", sizes: "180x180", href: "/images/apple-touch-icon.png"))
    #head-meta((property: "og:title"), resolved-title)
    #head-meta((property: "og:description"), description)
    #head-meta((property: "og:url"), canonical)
    #head-meta((property: "og:type"), meta-type)
    #head-meta((property: "og:site_name"), site-name)
    #head-meta((property: "og:locale"), site-locale)
    #head-meta((name: "twitter:card"), twitter-card)
  ]
}
