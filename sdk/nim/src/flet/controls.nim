## Complete Macro-Generated Controls Catalog for Nim Flet SDK

import flet/[control, macros]

# ── Core Layout Controls ──────────────────────────────────────────────────────
declareControl(Column, Control):
  spacing: float64
  alignment: string

declareControl(Row, Control):
  spacing: float64
  alignment: string

declareControl(Stack, Control):
  alignment: string

declareControl(Container, Control):
  width: float64
  height: float64
  bgColor: string
  padding: float64
  margin: float64
  borderRadius: float64

declareControl(ListView, Control):
  spacing: float64
  dividerThickness: float64

declareControl(GridView, Control):
  runsCount: int
  maxExtent: float64
  spacing: float64

# ── Material UI Controls ──────────────────────────────────────────────────────
declareControl(Text, Control):
  value: string
  size: float64
  color: string
  weight: string

declareControl(Icon, Control):
  name: string
  size: float64
  color: string

declareControl(Image, Control):
  src: string
  width: float64
  height: float64

declareControl(ElevatedButton, Control):
  text: string
  icon: string

declareControl(OutlinedButton, Control):
  text: string
  icon: string

declareControl(IconButton, Control):
  icon: string
  iconColor: string
  iconSize: float64

declareControl(Checkbox, Control):
  value: bool
  label: string

declareControl(Switch, Control):
  value: bool
  label: string

declareControl(Slider, Control):
  value: float64
  min: float64
  max: float64
  divisions: int

declareControl(ProgressRing, Control):
  value: float64
  strokeWidth: float64

declareControl(ProgressBar, Control):
  value: float64

declareControl(AlertDialog, Control):
  title: string
  content: string
  open: bool

declareControl(SnackBar, Control):
  content: string
  open: bool

declareControl(AppBar, Control):
  title: string
  centerTitle: bool
  bgColor: string

# ── Cupertino Controls ───────────────────────────────────────────────────────
declareControl(CupertinoButton, Control):
  text: string
  color: string

declareControl(CupertinoTextField, Control):
  value: string
  placeholder: string

declareControl(CupertinoSwitch, Control):
  value: bool

declareControl(CupertinoSlider, Control):
  value: float64
  min: float64
  max: float64

# ── Services & Non-Visual Controls ──────────────────────────────────────────
declareControl(FilePicker, Control):
  dialogTitle: string

declareControl(Clipboard, Control):
  value: string

declareControl(SharedPreferences, Control):
  key: string
  value: string

declareControl(Audio, Control):
  src: string
  autoplay: bool
