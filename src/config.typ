#import "util.typ": *
#import "component.typ": *
#import "style.typ": *

// Binding config to elements. {{{
#let bind-config(
  config,
) = {
  (
    // Element functions. {{{
    figures: figures,
    abstract: abstract.with(
      trans: config.trans,
    ),
    // }}}
    // Styles. {{{
    generic-style: generic.with(
      lang: config.lang,
      region: config.region,
      bibliography-style: config.bibliography-style,
      print-date: config.print-date,
      description: config.description,
      trans: config.trans,
    ),
    pagination-style: pagination-start,
    body-matter-style: body-matter.with(
      distribution: config.distribution,
    ),
    appendix-style: appendix,
    attachment-style: post-appendix,
    // }}}
    // Components. {{{
    cover: cover(
      degree: config.degree,
      print-date: config.print-date,
      distribution: config.distribution,
      trans: config.trans,
    ),
    title-zh: title-zh(
      degree: config.degree,
      degree-type: config.degree-type,
      defence-date: config.defence-date,
      clc: config.clc,
      udc: config.udc,
      cuc: config.cuc,
      confidentiality: config.confidentiality,
      distribution: config.distribution,
      trans: config.trans,
    ),
    title-en: title-en(
      degree: config.degree,
      degree-type: config.degree-type,
      defence-date: config.defence-date,
      distribution: config.distribution,
      trans: config.trans,
    ),
    reviewers-n-committee: reviewers-n-committee(
      reviewers: config.reviewers,
      committee: config.committee,
      distribution: config.distribution,
    ),
    declarations: declarations(
      lang: config.lang,
      delay: config.publication-delay,
      trans: config.trans,
      distribution: config.distribution,
    ),
    outline: toc(),
    conclusion: heading-conclusion(
      lang: config.lang,
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
  confidentiality: "公开",
  publication-delay: none,
  reviewers: none,
  committee: none,
  bibliography-style: "numeric",
  // Extra...
  description: none,
) = {
  let (lang, region) = args-lang(lang, region).named()
  bind-config((
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
    confidentiality: confidentiality,
    publication-delay: publication-delay,
    reviewers: firstof(reviewers, default: ()),
    committee: firstof(committee, default: ()),
    bibliography-style: bibliography-style,
    description: description,
    trans: {
      let base = merge-dicts(trans-default, trans)
      let expl = (
        title: to-dict(title),
        display-title: firstconcrete(
          display-title,
          (:),
          ts: infer-display-title.with(title),
        ),
        subtitle: to-dict(subtitle),
        display-subtitle: firstconcrete(
          display-subtitle,
          (:),
          ts: infer-display-title.with(subtitle),
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
  ))
}
// }}}

