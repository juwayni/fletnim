## Comprehensive Core UI Controls Library for Nim Flet SDK

import flet/[control, macros]

declareControl(AnimatedSwitcher, Control):
  duration: int
  reverseDuration: int
  switchInCurve: string
  switchOutCurve: string
  transition: string

declareControl(AutofillGroup, Control):
  onDisposeAction: string

declareControl(CoreColumn, Control):
  spacing: float64
  alignment: string
  horizontalAlignment: string
  scroll: string
  autoScroll: bool
  tight: bool
  wrap: bool

declareControl(Dismissible, Control):
  dismissThresholds: string
  dismissDirection: string
  movementDuration: int

declareControl(DragTarget, Control):
  group: string

declareControl(Draggable, Control):
  group: string
  contentFeedback: string

declareControl(FletAppControl, Control):
  url: string

declareControl(GestureDetector, Control):
  mouseCursor: string
  dragStartBehavior: string

declareControl(CoreGridView, Control):
  runsCount: int
  maxExtent: float64
  spacing: float64
  runSpacing: float64
  padding: float64

declareControl(Hero, Control):
  tag: string
  placeholderBuilder: string

declareControl(CoreIcon, Control):
  name: string
  size: float64
  color: string

declareControl(CoreImage, Control):
  src: string
  width: float64
  height: float64
  fit: string
  repeat: string

declareControl(InteractiveViewer, Control):
  maxScale: float64
  minScale: float64
  panEnabled: bool
  scaleEnabled: bool

declareControl(KeyboardListener, Control):
  autofocus: bool

declareControl(CoreListView, Control):
  spacing: float64
  dividerThickness: float64
  padding: float64
  autoScroll: bool
  reverse: bool

declareControl(Markdown, Control):
  value: string
  selectable: bool
  extensionSet: string

declareControl(MergeSemantics, Control):
  enabled: bool

declareControl(PageView, Control):
  initialPage: int
  viewportFraction: float64
  scrollDirection: string

declareControl(CorePagelet, Control):
  title: string
  bgcolor: string

declareControl(CorePlaceholder, Control):
  fallbackWidth: float64
  fallbackHeight: float64
  color: string
  strokeWidth: float64

declareControl(RawImage, Control):
  width: float64
  height: float64
  src: string

declareControl(ReorderableDragHandle, Control):
  index: int

declareControl(CoreResponsiveRow, Control):
  columns: int
  spacing: float64
  runSpacing: float64

declareControl(CoreRotatedBox, Control):
  quarterTurns: int

declareControl(CoreRow, Control):
  spacing: float64
  alignment: string
  verticalAlignment: string
  scroll: string
  autoScroll: bool
  tight: bool
  wrap: bool

declareControl(CoreSafeArea, Control):
  minimum: float64
  top: bool
  bottom: bool
  left: bool
  right: bool

declareControl(Screenshot, Control):
  delay: int

declareControl(Semantics, Control):
  label: string
  value: string
  hint: string
  enabled: bool

declareControl(ShaderMask, Control):
  blendMode: string

declareControl(CoreShimmer, Control):
  baseColor: string
  highlightColor: string
  direction: string

declareControl(CoreStack, Control):
  alignment: string
  fit: string

declareControl(CoreText, Control):
  value: string
  size: float64
  color: string
  weight: string
  fontFamily: string
  italic: bool
  textAlign: string
  overflow: string
  maxLines: int
  selectable: bool

declareControl(TextSpan, Control):
  text: string
  style: string

declareControl(CoreTransparentPointer, Control):
  transparent: bool

declareControl(View, Control):
  route: string
  padding: float64
  spacing: float64

declareControl(Window, Control):
  title: string
  width: float64
  height: float64

declareControl(WindowDragArea, Control):
  enabled: bool
