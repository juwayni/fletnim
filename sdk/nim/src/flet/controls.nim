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

declareControl(ResponsiveRow, Control):
  columns: int
  spacing: float64

declareControl(SafeArea, Control):
  minimum: float64

declareControl(RotatedBox, Control):
  quarterTurns: int

declareControl(Placeholder, Control):
  fallbackWidth: float64
  fallbackHeight: float64

declareControl(Pagelet, Control):
  title: string

declareControl(Shimmer, Control):
  baseColor: string
  highlightColor: string

declareControl(TransparentPointer, Control):
  transparent: bool

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

declareControl(FilledButton, Control):
  text: string
  icon: string

declareControl(FilledTonalButton, Control):
  text: string
  icon: string

declareControl(TextButton, Control):
  text: string
  icon: string

declareControl(IconButton, Control):
  icon: string
  iconColor: string
  iconSize: float64

declareControl(FloatingActionButton, Control):
  icon: string
  text: string

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

declareControl(RangeSlider, Control):
  startValue: float64
  endValue: float64
  min: float64
  max: float64

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

declareControl(Banner, Control):
  content: string
  open: bool

declareControl(Badge, Control):
  label: string
  small: bool

declareControl(Card, Control):
  elevation: float64
  color: string

declareControl(Chip, Control):
  label: string
  selected: bool

declareControl(CircleAvatar, Control):
  radius: float64
  bgColor: string

declareControl(Divider, Control):
  height: float64
  thickness: float64

declareControl(VerticalDivider, Control):
  width: float64
  thickness: float64

declareControl(ExpansionPanel, Control):
  expanded: bool
  header: string

declareControl(ExpansionTile, Control):
  title: string
  initiallyExpanded: bool

declareControl(Tooltip, Control):
  message: string
  waitDuration: int

declareControl(MenuBar, Control):
  style: string

declareControl(MenuItemButton, Control):
  content: string

declareControl(SubmenuButton, Control):
  content: string

declareControl(NavigationDrawer, Control):
  selectedSchedule: int

declareControl(NavigationRail, Control):
  selectedIndex: int

declareControl(PopupMenuButton, Control):
  icon: string

declareControl(Radio, Control):
  value: string
  label: string

declareControl(RadioGroup, Control):
  value: string

declareControl(SearchBar, Control):
  value: string
  hintText: string

declareControl(SegmentedButton, Control):
  selected: string

declareControl(DataTable, Control):
  border: string

declareControl(DatePicker, Control):
  value: string
  open: bool

declareControl(TimePicker, Control):
  value: string
  open: bool

declareControl(DateRangePicker, Control):
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

declareControl(CupertinoDatePicker, Control):
  value: string

declareControl(CupertinoTimerPicker, Control):
  value: int

declareControl(CupertinoActionSheet, Control):
  title: string
  open: bool

declareControl(CupertinoContextMenu, Control):
  enable: bool

# ── Services & Hardware Sensors ──────────────────────────────────────────────
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

declareControl(Accelerometer, Control):
  interval: int

declareControl(Gyroscope, Control):
  interval: int

declareControl(Magnetometer, Control):
  interval: int

declareControl(HapticFeedback, Control):
  feedbackType: string

declareControl(Battery, Control):
  level: int

declareControl(StoragePaths, Control):
  path: string

declareControl(UrlLauncher, Control):
  url: string

declareControl(Wakelock, Control):
  enabled: bool
