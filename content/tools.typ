// content/tools.typ

#import "../templates/page.typ": page

#show: page.with(
  title: "ツール一覧",
  description: "公開しているツールを一覧でまとめています。",
  path: "/tools/",
)

#html.div(class: "content-shell")[
  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[公開ツール]
    ]
    #html.div(class: "section-content")[
      #html.div(class: "list")[
        #html.article(class: "list-item list-item-wide")[
          #html.p(class: "tool-code")[text-diff]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[ブラウザ内だけでテキスト差分を比較するツールです。]
            #html.p(class: "inline-links")[
              #html.span(class: "inline-link")[#link("https://gomazarashi.com/text-diff/")[ツールを開く]]
              #html.span(class: "inline-link")[#link("https://github.com/gomazarashi/text-diff")[ソースコード]]
            ]
          ]
        ]

        #html.article(class: "list-item list-item-wide")[
          #html.p(class: "tool-code")[simple-text-counter]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[入力内容をサーバーに送信せず、ブラウザ内だけで文字数を数えるツールです。]
            #html.p(class: "inline-links")[
              #html.span(class: "inline-link")[#link("https://gomazarashi.com/simple-text-counter/")[ツールを開く]]
              #html.span(class: "inline-link")[#link("https://github.com/gomazarashi/simple-text-counter")[ソースコード]]
            ]
          ]
        ]

        #html.article(class: "list-item list-item-wide")[
          #html.p(class: "tool-code")[nata]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[PDFをページ単位で扱う Rust 製CLIツールです。]
            #html.p(class: "inline-links")[
              #html.span(class: "inline-link")[#link("https://github.com/gomazarashi/nata")[ソースコード]]
            ]
          ]
        ]
      ]
    ]
  ]
]
