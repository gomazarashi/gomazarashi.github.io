// content/index.typ

= gomazarashi Labs

#html.div(class: "hero reveal")[
  #html.div(class: "hero-actions")[
    #link("/posts/")[記事一覧を見る]
    #link("/posts/20260412-first-post/")[最新記事を読む]
  ]
]

== このサイトについて

#html.div(class: "colophon reveal")[
  #html.p(class: "colophon-title")[構築環境]
  #html.div(class: "colophon-stack")[
    - *コンテンツ・マークアップ*: #link("https://typst.app")[Typst]
    - *静的サイト生成*: #link("https://github.com/tola-ssg/tola-ssg")[Tola]
    - *開発環境*: #link("https://nixos.org")[Nix]
    - *ホスティング・デプロイ*: #link("https://pages.github.com")[GitHub Pages]
  ]

  #html.p(class: "colophon-note")[
    Repository: #link("https://github.com/gomazarashi/gomazarashi.github.io")[github.com/gomazarashi/gomazarashi.github.io]
  ]
]

== 技術スキル

#html.div(class: "tech-stack-grid")[
  #html.div(class: "tech-card reveal")[
    #html.p(class: "tech-layer")[言語とマークアップ]
    #html.div(class: "tech-list")[
      - Python
      - Typst
      - Bash / Shell
      - YAML
    ]
  ]

  #html.div(class: "tech-card reveal")[
    #html.p(class: "tech-layer")[フレームワークとツール]
    #html.div(class: "tech-list")[
      - Nix & NixOS
      - Docker & Compose
      - just (task runner)
      - Git
    ]
  ]

  #html.div(class: "tech-card reveal")[
    #html.p(class: "tech-layer")[開発・運用]
    #html.div(class: "tech-list")[
      - 静的サイト生成
      - nginx
      - GitHub Actions
      - SSH・コマンドライン
    ]
  ]

  #html.div(class: "tech-card reveal")[
    #html.p(class: "tech-layer")[プラットフォーム・サービス]
    #html.div(class: "tech-list")[
      - GitHub / Git hosting
      - GitHub Pages
      - Linux (Nix/NixOS)
    ]
  ]
]

== 最新記事

#html.div(class: "latest-post reveal")[
  #html.p(class: "latest-date")[2026-04-12]
  #html.p(class: "latest-title")[#link("/posts/20260412-first-post/")[最初の記事]]
  #html.p(class: "latest-summary")[
    サイト公開時に作成した最初の記事です。
    今後はこの欄に新着記事を追加します。
  ]
]

== 外部メディア

#html.div(class: "external-panel reveal")[
  #html.p(class: "panel-label")[外部メディア]
  #html.p(class: "panel-text")[
    外部媒体へのリンクは準備中です。
    まとまり次第、ここに追加します。
  ]
]
