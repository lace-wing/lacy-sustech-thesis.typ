#import "../../export.typ": *

#let lom = [
  采用小四号（12 磅）字，汉字用宋体，英文和数字用 Times New Roman 体，
  两端对齐书写，段落首行左缩进 2 个汉字符。行距为固定值 20 磅（段落中有数学
  表达式时，可根据表达需要设置该段的行距），段前空 0 磅，段后空 0 磅，字符
  间距设置为标准。

  同一章内除最后一个段落之外因排版出现的留白建议不超过 3 行。填充空白
  时注意各层次题序和标题不得置于页面的最后一行（即不出现孤行）。

  中文撰写的论文中，数学环境、化学式、参考文献著录均使用半角括号，其
  他情况下括号的类型应保持全文统一。

  通常，物理量符号、变量符号用斜体，计量单位和化学元素符号用正体。实
  际字体需要根据专业领域标准设置，但应全文统一。单位符号应写在全部数值之
  后，并与数值间留适当的空隙。单位符号与其前面的数值之间应留适当空隙，如
  20 ℃、1.84 g/ml，不应写成 20℃、1.84g/ml。
]

#show: style.generic

#cp.setup(
  title: (
    zh: "狂人日记",
    en: "Diary of a Madman",
  ),
  subtitle: (
    zh: "救救孩子",
    en: "Save the Children",
  ),
  candidate: (
    zh: "鲁迅迅迅",
    en: "Lu Xun",
  ),
  supervisor: (
    zh: "周树人",
    en: "Zhou Shuren",
  ),
  department: (
    zh: "文学系",
    en: "Department of Literature",
  ),
  degree: "master",
  // degree-type: "professional",
  degree-type: "academic",
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
  clc: "12345",
  udc: "12345",
)

#show: style.cover
#cp.cover()

#show: style.title-page
#cp.title-page-zh()

#show: style.abstract

= 摘要
#lom

= Abstract
#lom

#show: style.main

= 介绍

#lom

== 小介绍

=== 小小介绍

==== 小小小介绍

