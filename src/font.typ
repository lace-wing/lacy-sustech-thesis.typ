// factory {{{
#let get-csort-name(i, lang: "zh") = {
  let hi = i / 2
  let s = calc.floor(hi)
  let small = s < hi

  if lang == "zh" {
    let prefix = if small { "小" } else { none }
    let postfix = if small { none } else { "号" }
    if s == 0 {
      return prefix + "初" + postfix
    } else {
      return prefix + numbering("一", s) + postfix
    }
  }
  if lang == "en" {
    let prefix = if small { "s" } else { "S" }
    return prefix + str(s)
  }
}

#let csort-names-zh = range(0, 16).map(get-csort-name)

#let csort-names-en = range(0, 16).map(get-csort-name.with(lang: "en"))

#let csort-sizes = (
  42pt,
  36pt,
  26pt,
  24pt,
  22pt,
  18pt,
  16pt,
  15pt,
  14pt,
  13pt,
  12pt,
  10.5pt,
  9pt,
  7.5pt,
  6.5pt,
  5.5pt,
  5pt,
)
// }}}

/// Chinese sort name-size pairs.
#let csort = csort-names-en.zip(csort-sizes).to-dict()

/// 汉字字号，名称对大小。
#let 字号 = csort-names-zh.zip(csort-sizes).to-dict()

/// Font groups.
#let group = (
  song: (
    (name: "Times New Roman", covers: "latin-in-cjk"),
    "Source Han Serif SC",
    "Source Han Serif",
    "Noto Serif CJK SC",
    "SimSun",
    "Songti SC", // Windows
    "STSongti", // Darwin
  ),
  hei: (
    (name: "Arial", covers: "latin-in-cjk"),
    "Source Han Sans SC",
    "Source Han Sans",
    "Noto Sans CJK SC",
    "SimHei",
    "Heiti SC", // Windows
    "STHeiti", // Darwin
  ),
  kai: (
    (name: "Times New Roman", covers: "latin-in-cjk"),
    "KaiTi",
    "Kaiti SC",
    "STKaiti",
    "FZKai-Z03S",
  ),
  fsong: (
    (name: "Times New Roman", covers: "latin-in-cjk"),
    "FangSong",
    "FangSong SC",
    "STFangSong",
    "FZFangSong-Z02S",
  ),
  mono: (
    (name: "Courier New", covers: "latin-in-cjk"),
    (name: "Menlo", covers: "latin-in-cjk"),
    (name: "IBM Plex Mono", covers: "latin-in-cjk"),
    "Source Han Sans HW SC",
    "Source Han Sans HW",
    "Noto Sans Mono CJK SC",
    "SimHei",
    "Heiti SC", // Windows
    "STHeiti", // Darwin
  ),
)

/// 字体组。
#let 字体 = (
  宋体: group.song,
  黑体: group.hei,
  楷体: group.kai,
  仿宋: group.fsong,
  等宽: group.mono,
)

