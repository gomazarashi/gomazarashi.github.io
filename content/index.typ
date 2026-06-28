// content/index.typ

#import "../templates/page.typ": page
#import "@preview/booticons:0.0.1": bsicon
#show: page.with(
  title: "gomazarashi Lab",
  description: "Typst・Pythonを中心に、技術記事や個人開発ツールを公開している個人サイトです。",
  path: "/",
)

#let github-link(url, label) = link(url)[
  #html.span(class: "github-link")[
    #html.span(class: "github-link-icon")[#bsicon("github", height: 0.9em)]
    #html.span(class: "github-link-label")[#label]
  ]
]

#html.div(class: "content-shell")[
  #html.header(class: "intro-block")[
    #html.div(class: "intro-copy")[
      #html.p(class: "lede")[
        Typst、Python、個人開発ツールを中心に、作ったものを整理しています。
      ]
    ]
    #html.div(class: "action-row")[
      #html.p(class: "button-link")[#link("/posts/")[記事を読む]]
      #html.p(class: "button-link")[#link("/tools/")[ツールを見る]]
    ]
  ]

  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[このサイトについて]
    ]
    #html.div(class: "section-content")[
      #html.div(class: "profile-list")[
        #html.article(class: "profile-item")[
          #html.p(class: "label")[概要]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[技術記事、公開ツール、外部活動のまとめ。]
          ]
        ]

        #html.article(class: "profile-item")[
          #html.p(class: "label")[構築環境]
          #html.div(class: "item-body")[
            #html.ul(class: "tag-list")[
              #html.li[Typst]
              #html.li[CSS]
              #html.li[JavaScript]
              #html.li[Tola]
              #html.li[GitHub Pages]
            ]
            #html.p(class: "copy")[
              #html.span(class: "inline-link")[#github-link("https://github.com/gomazarashi/gomazarashi.github.io", [github.com/gomazarashi/gomazarashi.github.io])]
            ]
          ]
        ]
      ]
    ]
  ]

  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[技術領域]
    ]
    #html.div(class: "section-content")[
      #html.div(class: "skill-list")[
        #html.article(class: "skill-item")[
          #html.p(class: "label")[プログラミング / マークアップ]
          #html.div(class: "detail-stack")[
            #html.div(class: "detail-group")[
              #html.p(class: "skill-heading")[よく使う]
              #html.ul(class: "tag-list")[
                #html.li[Typst]
                #html.li[TeX]
                #html.li[Python]
                #html.li[HTML]
                #html.li[CSS]
                #html.li[JavaScript]
              ]
            ]
            #html.div(class: "detail-group")[
              #html.p(class: "skill-heading")[経験あり]
              #html.ul(class: "tag-list")[
                #html.li[C++]
                #html.li[C]
                #html.li[R]
                #html.li[P4]
              ]
            ]
            #html.div(class: "detail-group")[
              #html.p(class: "skill-heading")[勉強中]
              #html.ul(class: "tag-list")[
                #html.li[Rust]
                #html.li[TypeScript]
              ]
            ]
          ]
        ]

        #html.article(class: "skill-item")[
          #html.p(class: "label")[フレームワーク / ライブラリ]
          #html.div(class: "detail-group")[
            #html.p(class: "skill-heading")[よく使う]
            #html.ul(class: "tag-list")[
              #html.li[Django]
            ]
          ]
        ]

        #html.article(class: "skill-item")[
          #html.p(class: "label")[開発環境 / OS / ツール]
          #html.div(class: "detail-stack")[
            #html.div(class: "detail-group")[
              #html.p(class: "skill-heading")[よく使う]
              #html.ul(class: "tag-list")[
                #html.li[Ubuntu]
                #html.li[uv]
                #html.li[pytest]
              ]
            ]
            #html.div(class: "detail-group")[
              #html.p(class: "skill-heading")[経験あり]
              #html.ul(class: "tag-list")[
                #html.li[Git]
                #html.li[Docker]
                #html.li[Docker Compose]
              ]
            ]
          ]
        ]

        #html.article(class: "skill-item")[
          #html.p(class: "label")[配信 / 運用]
          #html.div(class: "detail-stack")[
            #html.div(class: "detail-group")[
              #html.p(class: "skill-heading")[よく使う]
              #html.ul(class: "tag-list")[
                #html.li[GitHub Pages]
              ]
            ]
            #html.div(class: "detail-group")[
              #html.p(class: "skill-heading")[経験あり]
              #html.ul(class: "tag-list")[
                #html.li[GitHub Actions]
                #html.li[Nginx]
              ]
            ]
          ]
        ]

        #html.article(class: "skill-item")[
          #html.p(class: "label")[データベース / 監視]
          #html.div(class: "detail-stack")[
            #html.div(class: "detail-group")[
              #html.p(class: "skill-heading")[勉強中]
              #html.ul(class: "tag-list")[
                #html.li[PostgreSQL]
              ]
            ]
            #html.div(class: "detail-group")[
              #html.p(class: "skill-heading")[経験あり]
              #html.ul(class: "tag-list")[
                #html.li[Grafana]
              ]
            ]
          ]
        ]
      ]
    ]
  ]

  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[外部活動]
    ]
    #html.div(class: "section-content")[
      #html.div(class: "activity-list")[
        #html.article(class: "activity-item")[
          #html.p(class: "label")[Qiita]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[Typst を中心とした技術記事を投稿しています。]
            #html.p(class: "hero-link")[#link("https://qiita.com/gomazarashi")[記事一覧を見る]]
          ]
        ]

        #html.article(class: "activity-item")[
          #html.p(class: "label")[Docswell]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[勉強会などで使用したスライド資料を公開しています。]
            #html.p(class: "hero-link")[#link("https://www.docswell.com/user/gomazarashi")[スライド一覧を見る]]
          ]
        ]

        #html.article(class: "activity-item")[
          #html.p(class: "label")[OUCRC]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[所属サークルのサイトに技術記事を投稿しています。]
            #html.p(class: "hero-link")[#link("https://oucrc.net/members/b6bud_yjl4q6/")[投稿記事を見る]]
          ]
        ]
      ]
    ]
  ]

  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[公開ツール]
      #html.p(class: "hero-link")[#link("/tools/")[ツール一覧を見る]]
    ]
    #html.div(class: "section-content")[
      #html.div(class: "tool-list")[
        #html.article(class: "tool-item")[
          #html.p(class: "tool-code")[text-diff]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[ブラウザ内だけでテキスト差分を比較するツールです。]
            #html.p(class: "inline-links")[
              #html.span(class: "inline-link")[#link("https://gomazarashi.com/text-diff/")[ツールを開く]]
              #html.span(class: "inline-link")[#link("https://github.com/gomazarashi/text-diff")[ソースコード]]
            ]
          ]
        ]

        #html.article(class: "tool-item")[
          #html.p(class: "tool-code")[simple-text-counter]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[入力内容をサーバーに送信せず、ブラウザ内だけで文字数を数えるツールです。]
            #html.p(class: "inline-links")[
              #html.span(class: "inline-link")[#link("https://gomazarashi.com/simple-text-counter/")[ツールを開く]]
              #html.span(class: "inline-link")[#link("https://github.com/gomazarashi/simple-text-counter")[ソースコード]]
            ]
          ]
        ]

        #html.article(class: "tool-item")[
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

  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[最新記事]
      #html.p(class: "hero-link")[#link("/posts/")[記事一覧を見る]]
    ]
    #html.div(class: "section-content")[
      #html.div(class: "post-list")[
        #html.article(class: "post-list-item")[
          #html.p(class: "entry-date")[2026-04-12]
          #html.div(class: "item-body")[
            #html.h3(class: "entry-title")[#link("/posts/20260412-first-post/")[最初の記事]]
            #html.p(class: "copy")[サイト公開時に作成した最初の記事です。今後はこの欄を起点に新着記事を整理します。]
          ]
        ]
      ]
    ]
  ]
]
