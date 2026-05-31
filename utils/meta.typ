// utils/meta.typ

#let site-name = "gomazarashi Lab"
#let site-url = "https://gomazarashi.com"
#let default-description = "技術記事、翻訳、作成した資料、個人開発の内容をまとめる個人サイトです。"
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

#let meta-tag(name, content) = {
  if content != none and str(content) != "" {
    html.elem("meta", attrs: (name: name, content: str(content)))
  }
}

#let property-tag(name, content) = {
  if content != none and str(content) != "" {
    html.elem("meta", attrs: (property: name, content: str(content)))
  }
}

#let canonical-link(url) = {
  html.elem("link", attrs: (rel: "canonical", href: url))
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
    #html.title[#resolved-title]
    #meta-tag("description", description)
    #canonical-link(canonical)
    #property-tag("og:title", resolved-title)
    #property-tag("og:description", description)
    #property-tag("og:url", canonical)
    #property-tag("og:type", meta-type)
    #property-tag("og:site_name", site-name)
    #property-tag("og:locale", site-locale)
    #meta-tag("twitter:card", twitter-card)
  ]
}
