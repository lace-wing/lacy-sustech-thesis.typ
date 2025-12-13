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


