// utils/works.typ
//
// Single source of truth for public works and tools. / and /works/ render
// from this data; do not duplicate entries in pages.

#let featured = (
  name: "Machibumi",
  kicker: "位置情報付きメッセージアプリ",
  description: "地図上の場所にメッセージを残し、その周辺の投稿を見つけられるサービスです。",
  app-url: "https://machibumi.gomazarashi.com/",
  image: "/images/machibumi-map.webp",
  image-alt: "Machibumi の地図画面。地図上に投稿が表示されている。",
  image-width: 1179,
  image-height: 1312,
)

#let tools = (
  (
    name: "text-diff",
    category: "Web Tools",
    description: "ブラウザ内だけでテキスト差分を比較するツールです。",
    app-url: "https://gomazarashi.com/text-diff/",
    source-url: "https://github.com/gomazarashi/text-diff",
  ),
  (
    name: "simple-text-counter",
    category: "Web Tools",
    description: "入力内容をサーバーに送信せず、ブラウザ内だけで文字数を数えるツールです。",
    app-url: "https://gomazarashi.com/simple-text-counter/",
    source-url: "https://github.com/gomazarashi/simple-text-counter",
  ),
  (
    name: "nata",
    category: "CLI",
    description: "PDFをページ単位で扱う Rust 製CLIツールです。",
    app-url: none,
    source-url: "https://github.com/gomazarashi/nata",
  ),
)

// Featured project block, reused on / and /works/.
#let featured-project() = html.article(class: "featured-project")[
  #html.div(class: "featured-project-body")[
    #html.p(class: "featured-project-kicker")[#featured.kicker]
    #html.h3(class: "featured-project-title")[#featured.name]
    #html.p(class: "featured-project-description")[#featured.description]
    #html.div(class: "button-link")[#link(featured.at("app-url"))[アプリを開く]]
  ]
  #html.div(class: "featured-project-media")[
    #html.elem("img", attrs: (
      src: featured.image,
      alt: featured.at("image-alt"),
      width: str(featured.at("image-width")),
      height: str(featured.at("image-height")),
    ))
  ]
]

// Tool list item, reused on / and /works/.
#let tool-item(tool, show-category: false) = html.article(class: "list-item list-item-wide")[
  #if show-category [
    #html.div(class: "item-head")[
      #html.p(class: "label")[#tool.category]
      #html.p(class: "tool-code")[#tool.name]
    ]
  ] else [
    #html.p(class: "tool-code")[#tool.name]
  ]
  #html.div(class: "item-body")[
    #html.p(class: "copy")[#tool.description]
    #html.p(class: "inline-links")[
      #if tool.at("app-url") != none [
        #html.span(class: "inline-link")[#link(tool.at("app-url"))[ツールを開く]]
      ]
      #if tool.at("source-url") != none [
        #html.span(class: "inline-link")[#link(tool.at("source-url"))[ソースコード]]
      ]
    ]
  ]
]

#let tool-list(tools, show-category: false) = html.div(class: "list")[
  #for tool in tools [
    #tool-item(tool, show-category: show-category)
  ]
]
