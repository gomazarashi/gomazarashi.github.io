// content/banners.typ

#import "../templates/page.typ": page

#show: page.with(
  title: "バナー配布",
  description: "gomazarashi Lab のリンク用バナーを配布しています。",
  path: "/banners/",
)

#html.div(class: "content-shell")[
  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[リンク用バナー]
    ]
    #html.div(class: "section-content")[
      #html.p(class: "page-lead")[gomazarashi Lab へのリンクにご利用ください。]

      #html.div(class: "link-banners")[
        #html.div(class: "banner-preview")[
          #html.elem("img", attrs: (
            src: "/images/banners/gomazarashi-lab-banner.png",
            alt: "gomazarashi Lab（通常色）",
            width: "400",
            height: "80",
          ))
        ]
        #html.div(class: "banner-preview")[
          #html.elem("img", attrs: (
            src: "/images/banners/gomazarashi-lab-banner-light.png",
            alt: "gomazarashi Lab（反転色）",
            width: "400",
            height: "80",
          ))
        ]
      ]

      #html.div(class: "list")[
        #html.article(class: "list-item")[
          #html.p(class: "label")[通常色]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[ティール色の背景に白い文字を載せた、高解像度の PNG です。表示サイズは 200 × 40 px を想定しています。]
            #html.p(class: "inline-links")[
              #html.span(class: "inline-link")[#link("/images/banners/gomazarashi-lab-banner.png")[PNG を開く]]
            ]
          ]
        ]
        #html.article(class: "list-item")[
          #html.p(class: "label")[反転色]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[白い背景にティール色の文字を載せた、高解像度の PNG です。]
            #html.p(class: "inline-links")[
              #html.span(class: "inline-link")[#link("/images/banners/gomazarashi-lab-banner-light.png")[PNG を開く]]
            ]
          ]
        ]
        #html.article(class: "list-item")[
          #html.p(class: "label")[まとめて取得]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[通常色・反転色の PNG を ZIP で配布しています。]
            #html.p(class: "inline-links")[
              #html.span(class: "inline-link")[#link("/images/banners/gomazarashi-lab-banners.zip")[ZIP をダウンロード]]
            ]
          ]
        ]
      ]
    ]
  ]

  #html.section(class: "section-block")[
    #html.header(class: "section-heading")[
      #html.h2(class: "section-title")[掲載例]
    ]
    #html.div(class: "section-content")[
      #html.p(class: "page-lead")[直リンクと、ダウンロードした画像を自サイトに置く方法のどちらにも対応しています。]
      #html.div(class: "list")[
        #html.article(class: "list-item")[
          #html.p(class: "label")[直リンク]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[次の HTML は、gomazarashi.com で配信している通常色バナーを参照します。]
            #html.pre(class: "banner-code")[#raw("<a href=\"https://gomazarashi.com/\"><img src=\"https://gomazarashi.com/images/banners/gomazarashi-lab-banner.png\" width=\"200\" height=\"40\" alt=\"gomazarashi Lab\"></a>")]
          ]
        ]
        #html.article(class: "list-item")[
          #html.p(class: "label")[ダウンロード]
          #html.div(class: "item-body")[
            #html.p(class: "copy")[ZIP を展開して画像を自サイトへ配置し、画像パスを置き換えてください。]
            #html.pre(class: "banner-code")[#raw("<a href=\"https://gomazarashi.com/\"><img src=\"/images/gomazarashi-lab-banner.png\" width=\"200\" height=\"40\" alt=\"gomazarashi Lab\"></a>")]
          ]
        ]
      ]
    ]
  ]
]
