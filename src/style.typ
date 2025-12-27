/// Styles, re-appliable.

#import "@preview/hydra:0.6.2": hydra
#import "@preview/numbly:0.1.0": numbly
#import "@preview/equate:0.3.2": equate
#import "@preview/i-figured:0.2.4": show-figure

#import "util.typ": *
#import "font.typ"

/*
（10） 正文：第 1 章（引言或绪论）、第 2 章、……、结论
（11） 参考文献
（12） 附录（如有）
（13） 致谢
（14） 个人简历、在学期间完成的相关学术成果
*/

/// Default leading.
// #let leading = 11pt // 20 - 9 = 11
#let leading = 20pt - font.csort.s4

#let header-heading = text(
  size: font.csort.S5,
  context {
    set align(center)
    box(
      width: 100%,
      inset: 0.65em,
      stroke: (bottom: gray),
      hydra(
        1,
        skip-starting: false,
        display: (ctx, cand) => {
          if cand.numbering != none {
            numbering(cand.numbering, ..counter(heading).at(cand.location()))
            h(0.5em)
          }
          spreadl(3em, cand.body)
        },
      ),
    )
  },
)

#let generic(
  body,
  lang: "zh",
  region: auto,
) = {
  set page(
    paper: "a4",
    margin: 3cm,
    header-ascent: 0.8cm, // 3 - 2.2 = 0.8
    footer-descent: 0.8cm,
    header: header-heading,
  )

  set text(
    font: font.group.song,
    size: font.csort.s4,
    ..args-lang(lang, region),
  )

  set par(
    first-line-indent: (amount: 2em, all: true),
    leading: leading,
  )

  set bibliography(style: "gb-7714-2015-numeric")

  show heading: it => {
    set text(
      font: if it.level < 4 {
        font.group.hei
      } else {
        font.group.song
      },
      size: if it.level == 1 {
        font.csort.S3
      } else if it.level == 2 {
        font.csort.S4
      } else if it.level == 3 {
        13pt
      } else {
        font.csort.s4
      },
      weight: if it.level < 4 { "bold" } else { "regular" },
    )

    set block(
      above: if it.level >= 2 { 24pt } else { 12pt },
      below: if it.level >= 1 { 18pt } else { 6pt },
    )

    it
  }

  show heading.where(level: 1): it => {
    counter(math.equation).update(0)

    set align(center)
    show regex(`^\p{Han}{2}$`.text): spreadl.with(3em)

    pagebreak(weak: true)
    it
  }

  show title: it => {
    set text(
      font: font.group.hei,
      size: font.csort.S2,
    )

    set par(
      leading: leading * 1.25,
    )

    it
  }

  show math.equation: set text(
    font: font.group.song-math,
  )

  show math.equation.where(block: false): set math.frac(style: "horizontal")

  show: equate

  set math.equation(
    numbering: (..ns, loc: auto) => context [
      (#(counter(heading).at(firstconcrete(loc, here())).at(0), ..ns.pos()).map(str).join("-"))
    ],
  )

  // HACK Fixing equations' contextual numbering not following original heading count.
  // NOTE From equate 0.3.2, edited.
  show ref: it => {
    if it.element == none { return it }
    if it.element.func() != figure { return it }
    if it.element.kind != math.equation { return it }
    if it.element.body == none { return it }
    if it.element.body.func() != metadata { return it }

    let sub-numbering-state = state("equate/sub-numbering", false)

    let nums = if sub-numbering-state.at(it.element.location()) {
      it.element.body.value
    } else {
      (it.element.body.value.first() + it.element.body.value.slice(1).sum(default: 1) - 1,)
    }

    let num = numbering(
      if type(it.element.numbering) == function {
        it.element.numbering.with(loc: it.element.location())
      } else { it.element.numbering },
      ..nums,
    )

    let supplement = if it.supplement == auto {
      it.element.supplement
    } else if type(it.supplement) == function {
      (it.supplement)(it.element)
    } else {
      it.supplement
    }

    link(it.element.location(), if supplement not in ([], none) [#supplement~#num] else [#num])
  }

  body
}
// }}}

/// Cover page. {{{
#let cover(body) = {
  set text(
    font: font.group.song,
  )

  set page(
    numbering: none,
  )

  body
}
// }}}

/// Title pages. {{{
#let title-page(body) = {
  set page(
    numbering: none,
    header: none,
  )

  body
}
// }}}

/// Reviewers and committee. {{{
#let reviewers-n-committee(body) = {
  set page(
    numbering: none,
    header: none,
  )

  set heading(
    numbering: none,
  )

  body
}
// }}}

/// Declarations. {{{
#let declarations(
  body,
  lang: "zh",
  region: auto,
) = {
  set page(
    numbering: none,
    header: none,
  )

  set heading(
    numbering: none,
  )

  body
}
// }}}

/// Abstracts. {{{
#let abstract(
  body,
  lang: "zh",
  region: auto,
) = {
  set page(
    numbering: "I",
    header: header-heading,
  )

  set par(
    justify: true,
  )

  set heading(
    numbering: none,
  )

  body
}
// }}}

// Table of Content. {{{
#let toc(body) = {
  set page(
    numbering: "I",
    header: header-heading,
  )

  set outline(
    indent: 1em,
    depth: 3,
    title: context if text.lang == "zh" [目录] else [TABLE OF CONTENTS],
  )

  body
}
// }}}

/// Main body. {{{
#let main(body) = {
  set page(
    numbering: "1",
    header: header-heading,
  )

  set par(
    justify: true,
  )

  set heading(
    numbering: numbly(
      n => context if text.lang == "zh" [第#n;章] else [CHAPTER #n],
      "{1}.{2}",
      "{1}.{2}.{3}",
      (..ns) => context if text.lang == "zh" [
        #h(-0.6em, weak: true)（#ns.at(3)）#h(-0.6em)
      ] else [
        (#ns.at(3))
      ],
      "{5:①}",
      "{6:a.}",
    ),
  )

  body
}
// }}}

