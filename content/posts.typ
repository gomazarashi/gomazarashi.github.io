// content/posts.typ

#import "../templates/page.typ": page
#show: page.with(title: [Posts])

#html.div(class: "content-shell")[
  #html.div(class: "content-section")[
    #html.p(class: "page-lead")[
      公開済みの記事を新しい順にまとめています。
    ]
  ]

  #html.div(class: "content-section")[
    #html.div(class: "post-list")[
      #html.div(class: "simple-card post-list-item card-accent-soft")[
        #html.p(class: "entry-date")[2026-04-12]
        #html.p(class: "entry-title")[#link("/posts/20260412-first-post/")[最初の記事]]
        #html.p(class: "tile-copy")[個人サイトの初期表示確認のために作成した最初の記事です。]
      ]
    ]
  ]
]
