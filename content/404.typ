// content/404.typ

#import "../templates/page.typ": page

#show: page.with(
  title: "404 Not Found",
  description: "お探しのページは見つかりませんでした。",
  path: "/404.html",
)

#html.div(class: "content-shell")[
  #html.div(class: "content-section")[
    #html.p(class: "page-lead")[
      お探しのページは見つかりませんでした。URLが変更されたか、存在しないページを開いている可能性があります。
    ]
  ]

  #html.div(class: "content-section")[
    #html.div(class: "simple-grid")[
      #html.div(class: "simple-card card-accent-soft")[
        #html.p(class: "card-title")[トップページ]
        #html.p(class: "tile-copy")[
          サイト全体の入口に戻って、公開中の内容や最新記事を確認できます。
        ]
        #html.p(class: "hero-link")[#link("/")[トップページへ戻る]]
      ]

      #html.div(class: "simple-card card-neutral")[
        #html.p(class: "card-title")[記事一覧]
        #html.p(class: "tile-copy")[
          公開済みの記事を一覧で見たい場合は、記事一覧ページから探すことができます。
        ]
        #html.p(class: "hero-link")[#link("/posts/")[記事一覧を見る]]
      ]
    ]
  ]
]
