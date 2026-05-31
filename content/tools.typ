// content/tools.typ

#import "../templates/page.typ": page

#show: page.with(
  title: "Tools",
  description: "公開しているツールを一覧でまとめています。ブラウザ内で使えるツールや公開中の CLI ツールを確認できます。",
  path: "/tools/",
)

#html.div(class: "content-shell")[
  #html.div(class: "content-section")[
    #html.p(class: "page-lead")[
      公開しているツールを一覧でまとめています。用途や公開先、Repository をここから確認できます。
    ]
  ]

  #html.div(class: "content-section")[
    #html.div(class: "simple-grid")[
      #html.div(class: "simple-card tool-card tool-card-text-diff")[
        #html.p(class: "card-title")[text-diff]
        #html.p(class: "tile-copy")[
          ブラウザ内だけでテキスト差分を比較するツールです。
        ]
        #html.p(class: "tile-copy")[
          入力内容の外部送信なし、保存なし。
        ]
        #html.p(class: "hero-link")[
          #link("https://gomazarashi.github.io/text-diff/")[ツールを開く]
        ]
        #html.p(class: "tile-copy")[
          #html.span(class: "inline-link")[
            #link("https://github.com/gomazarashi/text-diff")[Repository]
          ]
        ]
      ]

      #html.div(class: "simple-card tool-card tool-card-text-counter")[
        #html.p(class: "card-title")[simple-text-counter]
        #html.p(class: "tile-copy")[
          入力内容を送信せずに文字数を数える静的ツールです。
        ]
        #html.p(class: "tile-copy")[
          ブラウザ内処理、外部送信なし。
        ]
        #html.p(class: "hero-link")[
          #link("https://gomazarashi.com/simple-text-counter/")[ツールを開く]
        ]
        #html.p(class: "tile-copy")[
          #html.span(class: "inline-link")[
            #link("https://github.com/gomazarashi/simple-text-counter")[Repository]
          ]
        ]
      ]

      #html.div(class: "simple-card tool-card tool-card-nata")[
        #html.p(class: "card-title")[nata]
        #html.p(class: "tile-copy")[
          PDF をページ単位で扱う Rust 製 CLI ツールです。
        ]
        #html.p(class: "tile-copy")[
          #html.span(class: "inline-link")[
            #link("https://github.com/gomazarashi/nata")[Repository]
          ]
        ]
      ]
    ]
  ]
]
