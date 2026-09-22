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
    #html.span(class: "github-link-icon", aria-hidden: true)[#bsicon("github", height: 0.9em)]
    #html.span(class: "github-link-label")[#label]
  ]
]

#html.div(class: "content-shell")[
  // 1. Profile / Hero
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
        #html.p[ネットワーク分野の大学院生です。Software-Defined Networking (SDN) を研究しています。]
        #html.p[Web アプリや小さなツールの開発、Typst / TeX などの組版にも取り組んでいます。]
      ]
      #html.p(class: "inline-links")[
        #html.span(class: "inline-link")[#github-link("https://github.com/gomazarashi", [GitHub])]
      ]
      #html.div(class: "action-row")[
        #html.p(class: "button-link")[#link("/tools/")[ツールを見る]]
        #html.p(class: "button-link")[#link("/posts/")[記事を読む]]
      ]
    ]
  ]

  // 2. Featured Project
  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[Featured Project]
    ]
    #html.div(class: "section-content")[
      #html.article(class: "featured-project")[
        #html.div(class: "featured-project-body")[
          #html.p(class: "featured-project-kicker")[位置情報付きメッセージアプリ]
          #html.h3(class: "featured-project-title")[Machibumi]
          #html.p(class: "featured-project-description")[
            地図上の場所にメッセージを残し、その周辺の投稿を見つけられるサービスです。
          ]
          #html.div(class: "button-link")[#link("https://machibumi.gomazarashi.com/")[アプリを開く]]
        ]
        #html.div(class: "featured-project-media")[
          #html.elem("img", attrs: (
            src: "/images/machibumi-map.webp",
            alt: "Machibumi の地図画面。地図上に投稿が表示されている。",
            width: "1179",
            height: "1312",
          ))
        ]
      ]
    ]
  ]

  // 3. Tools
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

  // 4. Writing
  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[記事・資料]
      #html.p(class: "hero-link")[#link("/posts/")[記事一覧を見る]]
    ]
    #html.div(class: "section-content")[
      #html.div(class: "list")[
        #for article in latest-articles() [
          #article-list-item(article)
        ]

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

  // 5. Other information (kept compact for a future /about/ page)
  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[その他]
    ]
    #html.div(class: "section-content")[
      #html.div(class: "list")[
        #html.article(class: "list-item")[
          #html.p(class: "label")[活動・コミュニティ]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[
              Typst Japanese Community で #link("https://github.com/typst-jp")[Typst Documentation 日本語版]のメンテナンス（翻訳・再翻訳）に参加しています。
            ]
            #html.p(class: "copy")[
              岡山大学電子計算機研究会（OUCRC）に2022年度入部、現在はOBです。技術記事の執筆などを行いました。 #link("https://oucrc.net/members/b6bud_yjl4q6/")[プロフィール]
            ]
          ]
        ]

        #html.article(class: "list-item")[
          #html.p(class: "label")[技術領域]
          #html.div(class: "item-body")[
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
                  #html.li[Django]
                  #html.li[Ubuntu]
                  #html.li[uv]
                  #html.li[pytest]
                  #html.li[GitHub Pages]
                ]
              ]
              #html.div(class: "detail-group")[
                #html.p(class: "skill-heading")[経験あり]
                #html.ul(class: "tag-list")[
                  #html.li[C++]
                  #html.li[C]
                  #html.li[R]
                  #html.li[Git]
                  #html.li[Docker]
                  #html.li[Docker Compose]
                  #html.li[GitHub Actions]
                  #html.li[Nginx]
                  #html.li[Grafana]
                ]
              ]
              #html.div(class: "detail-group")[
                #html.p(class: "skill-heading")[勉強中]
                #html.ul(class: "tag-list")[
                  #html.li[Rust]
                  #html.li[TypeScript]
                  #html.li[PostgreSQL]
                ]
              ]
              #html.div(class: "detail-group")[
                #html.p(class: "skill-heading")[研究・関心]
                #html.ul(class: "tag-list")[
                  #html.li[SDN]
                  #html.li[P4]
                ]
              ]
            ]
          ]
        ]

        #html.article(class: "list-item")[
          #html.p(class: "label")[サイト情報]
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

        #html.article(class: "list-item")[
          #html.p(class: "label")[Links]
          #html.div(class: "item-body")[
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
    ]
  ]
]
