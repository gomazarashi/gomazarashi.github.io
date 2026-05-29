// content/index.typ

= gomazarashi Labs

#html.div(class: "metro-hero tile tile-accent")[
  #html.p(class: "hero-kicker")[personal publishing hub]
  #html.p(class: "hero-copy")[
    Typst と Tola を使って、技術記事、翻訳、個人開発の記録を整理しています。
  ]
  #html.div(class: "metro-actions")[
    #link("/posts/")[記事一覧]
    #link("/posts/20260412-first-post/")[最新記事]
  ]
]

#html.div(class: "metro-section")[
  #html.p(class: "section-kicker")[about]
  #html.div(class: "tile-grid tile-grid-wide")[
    #html.div(class: "tile tile-dark")[
      #html.p(class: "tile-title")[このサイトについて]
      #html.p(class: "tile-copy")[
        技術記事、翻訳、作成した資料、個人開発の内容をまとめるための個人サイトです。
      ]
      #html.p(class: "tile-copy")[
        自サイト内の記事に加えて、外部媒体の執筆物や関連資料への導線もここに集約します。
      ]
    ]

    #html.div(class: "tile tile-light")[
      #html.p(class: "tile-title")[構築環境]
      #html.div(class: "tile-list")[
        - *コンテンツ・マークアップ*: #link("https://typst.app")[Typst]
        - *静的サイト生成*: #link("https://github.com/tola-ssg/tola-ssg")[Tola]
        - *開発環境*: #link("https://nixos.org")[Nix]
        - *ホスティング・デプロイ*: #link("https://pages.github.com")[GitHub Pages]
      ]
      #html.p(class: "tile-note")[
        Repository: #link("https://github.com/gomazarashi/gomazarashi.github.io")[github.com/gomazarashi/gomazarashi.github.io]
      ]
    ]
  ]
]

#html.div(class: "metro-section")[
  #html.p(class: "section-kicker")[technical areas]
  #html.div(class: "tile-grid")[
    #html.div(class: "tile tile-cyan")[
      #html.p(class: "tile-title")[プログラミング / マークアップ]
      #html.div(class: "skill-block")[
        #html.p(class: "skill-label")[よく使う]
        #html.div(class: "tile-list")[
          - Typst
          - TeX
          - Python
          - HTML
          - CSS
          - JavaScript
        ]
      ]
      #html.div(class: "skill-block")[
        #html.p(class: "skill-label")[経験あり]
        #html.div(class: "tile-list")[
          - C++
          - C
          - R
          - P4
        ]
      ]
      #html.div(class: "skill-block")[
        #html.p(class: "skill-label")[勉強中]
        #html.div(class: "tile-list")[
          - Rust
          - TypeScript
        ]
      ]
    ]

    #html.div(class: "tile tile-blue")[
      #html.p(class: "tile-title")[フレームワーク / ライブラリ]
      #html.div(class: "skill-block")[
        #html.p(class: "skill-label")[よく使う]
        #html.div(class: "tile-list")[
          - Django
        ]
      ]
    ]

    #html.div(class: "tile tile-teal")[
      #html.p(class: "tile-title")[開発環境 / OS / ツール]
      #html.div(class: "skill-block")[
        #html.p(class: "skill-label")[よく使う]
        #html.div(class: "tile-list")[
          - Ubuntu
          - Nix / NixOS
          - uv
          - pytest
        ]
      ]
      #html.div(class: "skill-block")[
        #html.p(class: "skill-label")[経験あり]
        #html.div(class: "tile-list")[
          - Git
          - Docker / Docker Compose
        ]
      ]
    ]

    #html.div(class: "tile tile-dark")[
      #html.p(class: "tile-title")[配信 / 運用]
      #html.div(class: "skill-block")[
        #html.p(class: "skill-label")[よく使う]
        #html.div(class: "tile-list")[
          - GitHub Pages
        ]
      ]
      #html.div(class: "skill-block")[
        #html.p(class: "skill-label")[経験あり]
        #html.div(class: "tile-list")[
          - GitHub Actions
          - Nginx
        ]
      ]
    ]

    #html.div(class: "tile tile-light")[
      #html.p(class: "tile-title")[データベース]
      #html.div(class: "skill-block")[
        #html.p(class: "skill-label")[勉強中]
        #html.div(class: "tile-list")[
          - PostgreSQL
        ]
      ]
    ]

    #html.div(class: "tile tile-slate")[
      #html.p(class: "tile-title")[監視・可観測性]
      #html.div(class: "skill-block")[
        #html.p(class: "skill-label")[経験あり]
        #html.div(class: "tile-list")[
          - Grafana
        ]
      ]
    ]
  ]
]

#html.div(class: "metro-section")[
  #html.p(class: "section-kicker")[latest posts]
  #html.div(class: "tile-grid tile-grid-wide")[
    #html.div(class: "tile tile-light")[
      #html.p(class: "tile-title")[最新記事]
      #html.p(class: "entry-date")[2026-04-12]
      #html.p(class: "entry-title")[#link("/posts/20260412-first-post/")[最初の記事]]
      #html.p(class: "tile-copy")[
        サイト公開時に作成した最初の記事です。今後はこの欄を起点に新着記事を整理します。
      ]
    ]

    #html.div(class: "tile tile-cyan")[
      #html.p(class: "tile-title")[Posts]
      #html.p(class: "tile-copy")[
        公開済みの記事は一覧ページにまとめています。古い記事もここからたどれます。
      ]
      #html.p(class: "tile-link")[#link("/posts/")[記事一覧を開く]]
    ]
  ]
]

#html.div(class: "metro-section")[
  #html.p(class: "section-kicker")[external writing]
  #html.div(class: "tile-grid")[
    #html.div(class: "tile tile-blue")[
      #html.p(class: "tile-title")[外部メディア]
      #html.p(class: "tile-copy")[
        外部媒体へのリンクは準備中です。媒体別の入口と代表記事をまとまり次第ここに追加します。
      ]
    ]

    #html.div(class: "tile tile-teal")[
      #html.p(class: "tile-title")[予定している整理]
      #html.div(class: "tile-list")[
        - 媒体ごとの一覧リンク
        - 代表記事の抜粋
        - 技術テーマ別の導線
      ]
    ]
  ]
]
