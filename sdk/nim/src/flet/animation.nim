## Animations Engine for Nim Flet SDK

type
  AnimationCurve* {.pure.} = enum
    Linear = "linear"
    EaseIn = "easeIn"
    EaseOut = "easeOut"
    EaseInOut = "easeInOut"

  Animation* = object
    durationMs*: int
    curve*: AnimationCurve

proc animation*(durationMs: int, curve: AnimationCurve = AnimationCurve.Linear): Animation =
  Animation(durationMs: durationMs, curve: curve)
