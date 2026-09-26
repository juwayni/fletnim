## Theme & Styling System for Nim Flet SDK

type
  ThemeMode* {.pure.} = enum
    System = "system"
    Light = "light"
    Dark = "dark"

  ColorScheme* = object
    primary*: string
    secondary*: string
    surface*: string
    background*: string
    error*: string

  TextTheme* = object
    bodyMediumSize*: float64
    titleLargeSize*: float64

  Theme* = object
    colorScheme*: ColorScheme
    textTheme*: TextTheme
    useMaterial3*: bool

proc newTheme*(useMaterial3: bool = true): Theme =
  Theme(
    colorScheme: ColorScheme(
      primary: "#6200EE",
      secondary: "#03DAC6",
      surface: "#FFFFFF",
      background: "#FFFFFF",
      error: "#B00020"
    ),
    textTheme: TextTheme(
      bodyMediumSize: 14.0,
      titleLargeSize: 22.0
    ),
    useMaterial3: useMaterial3
  )
