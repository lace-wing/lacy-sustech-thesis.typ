#import "config.typ": *

#show: generic-style

#cover
#title-zh
#title-en
#reviewers-n-committee
#declarations

#show: pagination-style

#abstract(lang: "zh")[
  #include "abstract-zh.typ"
]

#abstract(lang: "en")[
  #include "abstract-en.typ"
]

#outline

#include "glossary.typ"

#show: body-matter-style

#include "chapter-1.typ"
#include "chapter-2.typ"

#bibliography("refs.bib")

#show: appendix-style

#include "appendix.typ"

#show: attachment-style

#include "acknowledgement.typ"

#include "resume.typ"

