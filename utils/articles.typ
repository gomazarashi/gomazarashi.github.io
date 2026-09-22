// utils/articles.typ
//
// Article list helpers. Derives everything from Tola's page metadata so that
// content/posts/*.typ stays the single source of truth for titles, dates, and
// summaries. Do not hand-write article entries in list pages.

#import "@tola/pages:0.0.0": pages

// Render an ISO date (YYYY-MM-DD) as a Japanese date. Uses integer conversion
// so leading zeros disappear (2026-04-05 -> 2026年4月5日).
#let format-jp-date(iso) = {
  if iso == none {
    return ""
  }
  let parts = str(iso).split("-")
  if parts.len() != 3 {
    return str(iso)
  }
  str(int(parts.at(0))) + "年" + str(int(parts.at(1))) + "月" + str(int(parts.at(2))) + "日"
}

// Article pages are the direct children of /posts/.
#let is-article(page) = {
  let permalink = str(page.at("permalink", default: ""))
  (
    permalink.starts-with("/posts/")
      and permalink != "/posts/"
      and permalink.slice("/posts/".len()).split("/").filter(part => part != "").len() == 1
  )
}

// Sort key for articles. Tola's scan phase can expose pages before their
// metadata is resolved; treat a missing date as empty so lists stay stable.
#let date-key(page) = {
  let date = page.at("date", default: none)
  if date == none { "" } else { str(date) }
}

// All articles, newest first (date descending). Pages without a date are
// skipped: Tola's scan phase exposes unresolved placeholders without one.
#let all-articles() = pages()
  .filter(is-article)
  .filter(page => page.at("date", default: none) != none)
  .sorted(key: date-key)
  .rev()

// The most recent article, as an array so it can drive a list. Safe when no
// pages are available yet (Tola's scan phase returns an empty list).
#let latest-articles() = {
  let articles = all-articles()
  articles.slice(0, calc.min(1, articles.len()))
}

// Shared list item for / and /posts/. Markup lives here once. Incomplete pages
// from Tola's scan phase (no title or date) are skipped.
#let article-list-item(article) = {
  let date = article.at("date", default: none)
  let title = article.at("title", default: none)
  if date == none or title == none {
    return
  }
  html.article(class: "list-item list-item-wide")[
    #html.p(class: "entry-date")[
      #html.elem("time", attrs: (datetime: date))[
        #format-jp-date(date)
      ]
    ]
    #html.div(class: "item-body")[
      #html.h3(class: "entry-title")[#link(article.permalink)[#article.title]]
      #html.p(class: "copy")[#article.at("summary", default: "")]
    ]
  ]
}
