## Value Types and UI Layout Primitives for Nim Flet

import std/strutils

type
  Color* = object
    r*, g*, b*, a*: uint8

  Alignment* = object
    x*, y*: float64

  Padding* = object
    top*, right*, bottom*, left*: float64

  Margin* = object
    top*, right*, bottom*, left*: float64

  BorderRadius* = object
    topLeft*, topRight*, bottomRight*, bottomLeft*: float64

  Duration* = object
    milliseconds*: int64

proc rgb*(r, g, b: uint8, a: uint8 = 255): Color =
  Color(r: r, g: g, b: b, a: a)

proc parseHexByte(s: string): uint8 =
  result = uint8(fromHex[int](s))

proc hexColor*(hex: string): Color =
  ## Parses "#RRGGBB" or "#AARRGGBB" hex string into Color
  var clean = hex.strip()
  if clean.startsWith("#"):
    clean = clean[1..^1]

  if clean.len == 6:
    return Color(
      r: parseHexByte(clean[0..1]),
      g: parseHexByte(clean[2..3]),
      b: parseHexByte(clean[4..5]),
      a: 255
    )
  elif clean.len == 8:
    return Color(
      a: parseHexByte(clean[0..1]),
      r: parseHexByte(clean[2..3]),
      g: parseHexByte(clean[4..5]),
      b: parseHexByte(clean[6..7])
    )
  return Color(r: 0, g: 0, b: 0, a: 255)

proc align*(x, y: float64): Alignment =
  Alignment(x: x, y: y)

proc paddingAll*(val: float64): Padding =
  Padding(top: val, right: val, bottom: val, left: val)

proc marginAll*(val: float64): Margin =
  Margin(top: val, right: val, bottom: val, left: val)

proc radiusAll*(val: float64): BorderRadius =
  BorderRadius(topLeft: val, topRight: val, bottomRight: val, bottomLeft: val)

proc milliseconds*(ms: int64): Duration =
  Duration(milliseconds: ms)
