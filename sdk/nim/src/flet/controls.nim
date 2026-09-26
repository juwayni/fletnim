## Complete Macro-Generated Controls Catalog for Nim Flet SDK with Full Property Parity

import flet/[control, macros]

# ── Core Layout Controls ──────────────────────────────────────────────────────
declareControl(Column, Control):
  spacing: float64
  alignment: string
  horizontalAlignment: string
  scroll: string
  autoScroll: bool
  tight: bool
  wrap: bool

declareControl(Row, Control):
  spacing: float64
  alignment: string
  verticalAlignment: string
  scroll: string
  autoScroll: bool
  tight: bool
  wrap: bool

declareControl(Stack, Control):
  alignment: string
  fit: string

declareControl(Container, Control):
  width: float64
  height: float64
  bgColor: string
  padding: float64
  margin: float64
  borderRadius: float64
  border: string
  alignment: string
  clipBehavior: string

declareControl(ListView, Control):
  spacing: float64
  dividerThickness: float64
  padding: float64
  autoScroll: bool
  reverse: bool

declareControl(GridView, Control):
  runsCount: int
  maxExtent: float64
  spacing: float64
  runSpacing: float64
  padding: float64

declareControl(ResponsiveRow, Control):
  columns: int
  spacing: float64
  runSpacing: float64

declareControl(SafeArea, Control):
  minimum: float64
  top: bool
  bottom: bool
  left: bool
  right: bool

declareControl(RotatedBox, Control):
  quarterTurns: int

declareControl(Placeholder, Control):
  fallbackWidth: float64
  fallbackHeight: float64
  color: string
  strokeWidth: float64

declareControl(Pagelet, Control):
  title: string
  bgcolor: string

declareControl(Shimmer, Control):
  baseColor: string
  highlightColor: string
  direction: string

declareControl(TransparentPointer, Control):
  transparent: bool

# ── Material UI Controls ──────────────────────────────────────────────────────
declareControl(Text, Control):
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

declareControl(TextField, Control):
  value: string
  label: string
  hintText: string
  helperText: string
  errorText: string
  password: bool
  canRevealPassword: bool
  readOnly: bool
  autofocus: bool
  multiline: bool
  minLines: int
  maxLines: int
  maxLength: int
  bgcolor: string

declareControl(Icon, Control):
  name: string
  size: float64
  color: string

declareControl(Image, Control):
  src: string
  width: float64
  height: float64
  fit: string
  repeat: string

declareControl(ElevatedButton, Control):
  text: string
  icon: string
  iconColor: string
  bgcolor: string
  color: string
  elevation: float64
  autofocus: bool

declareControl(OutlinedButton, Control):
  text: string
  icon: string
  iconColor: string
  autofocus: bool

declareControl(FilledButton, Control):
  text: string
  icon: string
  iconColor: string
  autofocus: bool

declareControl(FilledTonalButton, Control):
  text: string
  icon: string
  iconColor: string
  autofocus: bool

declareControl(TextButton, Control):
  text: string
  icon: string
  iconColor: string
  autofocus: bool

declareControl(IconButton, Control):
  icon: string
  iconColor: string
  iconSize: float64
  selectedIcon: string
  selected: bool

declareControl(FloatingActionButton, Control):
  icon: string
  text: string
  bgcolor: string
  elevation: float64

declareControl(Checkbox, Control):
  value: bool
  label: string
  labelPosition: string
  tristate: bool
  activeColor: string
  checkColor: string
  fillColor: string
  autofocus: bool

declareControl(Switch, Control):
  value: bool
  label: string
  labelPosition: string
  activeColor: string
  activeTrackColor: string
  inactiveThumbColor: string
  inactiveTrackColor: string
  autofocus: bool

declareControl(Slider, Control):
  value: float64
  min: float64
  max: float64
  divisions: int
  label: string
  activeColor: string
  inactiveColor: string
  thumbColor: string

declareControl(RangeSlider, Control):
  startValue: float64
  endValue: float64
  min: float64
  max: float64
  divisions: int
  activeColor: string
  inactiveColor: string

declareControl(ProgressRing, Control):
  value: float64
  strokeWidth: float64
  color: string
  bgColor: string

declareControl(ProgressBar, Control):
  value: float64
  color: string
  bgColor: string

declareControl(AlertDialog, Control):
  title: string
  content: string
  open: bool
  modal: bool

declareControl(SnackBar, Control):
  content: string
  open: bool
  bgcolor: string
  duration: int

declareControl(Banner, Control):
  content: string
  open: bool
  bgcolor: string

declareControl(Badge, Control):
  label: string
  small: bool
  bgColor: string
  textColor: string

declareControl(Card, Control):
  elevation: float64
  color: string

declareControl(Chip, Control):
  label: string
  selected: bool
  avatar: string
  bgcolor: string

declareControl(CircleAvatar, Control):
  radius: float64
  bgColor: string
  foregroundImageSrc: string

declareControl(Divider, Control):
  height: float64
  thickness: float64
  color: string

declareControl(VerticalDivider, Control):
  width: float64
  thickness: float64
  color: string

declareControl(ExpansionPanel, Control):
  expanded: bool
  header: string
  canTapOnHeader: bool

declareControl(ExpansionTile, Control):
  title: string
  subtitle: string
  initiallyExpanded: bool
  bgcolor: string

declareControl(Tooltip, Control):
  message: string
  waitDuration: int

declareControl(MenuBar, Control):
  style: string

declareControl(MenuItemButton, Control):
  content: string
  closeOnActivate: bool

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
  activeColor: string
  fillColor: string

declareControl(RadioGroup, Control):
  value: string

declareControl(SearchBar, Control):
  value: string
  hintText: string
  barBgColor: string

declareControl(SegmentedButton, Control):
  selected: string
  allowMultipleSelection: bool

declareControl(DataTable, Control):
  border: string
  showCheckboxColumn: bool

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
  elevation: float64

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
  volume: float64

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
