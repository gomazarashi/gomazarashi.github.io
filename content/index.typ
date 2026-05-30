// content/index.typ

#import "../templates/page.typ": page
#show: page.with(title: [gomazarashi Labs])

#html.div(class: "content-shell")[
  #html.div(class: "content-section")[
    #html.p(class: "section-title")[このサイトについて]
    #html.div(class: "simple-grid simple-grid-stack")[
      #html.div(class: "simple-card card-accent-soft")[
        #html.p(class: "card-title")[概要]
        #html.p(class: "tile-copy")[
          技術記事、翻訳、作成した資料、個人開発の内容をまとめるための個人サイトです。
        ]
        #html.p(class: "tile-copy")[
          自サイト内の記事に加えて、関連する外部の情報も順次整理していきます。
        ]
      ]

      #html.div(class: "simple-card card-neutral")[
        #html.p(class: "card-title")[構築環境]
        #html.div(class: "simple-list")[
          - *コンテンツ・マークアップ*  
            #html.span(class: "inline-link")[#link("https://typst.app")[Typst]]
          - *静的サイト生成*  
            #html.span(class: "inline-link")[#link("https://github.com/tola-ssg/tola-ssg")[Tola]]
          - *開発環境*  
            #html.span(class: "inline-link")[#link("https://nixos.org")[Nix]]
          - *ホスティング・デプロイ*  
            #html.span(class: "inline-link")[#link("https://pages.github.com")[GitHub Pages]]
        ]
        #html.p(class: "card-note")[Repository]
        #html.p(class: "tile-copy")[
          #html.span(class: "inline-link")[#link("https://github.com/gomazarashi/gomazarashi.github.io")[github.com/gomazarashi/gomazarashi.github.io]]
        ]
      ]
    ]
  ]

  #html.div(class: "content-section")[
    #html.p(class: "section-title")[技術領域]
    #html.div(class: "simple-grid")[
      #html.div(class: "simple-card card-accent")[
        #html.p(class: "card-title")[プログラミング / マークアップ]
        #html.div(class: "skill-group")[
          #html.p(class: "skill-heading")[よく使う]
          #html.div(class: "simple-list")[
            - Typst
            - TeX
            - Python
            - HTML
            - CSS
            - JavaScript
          ]
        ]
        #html.div(class: "skill-group")[
          #html.p(class: "skill-heading")[経験あり]
          #html.div(class: "simple-list")[
            - C++
            - C
            - R
            - P4
          ]
        ]
        #html.div(class: "skill-group")[
          #html.p(class: "skill-heading")[勉強中]
          #html.div(class: "simple-list")[
            - Rust
            - TypeScript
          ]
        ]
      ]

      #html.div(class: "simple-card card-muted")[
        #html.p(class: "card-title")[フレームワーク / ライブラリ]
        #html.div(class: "skill-group")[
          #html.p(class: "skill-heading")[よく使う]
          #html.div(class: "simple-list")[
            - Django
          ]
        ]
      ]

      #html.div(class: "simple-card card-accent")[
        #html.p(class: "card-title")[開発環境 / OS / ツール]
        #html.div(class: "skill-group")[
          #html.p(class: "skill-heading")[よく使う]
          #html.div(class: "simple-list")[
            - Ubuntu
            - Nix / NixOS
            - uv
            - pytest
          ]
        ]
        #html.div(class: "skill-group")[
          #html.p(class: "skill-heading")[経験あり]
          #html.div(class: "simple-list")[
            - Git
            - Docker / Docker Compose
          ]
        ]
      ]

      #html.div(class: "simple-card card-muted")[
        #html.p(class: "card-title")[配信 / 運用]
        #html.div(class: "skill-group")[
          #html.p(class: "skill-heading")[よく使う]
          #html.div(class: "simple-list")[
            - GitHub Pages
          ]
        ]
        #html.div(class: "skill-group")[
          #html.p(class: "skill-heading")[経験あり]
          #html.div(class: "simple-list")[
            - GitHub Actions
            - Nginx
          ]
        ]
      ]

      #html.div(class: "simple-card card-neutral")[
        #html.p(class: "card-title")[データベース]
        #html.div(class: "skill-group")[
          #html.p(class: "skill-heading")[勉強中]
          #html.div(class: "simple-list")[
            - PostgreSQL
          ]
        ]
      ]

      #html.div(class: "simple-card card-accent-soft")[
        #html.p(class: "card-title")[監視・可観測性]
        #html.div(class: "skill-group")[
          #html.p(class: "skill-heading")[経験あり]
          #html.div(class: "simple-list")[
            - Grafana
          ]
        ]
      ]
    ]
  ]

  #html.div(class: "content-section")[
    #html.p(class: "section-title")[最新記事]
    #html.div(class: "simple-grid")[
      #html.div(class: "simple-card card-accent-soft")[
        #html.p(class: "entry-date")[2026-04-12]
        #html.p(class: "entry-title")[#link("/posts/20260412-first-post/")[最初の記事]]
        #html.p(class: "tile-copy")[
          サイト公開時に作成した最初の記事です。今後はこの欄を起点に新着記事を整理します。
        ]
      ]

      #html.div(class: "simple-card card-neutral")[
        #html.p(class: "card-title")[記事一覧]
        #html.p(class: "tile-copy")[
          公開済みの記事は一覧ページにまとめています。古い記事もここからたどれます。
        ]
        #html.p(class: "hero-link")[#link("/posts/")[記事一覧を見る]]
      ]
    ]
  ]
]
