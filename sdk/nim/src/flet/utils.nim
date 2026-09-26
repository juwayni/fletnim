## Utilities Module for Nim Flet SDK

import std/[strutils, math]

# ── Slugify ───────────────────────────────────────────────────────────────────
proc slugify*(text: string): string =
  result = ""
  for c in text.toLowerAscii():
    if c in {'a'..'z', '0'..'9'}:
      result.add(c)
    elif c in {' ', '_', '-'}:
      if result.len > 0 and result[^1] != '-':
        result.add('-')
  if result.len > 0 and result[^1] == '-':
    result.setLen(result.len - 1)

# ── Hashing ───────────────────────────────────────────────────────────────────
proc fnv1a32*(data: string): uint32 =
  var h: uint32 = 2166136261u32
  for c in data:
    h = h xor uint32(ord(c))
    h = h * 16777619u32
  return h

# ── Platform Detection ────────────────────────────────────────────────────────
proc isAndroid*(): bool =
  defined(android)

proc isDesktop*(): bool =
  defined(linux) or defined(macosx) or defined(windows)

# ── Vector Primitives ─────────────────────────────────────────────────────────
type
  Vector2* = object
    x*, y*: float64

  Vector3* = object
    x*, y*, z*: float64

proc vec2*(x, y: float64): Vector2 =
  Vector2(x: x, y: y)

proc vec3*(x, y, z: float64): Vector3 =
  Vector3(x: x, y: y, z: z)

proc length*(v: Vector2): float64 =
  sqrt(v.x * v.x + v.y * v.y)

proc distance*(v1, v2: Vector2): float64 =
  let dx = v1.x - v2.x
  let dy = v1.y - v2.y
  sqrt(dx * dx + dy * dy)
