/// Document components

#import "@preview/conjak:0.2.3": *

#import "util.typ": *
#import "font.typ"

#let conf-state = state(ns(pkg-name, "config"), (:))

#let default-loc = load-dir("./loc", "zh.toml", "en.toml")

#let setup(
  loc: (:),
  langs: ("zh", "en"),
  title: none,
  subtitle: none,
  candidate: none,
  supervisor: none,
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
  conf-state.update(c => {
    let loc = merge-dicts(default-loc, loc)
    let langs = to-arr(langs)

    let title = to-dict(title)
    let subtitle = to-dict(subtitle)
    let candidate = to-dict(candidate)
    let supervisor = to-dict(supervisor)
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
      subtitle: subtitle,
      candidate: candidate,
      supervisor: supervisor,
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
  let plang = firstof(
    discard: l => not conf.langs.contains(l),
    "zh",
    "en",
    default: conf.langs.at(0),
  )
  let pid = firstof(
    conf.langs.position(l => l == plang),
    0,
  )

  // Cover elements. {{{
  let class = {
    text(
      size: font.csort.s1,
      weight: "bold",
      loc.zh.cover.at(conf.degree) + loc.zh.thesis,
    )
  }

  let titles = conf
    .langs
    .map(lang => {
      if lang == "zh" {
        text(
          font: font.group.hei,
          size: font.csort.S2,
          weight: "bold",
          conf.title.at(lang),
        )
      } else {
        text(
          size: font.csort.s2,
          weight: "bold",
          upper(conf.title.at(lang)),
        )
      }
    })
    .intersperse(parbreak())
    .join()

  let credits = {
    set text(
      size: font.csort.s2,
    )
    set grid(
      align: (x, _) => if x == 0 { right } else { left },
    )
    let spread-func = if conf.candidate.zh.clusters().len() < 5 and conf.supervisor.zh.clusters().len() < 5 {
      spreadl.with(4em)
    } else {
      a => a
    }

    grid(
      columns: (1fr, 1fr),
      column-gutter: 1em,
      inset: (x: 0.3em, y: 0.65em),
      spreadl(5em)[研究生] + [：], spread-func(conf.candidate.zh),
      spreadl(5em)[指导教师] + [：], spread-func(conf.supervisor.zh),
    )
  }

  let place-n-date = {
    set text(
      size: font.csort.s2,
    )
    conf.institute.zh
    linebreak()
    cjk-date-format(conf.print-date)
  }
  // }}}

  set align(center)
  stack(
    dir: ttb,
    spacing: 1fr,
    class,
    titles,
    credits,
    place-n-date,
  )
}

#let title-page-zh() = context {
  let conf = conf-state.get()
  let loc = conf.loc
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
        + loc.zh.at(conf.degree)
        + if conf.degree-type == "professional" { "专业" }
        + loc.zh.thesis,
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
          if is-prof {
            ([专业类别], conf.domain.zh)
          } else {
            ([学科名称], conf.discipline.zh)
          }
        ),
        [答辩日期],
        conf.defence-date.display("[year]年[month]月[day]日"),
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
}

