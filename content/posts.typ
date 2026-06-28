// content/posts.typ

#import "../templates/page.typ": page
#show: page.with(
  title: "Posts",
  description: "公開済みの技術記事、翻訳、作成資料を一覧でまとめています。",
  path: "/posts/",
)

#html.div(class: "content-shell")[
  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[記事一覧]
    ]
    #html.div(class: "section-content")[
      #html.div(class: "post-list")[
        #html.article(class: "post-list-item")[
          #html.p(class: "entry-date")[2026-04-12]
          #html.div(class: "item-body")[
            #html.h3(class: "entry-title")[#link("/posts/20260412-first-post/")[最初の記事]]
            #html.p(class: "copy")[個人サイトの初期表示確認用の記事。]
          ]
        ]
      ]
    ]
  ]
]
