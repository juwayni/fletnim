## Comprehensive Canvas Controls & Shapes Engine for Custom Drawing

import flet/[control, macros]

declareControl(Canvas, Control):
  width: float64
  height: float64

declareControl(ShapeLine, Control):
  x1: float64
  y1: float64
  x2: float64
  y2: float64
  strokeWidth: float64
  color: string

declareControl(ShapeCircle, Control):
  x: float64
  y: float64
  radius: float64
  color: string

declareControl(ShapeRect, Control):
  x: float64
  y: float64
  width: float64
  height: float64
  borderRadius: float64
  color: string

declareControl(ShapeOval, Control):
  x: float64
  y: float64
  width: float64
  height: float64
  color: string

declareControl(ShapeArc, Control):
  x: float64
  y: float64
  width: float64
  height: float64
  startAngle: float64
  sweepAngle: float64

declareControl(ShapePath, Control):
  elements: string
  color: string

declareControl(ShapePathMoveTo, Control):
  x: float64
  y: float64

declareControl(ShapePathLineTo, Control):
  x: float64
  y: float64

declareControl(ShapePathQuadraticTo, Control):
  x1: float64
  y1: float64
  x2: float64
  y2: float64

declareControl(ShapePathCubicTo, Control):
  x1: float64
  y1: float64
  x2: float64
  y2: float64
  x3: float64
  y3: float64

declareControl(ShapePathClose, Control):
  close: bool

declareControl(ShapePoints, Control):
  points: string
  color: string

declareControl(ShapeText, Control):
  x: float64
  y: float64
  text: string
  color: string

declareControl(ShapeImage, Control):
  x: float64
  y: float64
  src: string
  width: float64
  height: float64

declareControl(ShapeFill, Control):
  color: string

declareControl(ShapeShadow, Control):
  color: string
  elevation: float64
