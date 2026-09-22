// content/posts.typ

#import "../templates/page.typ": page
#import "../utils/articles.typ": all-articles, article-list-item

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
        #for article in all-articles() [
          #article-list-item(article)
        ]
      ]
    ]
  ]
]
