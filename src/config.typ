#import "util.typ": *

#let configure(
  loc: (:),
  lang: "zh",
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
) = (
  loc: merge-dicts(loc-default, loc),
  lang: lang,
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
    ts: infer-display-title.with(title),
  ),
  candidate: to-dict(candidate),
  supervisor: to-dict(supervisor),
  associate-supervisor: to-dict(associate-supervisor),
  department: to-dict(department),
  degree: degree,
  degree-type: degree-type,
  discipline: to-dict(discipline),
  domain: to-dict(domain),
  institute: firstconcrete(
    institute,
    langs.map(l => (l, loc.at(l).sustech)).to-dict(),
    ts: to-dict,
  ),
  print-date: print-date,
  defence-date: defence-date,
  clc: clc,
  udc: udc,
  cuc: firstconcrete(
    cuc,
    "14325",
  ),
  confidentiality: confidentiality,
)

