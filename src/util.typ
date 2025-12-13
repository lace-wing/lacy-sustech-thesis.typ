/// Utilities.

#let pkg = toml("../typst.toml")

#let pkg-name = pkg.package.name

/// Make "x::y::z"-like namespace strings.
///
/// - n (arguments): Names in `str`.
/// -> str
#let ns(..n) = n.pos().join("::")

/// Force anything to an array.
///
/// - a (any): Variable to convert to array.
/// -> array
#let to-arr(a) = if type(a) == array { a } else { (a,) }

/// Choose between `a` and `default`.
/// Choose `a` if it is not `auto`, otherwise choose `default`.
///
/// - a (any): Maybe `auto`.
/// - default (any): Default value.
/// - ta (arguments): A function applied to `a` if it is chosen. Only the first positional argument considered.
/// -> any
#let default(a, default, ..ta) = if a == auto { default } else {
  let ta = ta.pos().at(0, default: none)
  if ta == none { a } else { ta(a) }
}

#let load-dir(
  dir,
  ..files,
) = {
  files
    .pos()
    .map(file => {
      let ts = file.split(".")
      let name = ts.at(-2)
      let fmt = ts.last()
      // @typstyle off
      let func = (if fmt == "toml" { toml }
        else if fmt in ("yml", "yaml") { yaml }
        else if fmt == "csv" { csv }
        else if fmt == "json" { json }
        else if fmt == "cbor" { cbor }
        else if fmt == "xml" { xml }
        else { panic("Unsupported file format: " + fmt) })
      (name, func(dir + "/" + file))
    })
    .to-dict()
}

/// Spread a line horizontally.
///
/// - width (length, fraction, relative): Width of the spread.
/// - body (content): Content to be spread.
/// -> content
#let spreadl(
  width,
  body,
) = context {
  box(width: calc.max(width.to-absolute(), measure(body).width), {
    body
    linebreak(justify: true)
  })
}

/// Spread string horizontally.
///
/// - width (length, fraction, relative): Width of the spread.
/// - str (str): String to be spread.
/// - dir (direction): Direction of the spread, must be horizontal.
/// -> content
#let spreads(
  width,
  str,
  dir: ltr,
) = box(width: width, stack(
  dir: dir,
  ..str.clusters().intersperse(1fr),
))


/// Spread an array of content-compatibles.
///
/// - length (length, fraction, relative): Length of the spread.
/// - dir (direction): Direction of the spread.
/// - arr (array): Content-compatibles to be spread.
/// -> content
#let spreada(
  length,
  dir,
  arr,
) = box(
  ..(
    if dir in (ltr, rtl) {
      (width: length)
    } else {
      (height: length)
    }
  ),
  stack(
    dir: dir,
    ..arr.intersperse(1fr),
  ),
)


