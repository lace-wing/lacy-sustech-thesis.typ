#import "../../export.typ": *

#let (
  // Element functions.
  figures,
  abstract,
  // Components.
  cover,
  title-page,
  reviewers-n-committee,
  declarations,
  outline,
  conclusion,
  // Styles.
  generic-style,
  front-matter-paginated-style,
  body-matter-style,
  appendix-style,
  attachment-style,
) = setup(
  // distribution: "print",
  lang: "en",
  title: (
    zh: [狂人日记狂人日记狂人日记狂人日记狂人日记狂人日记狂人日记],
    en: [Diary of a Normal Madman],
  ),
  display-title: (
    // en: ((upper[Diary of a ] + [Normal] + upper[ Madman],) * 4).join[ ],
  ),
  subtitle: (
    zh: "救救孩子",
    en: "Save the Children",
  ),
  display-subtitle: (
    zh: "对，对吗？",
  ),
  keywords: (
    zh: ("仁义道德", "吃人", "白话文"),
    en: ("Benevolence and Morality", "Cannibalism", "Baihua"),
  ),
  candidate: (
    zh: "鲁迅",
    en: "Lu Xun",
  ),
  supervisor: (
    zh: "周树人教授",
    en: "Professor Zhou Shuren",
  ),
  associate-supervisor: (
    zh: "周树人副教授",
    en: "Professor Zhou Shuren",
  ),
  department: (
    zh: "文学系",
    en: "Department of Literature",
  ),
  degree: "bachelor",
  discipline: (
    zh: "创意写作",
    en: "Creative Writing",
  ),
  domain: (
    zh: "文学",
    en: "Literature",
  ),
  print-date: datetime(year: 2025, month: 12, day: 12),
  clc: "12345",
  udc: "12345",
  thesis-number: "8217365",
  student-number: "028547",
)


#let florem = figure(
  caption: lorem(2),
  box(
    stroke: black,
    width: 2cm,
    height: 1.5cm,
  ),
)

#let sflorem = figures.with(
  caption: lorem(2),
  columns: 2,
  florem,
  florem,
)

