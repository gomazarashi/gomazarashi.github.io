// content/index.typ

#import "../templates/page.typ": page
#import "../utils/articles.typ": latest-articles, article-list-item
#import "@preview/booticons:0.0.1": bsicon
#show: page.with(
  title: "gomazarashi Lab",
  description: "gomazarashiのWebサイトです。",
  show-title: false,
)

#let github-link(url, label) = link(url)[
  #html.span(class: "github-link")[
    #html.span(class: "github-link-icon")[#bsicon("github", height: 0.9em)]
    #html.span(class: "github-link-label")[#label]
  ]
]

#html.div(class: "content-shell")[
  #html.header(class: "profile-block", aria-label: "プロフィール")[
    #html.elem("picture")[
      #html.elem("img", attrs: (
        class: "profile-image",
        src: "/images/gomazarashi-256.webp",
        alt: "gomazarashi",
        width: "256",
        height: "256",
        fetchpriority: "high",
      ))
    ]
    #html.div(class: "profile-copy")[
      #html.h1(class: "profile-name")[gomazarashi]
      #html.div(class: "profile-bio")[
        #html.p[ネットワーク分野の大学院生です。研究分野は Software-Defined Networking (SDN) です。]
        #html.p[趣味ではネットワークや小さなツール開発、TeX・Typst などの組版システムに興味があります。]
      ]
      #html.p(class: "inline-links")[
        #html.span(class: "inline-link")[#github-link("https://github.com/gomazarashi", [GitHub])]
      ]
      #html.div(class: "action-row")[
        #html.p(class: "button-link")[#link("/posts/")[記事を読む]]
        #html.p(class: "button-link")[#link("/tools/")[ツールを見る]]
      ]
    ]
  ]

  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[公開ツール]
      #html.p(class: "hero-link")[#link("/tools/")[ツール一覧を見る]]
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

  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[活動・コミュニティ]
    ]
    #html.div(class: "section-content")[
      #html.div(class: "list")[
        #html.article(class: "list-item")[
          #html.p(class: "label")[Typst Japanese Community]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[Typst Documentation 日本語版のメンテナとして、日本語翻訳・再翻訳・ドキュメントのメンテナンスに参加しています。]
            #html.p(class: "inline-links")[
              #html.span(class: "inline-link")[#link("https://github.com/typst-jp")[GitHubで見る]]
            ]
          ]
        ]

        #html.article(class: "list-item")[
          #html.p(class: "label")[岡山大学電子計算機研究会（OUCRC）]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[2022年度入部、現在はOBです。技術記事の執筆などを行いました。]
            #html.p(class: "inline-links")[
              #html.span(class: "inline-link")[#link("https://oucrc.net/members/b6bud_yjl4q6/")[プロフィールを見る]]
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
      #html.div(class: "list")[
        #for article in latest-articles() [
          #article-list-item(article)
        ]
      ]
    ]
  ]

  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[発信]
    ]
    #html.div(class: "section-content")[
      #html.div(class: "list")[
        #html.article(class: "list-item")[
          #html.p(class: "label")[Qiita]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[Typst を中心とした技術記事を投稿しています。]
            #html.p(class: "hero-link")[#link("https://qiita.com/gomazarashi")[記事一覧を見る]]
          ]
        ]

        #html.article(class: "list-item")[
          #html.p(class: "label")[Docswell]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[勉強会などで使用したスライド資料を公開しています。]
            #html.p(class: "hero-link")[#link("https://www.docswell.com/user/gomazarashi")[スライド一覧を見る]]
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
      #html.div(class: "list")[
        #html.article(class: "list-item")[
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
              ]
            ]
            #html.div(class: "detail-group")[
              #html.p(class: "skill-heading")[研究・関心]
              #html.ul(class: "tag-list")[
                #html.li[SDN]
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

        #html.article(class: "list-item")[
          #html.p(class: "label")[フレームワーク / ライブラリ]
          #html.div(class: "detail-group")[
            #html.p(class: "skill-heading")[よく使う]
            #html.ul(class: "tag-list")[
              #html.li[Django]
            ]
          ]
        ]

        #html.article(class: "list-item")[
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

        #html.article(class: "list-item")[
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

        #html.article(class: "list-item")[
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
      #html.h2(class: "section-title")[サイト情報]
    ]
    #html.div(class: "section-content")[
      #html.div(class: "list")[
        #html.article(class: "list-item")[
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
      #html.h2(class: "section-title")[Links]
      #html.p(class: "hero-link")[#link("/banners/")[バナー配布]]
    ]
    #html.div(class: "section-content")[
      #html.div(class: "link-banners")[
        #html.a(class: "link-banner", href: "https://hinshiba.net/")[
          #html.elem("img", attrs: (
            src: "/images/links/hinshibanet_banner.webp",
            alt: "hinshiba.net",
            width: "200",
            height: "40",
            loading: "lazy",
          ))
        ]
        #html.a(class: "link-banner", href: "https://kemokemo.net/")[
          #html.elem("img", attrs: (
            class: "kemokemo-banner",
            src: "/images/links/kemokemo-banner.svg",
            alt: "KEMOKEMO.net",
            width: "927",
            height: "130",
            loading: "lazy",
          ))
        ]
        #html.a(class: "link-banner", href: "https://parallellollipoland.web.fc2.com/link/index.html")[
          #html.elem("img", attrs: (
            src: "/images/links/parallel-lollipop-land-banner.png",
            alt: "ぱられるろりぽらんど",
            width: "200",
            height: "40",
            loading: "lazy",
          ))
        ]
      ]
    ]
  ]
]
