// content/works.typ

#import "../templates/page.typ": page
#import "../utils/works.typ": featured-project, tool-list, tools

#show: page.with(
  title: "Works",
  heading-sub: "制作物",
  description: "gomazarashi の制作物をまとめています。位置情報付きメッセージアプリ Machibumi と、公開中の小さなツールを掲載しています。",
)

#html.div(class: "content-shell")[
  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[Featured Project]
    ]
    #html.div(class: "section-content")[
      #featured-project()
    ]
  ]

  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[Tools]
    ]
    #html.div(class: "section-content")[
      #tool-list(tools, show-category: true)
    ]
  ]
]
