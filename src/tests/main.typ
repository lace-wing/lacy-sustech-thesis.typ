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

#let config = (
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
  clc: "12345",
  udc: "12345",
)

#show: style.generic

#cp.setup(
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
  clc: "12345",
  udc: "12345",
)

#show: style.cover
#cp.cover()

#show: style.title-page
#cp.title-page-zh()
#cp.title-page-en()

#show: style.reviewers-n-committee
#cp.reviewers-n-commitee(
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
)

#show: style.generic
#show: style.declarations
#cp.declarations()

#show: style.abstract

#counter(page).update(1)

= 摘要
#lom

= ABSTRACT
#lom

#show: style.toc
#cp.toc()

#show: style.glossary

= 符号和缩略语说明

/ DFT: 密度泛函理论（Density Function Theory）

/ HPLC: 高效液相色谱（High Performance Liquid Chromatography）

/ LC-MS: 液相色谱--质谱联用（Liquid Chromatography-Mass Spectrum）

/ ONIOM: 分层算法(Our own N-layered Integrated molecular Orbital and molecular Mechanics）

/ SCRF: 自洽反应场（Self-Consistent Reaction Field）

/ TIC: 总离子浓度（Total Ion Content）

/ $E_a$: 化学反应的活化能（Activation Energy）

/ $Delta G^eq.not$: 活化自由能（Activation Free Energy）

/ $kappa$: 传输系数（Transmission Coefficient）

/ $nu_i$: 虚频（Imaginary Frequency）

#show: style.generic
#show: style.main

#counter(page).update(1)
#counter(heading).update(0)

= 引言

$
  integral_(a)^(b) e^(-x) dif x #<eq:1> \
  integral_(a)^(b) e^(-x/2) dif x \
$

some $"行内" e^(-1/2) + (3/4)/5 quad [a]$, @eq:2

#let florem = figure(
  caption: lorem(2),
  box(
    stroke: black,
    width: 2cm,
    height: 1.5cm,
  ),
)

#let sflorem = cp.figures.with(
  caption: lorem(2),
  columns: 2,
  florem,
  florem,
)

#florem

#sflorem(label: <fg:1>, <fg:1-a>)
#sflorem(<fg:2-b>)

== #(("长",) * 80).join()

= 记日记
<sc:2>

$
  integral_(a)^(b) e^(-x) dif x #<eq:2>
$

some $"inline" [a]$ text @eq:1

some fig @fg:2-b

$
  integral_(a)^(b) e^(-x) dif x \
  integral_(a)^(b) e^(-x) dif x \
$

#sflorem()
#sflorem()

some fig @fg:1 and @fg:1-a

== 节标题

某句话 @zhangkun1994。

Some sentence @carlson1981two[67-69].

@sc:2[]

#figure(
  caption: [Data],
  table(
    columns: 3,
    table.hline(),
    table.header[Orig][Trans][Term],
    table.hline(),
    ..(($1$, $2$, $3$, $4$, $5$, $6$, $7$, $8$, $9$) * 2),
    table.hline(),
  ),
)

=== 条标题

==== 条目一
==== 条目一
===== 条目二
===== 条目二
====== 条目三
====== 条目三

#bibliography("refs.bib")

#show: style.appendix

= 附录说明

$
  y = x #<eq:3>
$
some eq @eq:3

#sflorem(<fg:3>)
some fig in appendix @fg:3

== Lorem

=== Lorem

