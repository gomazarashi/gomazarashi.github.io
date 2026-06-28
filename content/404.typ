// content/404.typ

#import "../templates/page.typ": page

#show: page.with(
  title: "404 Not Found",
  description: "お探しのページは見つかりませんでした。",
  path: "/404.html",
)

#html.div(class: "content-shell")[
  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[ページが見つかりません]
    ]
    #html.div(class: "section-content")[
      #html.p(class: "page-lead")[URLが変更されたか、存在しないページです。]
      #html.div(class: "action-row")[
        #html.p(class: "button-link")[#link("/")[トップへ戻る]]
        #html.p(class: "button-link")[#link("/posts/")[記事一覧を見る]]
      ]
    ]
  ]
]
