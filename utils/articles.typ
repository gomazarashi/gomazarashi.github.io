// utils/articles.typ
//
// Article list helpers. Derives everything from Tola's page metadata so that
// content/posts/*.typ stays the single source of truth for titles, dates, and
// summaries. Do not hand-write article entries in list pages.

#import "@tola/pages:0.0.0": pages

// Render an ISO date (YYYY-MM-DD) as a Japanese date. Uses integer conversion
// so leading zeros disappear (2026-04-05 -> 2026年4月5日).
#let format-jp-date(iso) = {
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

// All articles, newest first (date descending).
#let all-articles() = pages()
  .filter(is-article)
  .sorted(key: page => str(page.at("date", default: "")))
  .rev()

// Latest `limit` articles. Safe when no pages are available yet (Tola's scan
// phase returns an empty list, so slice must not run past the array end).
#let latest-articles(limit: 1) = {
  let articles = all-articles()
  articles.slice(0, calc.min(limit, articles.len()))
}
