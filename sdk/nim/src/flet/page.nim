## Page, BasePage, and Client Action Engine for Nim Flet SDK

import flet/[control, macros]

declareControl(Page, Control):
  title: string
  route: string
  themeMode: string
  padding: float64
  spacing: float64
  horizontalAlignment: string
  verticalAlignment: string
  windowWidth: float64
  windowHeight: float64
  windowTop: float64
  windowLeft: float64
  windowMaximized: bool
  windowMinimized: bool
  windowResizable: bool
  windowAlwaysOnTop: bool
