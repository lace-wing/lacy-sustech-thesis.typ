/// Document components

#import "@preview/conjak:0.2.3": *
#import "@preview/numbly:0.1.0": numbly

#import "util.typ": *
#import "font.typ"

#let default-loc = load-dir("./loc", "zh.typ", "en.typ")

#let infer-display-title(
  title,
  display-title,
) = {
  let ts(l, t) = if l == "en" {
    (l, upper(t))
  } else {
    (l, t)
  }

  title
    .pairs()
    .map(((l, t)) => {
      if l in display-title {
        if display-title.at(l) == auto {
          return ts(l, t)
        }
        return (l, display-title.at(l))
      }
      return ts(l, t)
    })
    .to-dict()
}

#let setup(
  loc: (:),
  langs: ("zh", "en"),
  title: none,
  display-title: auto,
  subtitle: none,
  display-subtitle: auto,
  candidate: none,
  supervisor: none,
  associate-supervisor: none,
  department: none,
  degree: "bachelor",
  degree-type: "academic",
  discipline: none, // Academic
  domain: none, // Professional
  institute: auto,
  print-date: none,
  defence-date: none,
  clc: none, // Chinese Library Classificantion
  udc: none, // Universal Decimal Classificantion
  cuc: auto, // Chinese University Code
  confidentiality: "公开",
) = {
  //HACK later is replaced with argument-passing to each function, via wrappers
  conf-state.update(c => {
    let loc = merge-dicts(default-loc, loc)
    let langs = to-arr(langs)

    let title = to-dict(title)
    let display-title = firstconcrete(
      display-title,
      (:),
      ts: infer-display-title.with(title),
    )
    let subtitle = to-dict(subtitle)
    let display-subtitle = firstconcrete(
      display-subtitle,
      (:),
      ts: infer-display-title.with(title),
    )
    let candidate = to-dict(candidate)
    let supervisor = to-dict(supervisor)
    let associate-supervisor = to-dict(associate-supervisor)
    let department = to-dict(department)
    let discipline = to-dict(discipline)
    let domain = to-dict(domain)
    let institute = firstconcrete(
      institute,
      langs.map(l => (l, loc.at(l).sustech)).to-dict(),
      ts: to-dict,
    )
    let cuc = firstconcrete(
      cuc,
      "14325",
    )
    c += (
      loc: loc,
      langs: langs,
      title: title,
      display-title: display-title,
      subtitle: subtitle,
      display-subtitle: display-subtitle,
      candidate: candidate,
      supervisor: supervisor,
      associate-supervisor: associate-supervisor,
      department: department,
      degree: degree,
      degree-type: degree-type,
      discipline: discipline,
      domain: domain,
      institute: institute,
      print-date: print-date,
      defence-date: defence-date,
      clc: clc,
      udc: udc,
      cuc: cuc,
      confidentiality: confidentiality,
    )
    c
  })
}

#let cover() = context {
  let conf = conf-state.get()
  let loc = conf.loc

  let class = {
    set align(center)
    text(
      size: font.csort.s1,
      weight: "bold",
      loc.zh.cover.at(conf.degree) + loc.zh.thesis,
    )
  }

  let titles = {
    set align(center)

    ("zh", ..conf.langs)
      .dedup()
      .map(lang => {
        if lang == "zh" {
          set text(
            font: font.group.hei,
            size: font.csort.S2,
            weight: "bold",
          )
          set par(
            leading: 20pt * 1.25 - text.size,
          )

          conf.title.at(lang)
        } else {
          set text(
            size: font.csort.s2,
            weight: "bold",
          )
          set par(
            leading: 20pt * 1.25 - text.size,
          )

          conf.display-title.at(lang)
        }
      })
      .intersperse(parbreak())
      .join()
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
      spreadl(5em)[研究生] + [：], conf.candidate.zh,
      spreadl(5em)[指导教师] + [：], conf.supervisor.zh,
      ..(
        if conf.associate-supervisor.len() > 0 {
          (spreadl(5em)[副指导教师] + [：], conf.associate-supervisor.zh)
        }
      ),
    )
  }

  let place-n-date = {
    set text(
      size: font.csort.s2,
    )
    set align(center)

    conf.institute.zh
    linebreak()
    cjk-date-format(conf.print-date)
  }

  stack(
    dir: ttb,
    spacing: 1fr,
    class,
    titles,
    credits,
    place-n-date,
  )
  pagebreak()
}

#let title-page-zh() = context {
  let conf = conf-state.get()
  let is-prof = conf.degree-type == "professional"

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
        [国内图书分类号：], conf.clc,
        [国际图书分类号：], conf.udc,
      ),
      grid(
        columns: 2,
        inset: (x: 0.3em, y: 0.65em),
        [学校代码：], conf.cuc,
        [密级：], conf.confidentiality,
      ),
    )
  }

  let discipline-n-title = {
    set align(center)

    text(
      font: font.group.song,
      size: font.csort.s2,
      weight: "bold",
      if is-prof {
        conf.domain.zh
      } else {
        conf.discipline.zh
      }
        + conf.loc.zh.at(conf.degree)
        + if conf.degree-type == "professional" { "专业" }
        + conf.loc.zh.thesis,
    )
    parbreak()
    text(
      font: font.group.hei,
      size: font.csort.S2,
      weight: "bold",
      conf.title.zh,
    )
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
        conf.candidate.zh,
        [指导教师],
        conf.supervisor.zh,
        ..(
          if conf.associate-supervisor != (:) {
            ([副指导教师], conf.associate-supervisor.zh)
          }
        ),
        ..(
          if is-prof {
            ([专业类别], conf.domain.zh)
          } else {
            ([学科名称], conf.discipline.zh)
          }
        ),
        [答辩日期],
        conf.defence-date.display("[year]年[month]月"),
        [培养单位],
        conf.department.zh,
        [学位授予单位],
        conf.institute.zh,
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
  pagebreak()
}

#let title-page-en() = context {
  let conf = conf-state.get()
  let is-prof = conf.degree-type == "professional"

  let title = {
    set text(
      size: font.csort.S2,
      weight: "bold",
    )
    set align(center)

    conf.display-title.en
  }

  let institute-n-degree = {
    let degree-text = conf.loc.en.at(conf.degree)
    degree-text = upper(degree-text.at(0)) + degree-text.slice(1)

    set align(center)
    set text(
      size: font.csort.s3,
    )

    [
      A dissertation submitted to \
      #conf.institute.en \
      in partial fulfillment of the requirement \
      for the #(if is-prof [professional]) degree of \
      #degree-text of #conf.domain.en \
      #if not is-prof [
        in \
        #conf.discipline.en
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
      #conf.candidate.en
      #v(par.spacing)
      Supervisor: #conf.supervisor.en
      #if conf.associate-supervisor != (:) [
        \
        Associate supervisor: #conf.associate-supervisor.en
      ]
    ]
  }

  let date = {
    set align(center)
    set text(
      size: font.csort.s3,
    )

    conf.print-date.display("[month repr:long] [year]")
  }

  stack(
    dir: ttb,
    spacing: 1fr,
    title,
    institute-n-degree,
    participants,
    date,
  )
}

#let reviewers-n-commitee(
  reviewers: (),
  committee: (),
) = {
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
  pagebreak()
}

#let declarations(
  lang: "zh",
  delay: 0,
) = context {
  let conf = conf-state.get()

  let signature(
    of: none,
  ) = grid(
    columns: (2fr, 1fr),
    rows: par.leading * 3,
    align: left + horizon,
    ..(
      if lang == "zh" {
        (
          [#of;签名：],
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
    if type(delay) == int {
      if delay == 0 { bnow = cb } else {
        blater = cb
        delay-text = box(stroke: (bottom: black), width: 1.5em, height: 9pt, align(center + top, str(delay)))
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
    numbering: numbly("{1}.", "({2})"),
  )

  [
    = #conf.loc.at(lang).declarations.title

    == #conf.loc.at(lang).declarations.title-originality
    #if lang == "zh" [
      本人郑重声明：所提交的学位论文是本人在导师指导下独立进行研究工作所取得的成果。除了特别加以标注和致谢的内容外，论文中不包含他人已发表或撰写过的研究成果。对本人的研究做出重要贡献的个人和集体，均已在文中作了明确的说明。本声明的法律结果由本人承担。
    ] else [
      I hereby declare that this thesis is my own original work under the guidance of my supervisor.
      It does not contain any research results that others have published or written.
      All sources I quoted in the thesis are indicated in references or have been indicated or acknowledged.
      I shall bear the legal liabilities of the above statement.
    ]

    #signature()

    == #conf.loc.at(lang).declarations.title-authorization
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
  pagebreak()
}

