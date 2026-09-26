## Canvas Control & Shapes Engine for Custom Drawing

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

declareControl(ShapeArc, Control):
  x: float64
  y: float64
  width: float64
  height: float64
  startAngle: float64
  sweepAngle: float64
