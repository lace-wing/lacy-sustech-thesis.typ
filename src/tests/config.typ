#import "../../export.typ": *

#let (
  // Element functions.
  figures,
  abstract,
  // Components.
  cover,
  title-zh,
  title-en,
  reviewers-n-committee,
  declarations,
  outline,
  conclusion,
  // Styles.
  generic-style,
  pagination-style,
  body-matter-style,
  appendix-style,
  attachment-style,
) = setup(
  distribution: "print",
  title: (
    zh: [狂人日记狂人日记狂人日记狂人日记狂人日记狂人日记狂人日记],
    en: [Diary of a Normal Madman],
  ),
  display-title: (
    en: ((upper[Diary of a ] + [Normal] + upper[ Madman],) * 4).join[ ],
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
  degree: "master",
  // 专业学位
  degree-type: "professional",
  // 学术学位
  // degree-type: "academic",
  discipline: (
    zh: "创意写作",
    en: "Creative Writing",
  ),
  domain: (
    zh: "文学",
    en: "Literature",
  ),
  print-date: datetime(year: 2025, month: 12, day: 12),
  defence-date: datetime(year: 2026, month: 01, day: 06),
  reviewers: (
    // 可以写字典
    (name: "刘某某", title: "教授", institute: "南方科技大学"),
    // 也可以按顺序写条目
    ("陈某某", "副教授", "某大学"),
  ),
  committee: (
    (position: "主席", name: "赵某某", title: "教授", institute: "南方科技大学"),
    ("秘书", "吴某某", "助理研究员", "南方科技大学"),
    (position: "委员", name: "刘某某", title: "教授", institute: "南方科技大学"),
    ("委员", "杨某某", "研究员", "中国某某某科学院某某研究所"),
  ),
  clc: "12345",
  udc: "12345",
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

