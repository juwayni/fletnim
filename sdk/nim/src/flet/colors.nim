## Material & Cupertino Color Constants Catalog

import std/strutils

const
  RED* = "#FF0000"
  GREEN* = "#00FF00"
  BLUE* = "#0000FF"
  WHITE* = "#FFFFFF"
  BLACK* = "#000000"
  TRANSPARENT* = "#00000000"
  AMBER* = "#FFBF00"
  CYAN* = "#00FFFF"
  GREY* = "#808080"
  INDIGO* = "#4B0082"
  ORANGE* = "#FFA500"
  PINK* = "#FFC0CB"
  PURPLE* = "#800080"
  TEAL* = "#008080"
  YELLOW* = "#FFFF00"
  PRIMARY* = "#6200EE"
  SECONDARY* = "#03DAC6"

proc withOpacity*(hexColor: string, opacity: float64): string =
  ## Applies an opacity value (0.0 to 1.0) to a hex color
  let alphaByte = uint8(opacity * 255.0)
  var clean = hexColor
  if clean.startsWith("#"):
    clean = clean[1..^1]
  if clean.len == 6:
    return "#" & toHex(int(alphaByte), 2) & clean
  elif clean.len == 8:
    return "#" & toHex(int(alphaByte), 2) & clean[2..^1]
  return hexColor
