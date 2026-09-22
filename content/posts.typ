// content/posts.typ

#import "../templates/page.typ": page
#show: page.with(
  title: "記事一覧",
  description: "公開済みの技術記事、翻訳、作成資料を一覧でまとめています。",
)

#html.div(class: "content-shell")[
  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[公開中の記事]
    ]
    #html.div(class: "section-content")[
      #html.div(class: "list")[
        #html.article(class: "list-item list-item-wide")[
          #html.p(class: "entry-date")[#html.elem("time", attrs: (datetime: "2026-04-12"))[2026年4月12日]]
          #html.div(class: "item-body")[
            #html.h3(class: "entry-title")[#link("/posts/20260412-first-post/")[最初の記事]]
            #html.p(class: "copy")[サイト公開時に作成した最初の記事です。]
          ]
        ]
      ]
    ]
  ]
]
