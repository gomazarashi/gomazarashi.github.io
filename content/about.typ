// content/about.typ

#import "../templates/page.typ": page
#import "../utils/components.typ": github-link
#show: page.with(
  title: "About",
  heading-sub: "サイトについて",
  description: "gomazarashi のプロフィール、活動・コミュニティ、技術領域、このサイトについてをまとめています。",
)

#html.div(class: "content-shell")[
  // プロフィール
  #html.header(class: "profile-block", aria-label: "プロフィール")[
    #html.elem("picture")[
      #html.elem("img", attrs: (
        class: "profile-image",
        src: "/images/gomazarashi-256.webp",
        alt: "gomazarashi",
        width: "256",
        height: "256",
      ))
    ]
    #html.div(class: "profile-copy")[
      #html.h2(class: "profile-name")[gomazarashi]
      #html.div(class: "profile-bio")[
        #html.p[ネットワーク分野の大学院生です。Software-Defined Networking (SDN) を研究しています。]
        #html.p[Web アプリや小さなツールの開発、Typst / TeX などの組版にも取り組んでいます。]
      ]
      #html.p(class: "inline-links")[
        #html.span(class: "inline-link")[#github-link("https://github.com/gomazarashi", [GitHub])]
      ]
    ]
  ]

  // 活動・コミュニティ
  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[活動・コミュニティ]
    ]
    #html.div(class: "section-content")[
      #html.div(class: "list")[
        #html.article(class: "list-item")[
          #html.p(class: "label")[Typst Japanese Community]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[
              Typst Japanese Community で #link("https://github.com/typst-jp")[Typst Documentation 日本語版]のメンテナンス（翻訳・再翻訳）に参加しています。
            ]
          ]
        ]

        #html.article(class: "list-item")[
          #html.p(class: "label")[岡山大学電子計算機研究会（OUCRC）]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[
              岡山大学電子計算機研究会（OUCRC）に2022年度入部、現在はOBです。技術記事の執筆などを行いました。
            ]
            #html.p(class: "inline-links")[
              #html.span(class: "inline-link")[#link("https://oucrc.net/members/b6bud_yjl4q6/")[プロフィールを見る]]
            ]
          ]
        ]
      ]
    ]
  ]

  // 技術領域
  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[技術領域]
    ]
    #html.div(class: "section-content")[
      #html.div(class: "list")[
        #html.article(class: "list-item")[
          #html.p(class: "label")[スキル]
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
      ]
    ]
  ]

  // このサイトについて
  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[このサイトについて]
    ]
    #html.div(class: "section-content")[
      #html.div(class: "list")[
        #html.article(class: "list-item")[
          #html.p(class: "label")[構築環境]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[Typst と Tola で生成し、GitHub Pages で公開しています。]
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
]
