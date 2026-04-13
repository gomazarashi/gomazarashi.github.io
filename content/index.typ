// content/index.typ

= gomazarashi Labs

#html.div(class: "home-intro")[
  #html.p(class: "lead")[
    このサイトはTypst + Tola を用いて作成されています。
  ]
]

== Overview

gomazarashi Labs は、gomazarashi の技術記事や作成した資料、活動などをまとめるためのサイトです。
自サイト内の記事に加えて、外部に掲載した記事や資料への導線も、ここから順次整理していきます。

== About

gomazarashi は、Typst の翻訳と技術記事執筆を中心に活動しています。
Typst ドキュメントの日本語翻訳に関わりつつ、関連する内容を中心に記事を書いています。
また、記事執筆や翻訳と並行して個人開発も行っています。

=== Technical Areas

#html.div(class: "technical-areas")[
  #html.div(class: "area-card")[
    #html.p(class: "area-label")[Writing / Language]
    #html.div(class: "area-list")[
      - Typst
      - Python
      - Translation
      - Technical Writing
    ]
  ]

  #html.div(class: "area-card")[
    #html.p(class: "area-label")[Environment / Operations]
    #html.div(class: "area-list")[
      - Nix
      - Docker
      - nginx
      - Static Site Operation
    ]
  ]
]

== Latest Posts

自サイト内で公開している最近の記事です。
現時点では固定の導線として整理し、記事数が増えた段階で一覧の扱いを見直します。

#html.div(class: "link-panel-group")[
  #html.div(class: "link-panel")[
    #html.p(class: "panel-label")[Latest]
    #html.div(class: "panel-list")[
      - #link("/posts/first-post/")[最初の記事]
      - #link("/posts/example-second-post/")[二本目の記事の仮リンク]
      - #link("/posts/example-third-post/")[三本目の記事の仮リンク]
    ]
  ]
]

== External Writing

外部サイトに掲載している記事や資料への導線です。
媒体単位の入口と、代表的な記事をあわせて整理しています。

#html.div(class: "link-panel-group")[
  #html.div(class: "link-panel")[
    #html.p(class: "panel-label")[Platforms]
    #html.div(class: "panel-list")[
      - #link("https://example.com/qiita")[Qiita]
      - #link("https://example.com/oucrc")[OUCRC.net]
    ]
  ]

  #html.div(class: "link-panel")[
    #html.p(class: "panel-label")[Selected Writing]
    #html.div(class: "panel-list")[
      - #link("https://example.com/external-article-1")[代表記事 1]
      - #link("https://example.com/external-article-2")[代表記事 2]
    ]
  ]
]

== Posts

公開済みの記事は Posts ページにまとめています。
記事一覧から新しい順に確認できます。

#html.div(class: "link-panel-group")[
  #html.div(class: "link-panel")[
    #html.p(class: "panel-label")[Archive]
    #html.p(class: "panel-text")[
      #link("/posts/")[Posts を見る]
    ]
  ]
]
