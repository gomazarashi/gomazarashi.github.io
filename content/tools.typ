// content/tools.typ

#import "../templates/page.typ": page
#import "../utils/projects.typ": tool-list, tools

#show: page.with(
  title: "ツール一覧",
  heading: "Tools",
  heading-sub: "ツール一覧",
  description: "公開している小さなツールをまとめています。ブラウザで使えるWebツールとCLIツールの一覧です。",
)

#html.div(class: "content-shell")[
  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[公開ツール]
    ]
    #html.div(class: "section-content")[
      #html.p(class: "page-lead")[
        公開している小さなツールをまとめています。制作物全体は #link("/projects/")[Projects] で見られます。
      ]
      #tool-list(tools)
    ]
  ]
]
