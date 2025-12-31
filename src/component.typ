/// Document components

#import "@preview/conjak:0.2.3": *
#import "@preview/numbly:0.1.0": numbly
#import "@preview/subpar:0.2.2"

#import "util.typ": *
#import "font.typ"

// Unnumbered heading for conclusion. {{{
#let heading-conclusion(
  conf: none,
) = {
  set heading(
    numbering: none,
  )
  if conf.lang == "zh" [
    = 结论
  ] else [
    = CONCLUSION
  ]
}
// }}}

// Recommended sizes for figure bodies. {{{
#let fig-sizes = (
  small: (
    width: 20cm / 3,
    height: 5cm,
  ),
  medium: (
    width: 9cm,
    height: 6.75cm,
  ),
  large: (
    width: 13.5cm,
    height: 9cm,
  ),
)
// }}}

// Subfigure wrapper. {{{
#let figures = subpar.grid.with(
  numbering: figure-numbering-with-section.with(
    numbering: "1",
  ),
  numbering-sub-ref: figure-numbering-with-section.with(
    numbering: "1 (a)",
  ),
  grid-styles: it => {
    set std.grid(
      gutter: 1em,
      align: bottom,
    )
    show figure.caption: set text(
      size: 11pt,
    )

    it
  },
)
// }}}

// Abstract, {{{
#let abstract(
  lang: "zh",
  region: auto,
  trans: none,
  body,
) = {
  set text(
    ..args-lang(lang, region),
  )

  if lang == "zh" [
    = 摘要
  ] else [
    = ABSTRACT
  ]

  body

  set par(
    first-line-indent: 0cm,
  )
  linebreak()
  text(
    font: if lang == "zh" { font.group.hei } else { font.group.song },
    if lang == "zh" [关键词：] else [*Keywords: *],
  )
  trans.at(lang).keywords.join(if lang == "zh" [；] else [; ])
}
// }}}

// Cover. {{{
#let cover(
  conf: none,
  trans: none,
) = {
  let (
    degree,
    print-date,
    distribution,
  ) = conf
  let (
    zh,
    en,
  ) = trans

  let class = {
    set align(center)
    text(
      size: font.csort.s1,
      weight: "bold",
      zh.cover.at(degree) + zh.thesis,
    )
  }

  let titles = {
    set align(center)

    set text(
      font: font.group.hei,
      size: font.csort.S2,
      weight: "bold",
    )
    set par(
      // HACK Approximation.
      leading: font.csort.S2 * 0.75,
    )

    zh.display-title

    parbreak()

    set text(
      size: font.csort.s2,
    )
    set par(
      // HACK Approximation.
      leading: font.csort.s2 * 0.75,
    )

    en.display-title
  }

  let credits = {
    set text(
      size: font.csort.s2,
    )
    set align(center)
    set grid(
      align: (x, _) => if x == 0 { right } else { left },
    )

    grid(
      columns: (1fr, 1fr),
      inset: (x: 0.3em, y: 0.65em),
      spreadl(5em)[研究生] + [：], trans.zh.candidate,
      spreadl(5em)[指导教师] + [：], trans.zh.supervisor,
      ..(
        if trans.zh.associate-supervisor.len() > 0 {
          (spreadl(5em)[副指导教师] + [：], trans.zh.associate-supervisor)
        }
      ),
    )
  }

  let place-n-date = {
    set text(
      size: font.csort.s2,
    )
    set align(center)

    trans.zh.institute
    linebreak()
    cjk-date-format(print-date)
  }

  stack(
    dir: ttb,
    spacing: 1fr,
    class,
    titles,
    credits,
    place-n-date,
  )

  if distribution == "print" {
    pagebreak(to: "odd")
  }
}
// }}}

// Chinese title page. {{{
#let title-zh(
  conf: none,
  trans: none,
) = {
  let (
    degree,
    degree-type,
    defence-date,
    clc,
    udc,
    cuc,
    confidentiality,
    distribution,
    professional,
  ) = conf
  let (zh,) = trans

  let classifications = {
    set grid(
      align: (x, _) => if x == 0 { right } else { left },
    )

    stack(
      dir: ltr,
      spacing: 1fr,
      grid(
        columns: 2,
        inset: (x: 0.3em, y: 0.65em),
        [国内图书分类号：], clc,
        [国际图书分类号：], udc,
      ),
      grid(
        columns: 2,
        inset: (x: 0.3em, y: 0.65em),
        [学校代码：], cuc,
        [密级：], confidentiality,
      ),
    )
  }

  let discipline-n-title = {
    set align(center)

    text(
      font: font.group.song,
      size: font.csort.s2,
      weight: "bold",
      if professional {
        zh.domain
      } else {
        zh.discipline
      }
        + zh.at(degree)
        + if professional { "专业" }
        + trans.zh.thesis,
    )
    parbreak()
    set text(
      font: font.group.hei,
      size: font.csort.S2,
      weight: "bold",
    )
    zh.title
    if zh.display-subtitle != none {
      parbreak()
      zh.display-subtitle
    }
  }

  let participants = {
    set align(center)
    set text(
      size: font.csort.S4,
    )
    set grid(
      align: (x, _) => if x == 0 { right } else { left },
    )

    show grid.cell.where(x: 0): set text(font: font.group.hei)

    grid(
      columns: (1fr, 1fr),
      inset: (x: 0.3em, y: 0.65em),
      ..(
        [学位申请人],
        zh.candidate,
        [指导教师],
        zh.supervisor,
        ..(
          if zh.associate-supervisor != none {
            ([副指导教师], zh.associate-supervisor)
          }
        ),
        ..(
          if professional {
            ([专业类别], zh.domain)
          } else {
            ([学科名称], zh.discipline)
          }
        ),
        [答辩日期],
        defence-date.display("[year]年[month]月"),
        [培养单位],
        zh.department,
        [学位授予单位],
        zh.institute,
      )
        .chunks(2, exact: true)
        .map(p => (spreadl(6em, p.at(0)) + [：], p.at(1)))
        .flatten(),
    )
  }

  stack(
    dir: ttb,
    spacing: 1fr,
    classifications,
    discipline-n-title,
    participants,
  )

  if distribution == "print" {
    pagebreak(to: "odd")
  }
}
// }}}

// English title page. {{{
#let title-en(
  conf: none,
  trans: none,
) = {
  let (
    degree,
    degree-type,
    defence-date,
    distribution,
    professional,
  ) = conf
  let (en,) = trans

  let title = {
    set text(
      size: font.csort.S2,
      weight: "bold",
    )
    set align(center)

    en.display-title
    if en.display-subtitle != none {
      parbreak()
      en.display-subtitle
    }
  }

  let institute-n-degree = {
    let degree-text = en.at(degree)
    degree-text = upper(degree-text.at(0)) + degree-text.slice(1)

    set align(center)
    set text(
      size: font.csort.s3,
    )

    [
      A dissertation submitted to \
      #en.institute \
      in partial fulfillment of the requirement \
      for the #(if professional [professional]) degree of \
      #degree-text of #en.domain \
      #if not professional [
        in \
        #en.discipline
      ]
    ]
  }

  let participants = {
    set align(center)
    set text(
      size: font.csort.s3,
    )

    [
      by \
      #en.candidate

      Supervisor: #en.supervisor
      #if en.associate-supervisor != none [
        \
        Associate supervisor: #en.associate-supervisor
      ]
    ]
  }

  let date = {
    set align(center)
    set text(
      size: font.csort.s3,
    )

    defence-date.display("[month repr:long] [year]")
  }

  stack(
    dir: ttb,
    spacing: 1fr,
    title,
    institute-n-degree,
    participants,
    date,
  )

  if distribution == "print" {
    pagebreak(to: "odd")
  }
}
// }}}

// List of reviewers and committee members (Chinese). {{{
#let reviewers-n-committee(
  conf: none,
  trans: none,
) = {
  let (
    reviewers,
    committee,
    distribution,
  ) = conf

  let committee = committee.map(i => if type(i) == array {
    (position: i.at(0), name: i.at(1), title: i.at(2), institute: i.at(3))
  } else { i })

  let chair = committee.filter(i => i.position == "主席").map(i => (i.name, i.title, i.institute))

  let members = committee.filter(i => i.position == "委员").map(i => (i.name, i.title, i.institute))

  let secretary = committee.filter(i => i.position == "秘书").map(i => (i.name, i.title, i.institute))

  set align(center)

  set par(
    leading: .65em,
    justify: false,
  )

  set heading(
    outlined: false,
  )

  set table(
    stroke: none,
  )

  [
    = 学位论文公开评阅人和答辩委员会名单

    == 公开评阅人名单
    #if reviewers.len() == 0 [
      无（全隐名评阅）
    ] else {
      table(
        columns: (1fr, 1fr, 3fr),
        ..reviewers
          .map(i => if type(i) == dictionary {
            (i.name, i.title, i.institute)
          } else { i })
          .flatten(),
      )
    }

    == 答辩委员会名单
    #table(
      columns: (1fr, 1fr, 2fr, 2fr),
      ..(
        if chair.len() > 0 {
          ("主席", ..chair.intersperse(none))
        },
      ).flatten(),
      ..(
        if members.len() > 0 {
          ("委员", ..members.intersperse(none))
        },
      ).flatten(),
      ..(
        if secretary.len() > 0 {
          ("秘书", ..secretary.intersperse(none))
        },
      ).flatten(),
    )
  ]

  if distribution == "print" {
    pagebreak(to: "odd")
  }
}
// }}}

// Declarations of originality and authorization. {{{
#let declarations(
  conf: none,
  trans: none,
) = {
  let (
    lang,
    publication-delay,
    distribution,
  ) = conf

  let signature(
    of: none,
  ) = grid(
    columns: (2fr, 1fr),
    rows: 2cm,
    align: left + horizon,
    ..(
      if lang == "zh" {
        (
          spreadl(3em)[#of;签名] + [：],
          spreadl(3em)[日期] + [：],
        )
      } else {
        (
          [Signature#firstof(of, ts: i => [ of #i]): ],
          [Date: ],
        )
      }
    )
  )

  let author = if lang == "zh" [作者] else [Author]
  let supervisor = if lang == "zh" [指导教师] else [Supervisor]

  let delay-boxes = {
    //HACK 9pt only for s4 font size
    let eb = box(stroke: black, width: 9pt, height: 9pt)
    let cb = box(stroke: black, width: 9pt, height: 9pt, fill: black)
    let bnow = eb
    let blater = bnow
    let delay-text = box(stroke: (bottom: black), width: 1.5em)
    if type(publication-delay) == int {
      if publication-delay == 0 { bnow = cb } else {
        blater = cb
        delay-text = box(stroke: (bottom: black), width: 1.5em, height: 9pt, align(
          center + top,
          str(publication-delay),
        ))
      }
    }
    let now = if lang == "zh" [当年] else [upon submission]
    let later = if lang == "zh" [年以后] else [ months after submission]

    [#bnow #now/ #blater #delay-text;#later]
  }

  show heading: set align(center)
  set heading(
    outlined: false,
  )

  set enum(
    full: true,
    numbering: numbly(
      "{1}.",
      if lang == "zh" { (..ns) => [（#ns.at(1)）#h(-0.5em)] } else { "({2})" },
    ),
  )

  [
    = #trans.at(lang).declarations.title

    == #trans.at(lang).declarations.title-originality
    #if lang == "zh" [
      本人郑重声明：所提交的学位论文是本人在导师指导下独立进行研究工作所取得的成果。除了特别加以标注和致谢的内容外，论文中不包含他人已发表或撰写过的研究成果。对本人的研究做出重要贡献的个人和集体，均已在文中作了明确的说明。本声明的法律结果由本人承担。
    ] else [
      I hereby declare that this thesis is my own original work under the guidance of my supervisor.
      It does not contain any research results that others have published or written.
      All sources I quoted in the thesis are indicated in references or have been indicated or acknowledged.
      I shall bear the legal liabilities of the above statement.
    ]

    #signature(of: author)

    == #trans.at(lang).declarations.title-authorization
    #if lang == "zh" [
      本人完全了解南方科技大学有关收集、保留、使用学位论文的规定，即：
      + 按学校规定提交学位论文的电子版本。
      + 学校有权保留并向国家有关部门或机构送交学位论文的电子版，允许论文被查阅。
      + 在以教学与科研服务为目的前提下，学校可以将学位论文的全部或部分内容存储在有关数据库提供检索，并可采用数字化、云存储或其他存储手段保存本学位论文。
        + 在本论文提交当年，同意在校园网内提供查询及前十六页浏览服务。
        + 在本论文提交 #delay-boxes;，同意向全社会公开论文全文的在线浏览和下载。
      + 保密的学位论文在解密后适用本授权书。
    ] else [
      I fully understand the regulations regarding the collection, retention, and use of the thesis of the Southern University of Science and Technology.

      + Submit the electronic version of the thesis as required by the University.
      + The University has the right to retain and send the electronic version to other institutions that allow the thesis to be read by the public.
      + The University may save all or part of the thesis in certain databases for retrieval and may save it with digital, cloud storage, or other methods for teaching and scientific re-search.
        I agree that the full text of the thesis can be viewed online or downloaded within the campus network.
        + I agree that once submitted, the thesis can be retrieved online and the first 16 pages can be viewed within the campus network.
        + I agree that #delay-boxes, the full text of the thesis can be viewed and downloaded by the public.
      + This authorization applies to the decrypted confidential thesis.
    ]

    #signature(of: author)
    #signature(of: supervisor)
  ]

  if distribution == "print" {
    pagebreak(to: "odd")
  }
}
// }}}

// Outline. {{{
#let toc() = {
  show outline.entry: it => {
    let fs = it.fields()
    let el = fs.element
    let rule(body) = {
      set text(
        font: font.group.hei-latin-song,
      ) if fs.level == 1
      show regex(`[0-9\p{Latin}]`.text): set text(
        weight: "bold",
      )
      body
    }

    link(
      el.location(),
      grid(
        columns: (auto, auto, 1fr, auto),
        {
          h((fs.level - 1) * outline.indent)
          let prefix = it.prefix()
          if prefix != none {
            show: rule
            prefix
            h(0.5em)
          }
        },
        {
          show: rule
          show regex(`^\p{Han}{2}$`.text): spreadl.with(3em)
          el.fields().body
        },
        fs.fill,
        it.page(),
      ),
    )
  }

  outline()
}
// }}}

