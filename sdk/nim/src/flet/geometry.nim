## Border, Blur, BoxDecoration, Gradients, and Geometry Module

type
  BorderSide* = object
    width*: float64
    color*: string

  Border* = object
    top*, right*, bottom*, left*: BorderSide

  Blur* = object
    sigmaX*, sigmaY*: float64

  BoxShadow* = object
    color*: string
    blurRadius*: float64
    spreadRadius*: float64
    offsetX*, offsetY*: float64

  LinearGradient* = object
    colors*: seq[string]
    beginX*, beginY*: float64
    endX*, endY*: float64

  BoxDecoration* = object
    bgColor*: string
    border*: Border
    blur*: Blur
    shadow*: BoxShadow
    gradient*: LinearGradient

proc borderAll*(width: float64, color: string): Border =
  let side = BorderSide(width: width, color: color)
  Border(top: side, right: side, bottom: side, left: side)

proc blur*(sigmaX, sigmaY: float64): Blur =
  Blur(sigmaX: sigmaX, sigmaY: sigmaY)

proc shadow*(color: string, blurRadius: float64): BoxShadow =
  BoxShadow(color: color, blurRadius: blurRadius, spreadRadius: 0.0, offsetX: 0.0, offsetY: 0.0)
