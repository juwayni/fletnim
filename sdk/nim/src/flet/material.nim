## Comprehensive Material Design Controls Library for Nim Flet SDK

import flet/[control, macros]

declareControl(MaterialAlertDialog, Control):
  title: string
  content: string
  open: bool
  modal: bool
  backgroundColor: string
  elevation: float64
  shape: string
  insetPadding: float64
  clipBehavior: string

declareControl(MaterialAppBar, Control):
  title: string
  centerTitle: bool
  bgColor: string
  color: string
  elevation: float64
  automaticallyImplyLeading: bool
  toolbarHeight: float64
  leadingWidth: float64

declareControl(MaterialAutoComplete, Control):
  suggestions: string

declareControl(MaterialBadge, Control):
  label: string
  small: bool
  bgColor: string
  textColor: string
  alignment: string

declareControl(MaterialBanner, Control):
  content: string
  open: bool
  bgColor: string
  leading: string

declareControl(MaterialBottomAppBar, Control):
  bgColor: string
  elevation: float64
  height: float64

declareControl(MaterialBottomSheet, Control):
  open: bool
  modal: bool
  bgColor: string
  elevation: float64

declareControl(MaterialCard, Control):
  elevation: float64
  color: string
  margin: float64
  shape: string

declareControl(MaterialCheckbox, Control):
  value: bool
  label: string
  labelPosition: string
  tristate: bool
  activeColor: string
  checkColor: string
  fillColor: string
  autofocus: bool

declareControl(MaterialChip, Control):
  label: string
  selected: bool
  avatar: string
  bgcolor: string
  elevation: float64

declareControl(MaterialCircleAvatar, Control):
  radius: float64
  bgColor: string
  foregroundImageSrc: string

declareControl(MaterialContainer, Control):
  width: float64
  height: float64
  bgColor: string
  padding: float64
  margin: float64
  borderRadius: float64
  border: string
  alignment: string
  clipBehavior: string

declareControl(MaterialContextMenu, Control):
  enable: bool

declareControl(MaterialDataTable, Control):
  border: string
  showCheckboxColumn: bool
  headingRowHeight: float64
  dataRowHeight: float64

declareControl(MaterialDatePicker, Control):
  value: string
  open: bool
  firstDate: string
  lastDate: string

declareControl(MaterialDateRangePicker, Control):
  open: bool
  firstDate: string
  lastDate: string

declareControl(MaterialDivider, Control):
  height: float64
  thickness: float64
  color: string

declareControl(MaterialDropdown, Control):
  value: string
  label: string
  hintText: string
  bgcolor: string
  autofocus: bool

declareControl(MaterialExpansionPanel, Control):
  expanded: bool
  header: string
  canTapOnHeader: bool

declareControl(MaterialExpansionTile, Control):
  title: string
  subtitle: string
  initiallyExpanded: bool
  bgcolor: string

declareControl(MaterialFilledButton, Control):
  text: string
  icon: string
  iconColor: string
  autofocus: bool

declareControl(MaterialFilledTonalButton, Control):
  text: string
  icon: string
  iconColor: string
  autofocus: bool

declareControl(MaterialFloatingActionButton, Control):
  icon: string
  text: string
  bgcolor: string
  elevation: float64

declareControl(MaterialIconButton, Control):
  icon: string
  iconColor: string
  iconSize: float64
  selectedIcon: string
  selected: bool

declareControl(MaterialListTile, Control):
  title: string
  subtitle: string
  leading: string
  trailing: string
  bgcolor: string

declareControl(MaterialMenuBar, Control):
  style: string

declareControl(MaterialMenuItemButton, Control):
  content: string
  closeOnActivate: bool

declareControl(MaterialNavigationBar, Control):
  selectedIndex: int
  bgColor: string
  elevation: float64

declareControl(MaterialNavigationDrawer, Control):
  selectedSchedule: int

declareControl(MaterialNavigationRail, Control):
  selectedIndex: int

declareControl(MaterialOutlinedButton, Control):
  text: string
  icon: string
  iconColor: string
  autofocus: bool

declareControl(MaterialPopupMenuButton, Control):
  icon: string
  tooltip: string

declareControl(MaterialProgressBar, Control):
  value: float64
  color: string
  bgColor: string

declareControl(MaterialProgressRing, Control):
  value: float64
  strokeWidth: float64
  color: string
  bgColor: string

declareControl(MaterialRadio, Control):
  value: string
  label: string
  activeColor: string
  fillColor: string

declareControl(MaterialRadioGroup, Control):
  value: string

declareControl(MaterialRangeSlider, Control):
  startValue: float64
  endValue: float64
  min: float64
  max: float64
  divisions: int
  activeColor: string
  inactiveColor: string

declareControl(MaterialReorderableListView, Control):
  padding: float64

declareControl(MaterialSearchBar, Control):
  value: string
  hintText: string
  barBgColor: string

declareControl(MaterialSegmentedButton, Control):
  selected: string
  allowMultipleSelection: bool

declareControl(MaterialSelectionArea, Control):
  enable: bool

declareControl(MaterialSlider, Control):
  value: float64
  min: float64
  max: float64
  divisions: int
  label: string
  activeColor: string
  inactiveColor: string
  thumbColor: string

declareControl(MaterialSnackBar, Control):
  content: string
  open: bool
  bgcolor: string
  duration: int

declareControl(MaterialSubmenuButton, Control):
  content: string

declareControl(MaterialSwitch, Control):
  value: bool
  label: string
  labelPosition: string
  activeColor: string
  activeTrackColor: string
  inactiveThumbColor: string
  inactiveTrackColor: string
  autofocus: bool

declareControl(MaterialTabs, Control):
  selectedLength: int

declareControl(MaterialTextButton, Control):
  text: string
  icon: string
  iconColor: string
  autofocus: bool

declareControl(MaterialTextField, Control):
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

declareControl(MaterialTimePicker, Control):
  value: string
  open: bool

declareControl(MaterialTooltip, Control):
  message: string
  waitDuration: int

declareControl(MaterialVerticalDivider, Control):
  width: float64
  thickness: float64
  color: string
