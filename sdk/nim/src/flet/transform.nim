## Control Transformations & Geometry Engine

type
  Scale* = object
    x*, y*: float64

  Rotate* = object
    angle*: float64

  Offset* = object
    x*, y*: float64

proc scale*(x, y: float64): Scale =
  Scale(x: x, y: y)

proc rotate*(angle: float64): Rotate =
  Rotate(angle: angle)

proc offset*(x, y: float64): Offset =
  Offset(x: x, y: y)
