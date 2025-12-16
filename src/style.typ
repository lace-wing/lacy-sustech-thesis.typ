/// Styles, re-appliable.

#import "@preview/hydra:0.6.2": hydra
#import "@preview/numbly:0.1.0": numbly

#import "util.typ": *
#import "font.typ"

/*
（1） 封面
（2） 中文题名页（内封）
（3） 英文题名页（内封）
（4） 学位论文公开评阅人和答辩委员会名单
（5） 南方科技大学学位论文原创性声明和使用授权说明
（6） 摘要
（7） Abstract
（8） 目录
（9） 符号和缩略语说明（如有）
（10） 正文：第 1 章（引言或绪论）、第 2 章、……、结论
（11） 参考文献
（12） 附录（如有）
（13） 致谢
（14） 个人简历、在学期间完成的相关学术成果
*/

/// Default leading.
#let leading = 20pt

/// Generic styles. {{{
///
/// - body (content): Body.
/// -> content
#let generic(body) = {
  set page(
    paper: "a4",
    margin: 3cm,
    header-ascent: 0.8cm, // 3 - 2.2 = 0.8
    footer-descent: 0.8cm,
    header: text(
      size: font.csort.S5,
      context {
        set align(center)
        //HACK
        show regex(`\p{Han}{2}`.text): spreadl.with(3em)
        hydra(1, skip-starting: false)
      },
    ),
  )

  set text(
    font: font.group.song,
    size: font.csort.s4,
  )

  set par(
    first-line-indent: (amount: 2em, all: true),
    leading: leading,
    justify: true,
  )

  set bibliography(style: "gb-7714-2015-numeric")

  show heading: it => {
    set text(
      font: font.group.hei,
      // Starting from S3, minnimum s5
      size: font.csort-sizes.at(calc.min(it.level * 2 + 4, 11)),
    )

    set block(
      above: if it.level >= 2 { 24pt } else { 12pt },
      below: if it.level >= 1 { 18pt } else { 6pt },
    )

    it
  }

  show heading.where(level: 1): it => {
    set align(center)
    //HACK
    show regex(`\p{Han}{2}`.text): spreadl.with(3em)

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
  body
}
// }}}

/// Abstracts. {{{
#let abstract(body, lang: "zh", region: auto) = {
  set text(
    lang: lang,
    region: firstconcrete(
      region,
      default: {
        if lang == "zh" { "cn" } else { "us" }
      },
    ),
  )

  set page(
    numbering: "I",
  )

  set heading(
    numbering: none,
  )

  body
}
// }}}

/// Main body. {{{
#let main(body) = {
  set page(
    numbering: "1",
  )

  set heading(
    numbering: numbly(
      n => [第#n;章#h(1em, weak: true)],
      "1.1",
    ),
  )

  body
}
// }}}

