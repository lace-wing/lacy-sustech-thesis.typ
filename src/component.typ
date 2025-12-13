/// Document components

#import "util.typ": *

#let cs = state(ns(pkg-name, "config"), (:))

#let loc = load-dir("./loc", "zh.toml", "en.toml")

#let config(
  langs: ("zh", "en"),
  title: none,
  subtitle: none,
  candidate: none,
  supervisor: none,
  department: none,
  degree: none,
  professional: false,
  discipline: none, // Academic
  category: none, // Professional
  institute: auto,
  print-date: none,
  defence-date: none,
  ..args,
) = {
  cs.update(c => {
    let langs = to-arr(langs)
    let title = to-arr(title)
    let subtitle = to-arr(subtitle)
    let candidate = to-arr(candidate)
    let supervisor = to-arr(supervisor)
    let department = to-arr(department)
    let degree = to-arr(degree)
    let discipline = to-arr(discipline)
    let category = to-arr(category)
    let institute = default(institute, langs.map(l => loc.at(l).sustech), to-arr)
    c += (
      langs: langs,
      title: title,
      subtitle: subtitle,
      candidate: candidate,
      supervisor: supervisor,
      department: department,
      degree: degree,
      professional: professional,
      discipline: discipline,
      category: category,
      institute: institute,
      print-date: print-date,
      defence-date: defence-date,
      ..args.named(),
    )
    c
  })
}

#let cover() = {}

