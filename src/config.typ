#import "util.typ": *
#import "component.typ": *
#import "style.typ": *

// Binding config to elements. {{{
#let bind-config(
  conf: none,
  trans: none,
) = {
  (
    // Util arguments. {{{
    fig-sizes: fig-sizes,
    // }}}
    // Element functions. {{{
    figures: figures,
    title-page: title-page.with(
      conf: conf,
      trans: trans,
    ),
    abstract: abstract.with(
      conf: conf,
      trans: trans,
    ),
    // }}}
    // Styles. {{{
    generic-style: generic.with(
      conf: conf,
      trans: trans,
    ),
    front-matter-paginated-style: front-matter-paginated.with(
      conf: conf,
    ),
    body-matter-style: body-matter.with(
      conf: conf,
    ),
    appendix-style: appendix,
    attachment-style: post-appendix,
    // }}}
    // Components. {{{
    cover: cover(
      conf: conf,
      trans: trans,
    ),
    reviewers-n-committee: reviewers-n-committee(
      conf: conf,
      trans: trans,
    ),
    declarations: declarations(
      conf: conf,
      trans: trans,
    ),
    outline: toc(
      conf: conf,
    ),
    conclusion: heading-conclusion(
      conf: conf,
    ),
    // }}}
  )
}
// }}}

// Processing config from user. {{{
#let setup(
  trans: (:),
  lang: "zh",
  region: auto,
  distribution: "digital",
  title: none,
  display-title: auto,
  subtitle: none,
  display-subtitle: auto,
  keywords: none,
  candidate: none,
  supervisor: none,
  associate-supervisor: none,
  department: none,
  degree: "bachelor",
  degree-type: "academic",
  discipline: none, // Academic
  domain: none, // Professional
  print-date: none,
  defence-date: none,
  clc: none, // Chinese Library Classificantion
  udc: none, // Universal Decimal Classificantion
  cuc: "14325", // Chinese University Code
  thesis-number: none, // Only seen on bachelor's cover
  student-number: none, // Only on bachelor's cover
  confidentiality: "公开",
  publication-delay: none,
  reviewers: none,
  committee: none,
  bibliography-style: "numeric",
  // Extra...
  description: none,
) = {
  let (lang, region) = args-lang(lang, region).named()
  let professional = degree-type == "professional"
  let bachelor = degree == "bachelor"
  let master = degree == "master"
  let doctor = degree == "doctor"
  let print = distribution == "print"

  bind-config(
    conf: (
      lang: lang,
      region: region,
      distribution: distribution,
      degree: degree,
      degree-type: degree-type,
      print-date: print-date,
      defence-date: defence-date,
      clc: clc,
      udc: udc,
      cuc: cuc,
      thesis-number: thesis-number,
      student-number: student-number,
      confidentiality: confidentiality,
      publication-delay: publication-delay,
      reviewers: firstof(reviewers, default: ()),
      committee: firstof(committee, default: ()),
      bibliography-style: bibliography-style,
      description: description,
      // Util
      professional: professional,
      bachelor: bachelor,
      master: master,
      doctor: doctor,
      print: print,
    ),
    trans: {
      let base = merge-dicts(trans-default, trans)
      let expl = (
        title: to-dict(title),
        display-title: firstconcrete(
          display-title,
          (:),
          ts: infer-display-title.with(
            title,
            bachelor: bachelor,
          ),
        ),
        subtitle: to-dict(subtitle),
        display-subtitle: firstconcrete(
          display-subtitle,
          (:),
          ts: infer-display-title.with(
            subtitle,
            bachelor: bachelor,
          ),
        ),
        keywords: to-dict(keywords),
        candidate: to-dict(candidate),
        supervisor: to-dict(supervisor),
        associate-supervisor: to-dict(associate-supervisor),
        department: to-dict(department),
        discipline: to-dict(discipline),
        domain: to-dict(domain),
      )
      for l in base.keys() {
        base.at(l) += take-lang(expl, l)
      }
      base
    },
  )
}
// }}}

