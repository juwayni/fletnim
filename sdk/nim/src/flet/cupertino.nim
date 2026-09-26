## Comprehensive Cupertino Controls Library for Nim Flet SDK with 100% Property Parity

import flet/[control, macros]

declareControl(CupertinoCheckbox, Control):
  label: string
  labelPosition: string
  spacing: float64
  value: bool
  tristate: bool
  autofocus: bool
  checkColor: string
  activeColor: string
  focusColor: string
  fillColor: string
  shape: string
  mouseCursor: string
  semanticsLabel: string
  borderSide: string

declareControl(CupertinoButton, Control):
  text: string
  color: string
  disabledColor: string
  padding: float64
  borderRadius: float64
  minSize: float64
  pressedOpacity: float64
  alignment: string
  autofocus: bool

declareControl(CupertinoFilledButton, Control):
  text: string
  color: string
  disabledColor: string
  padding: float64
  borderRadius: float64
  minSize: float64
  pressedOpacity: float64
  alignment: string
  autofocus: bool

declareControl(CupertinoTintedButton, Control):
  text: string
  color: string
  disabledColor: string
  padding: float64
  borderRadius: float64
  minSize: float64
  pressedOpacity: float64
  alignment: string
  autofocus: bool

declareControl(CupertinoSwitch, Control):
  value: bool
  activeColor: string
  trackColor: string
  thumbColor: string
  focusColor: string
  autofocus: bool
  semanticsLabel: string

declareControl(CupertinoSlider, Control):
  value: float64
  min: float64
  max: float64
  divisions: int
  activeColor: string
  thumbColor: string

declareControl(CupertinoTextField, Control):
  value: string
  placeholder: string
  placeholderStyle: string
  password: bool
  readOnly: bool
  autofocus: bool
  maxLength: int
  maxLines: int
  minLines: int
  prefix: string
  suffix: string
  clearButtonMode: string

declareControl(CupertinoActionSheet, Control):
  title: string
  message: string

declareControl(CupertinoActionSheetAction, Control):
  text: string
  isDefaultAction: bool
  isDestructiveAction: bool

declareControl(CupertinoActivityIndicator, Control):
  radius: float64
  animating: bool
  color: string

declareControl(CupertinoAlertDialog, Control):
  title: string
  content: string

declareControl(CupertinoAppBar, Control):
  middle: string
  backgroundColor: string
  automaticallyImplyLeading: bool
  transitionBetweenRoutes: bool

declareControl(CupertinoBottomSheet, Control):
  modal: bool
  dismissible: bool

declareControl(CupertinoContextMenu, Control):
  enable: bool

declareControl(CupertinoContextMenuAction, Control):
  text: string
  isDefaultAction: bool
  isDestructiveAction: bool
  trailingIcon: string

declareControl(CupertinoDatePicker, Control):
  value: string
  mode: string
  minimumDate: string
  maximumDate: string
  minimumYear: int
  maximumYear: int
  minuteInterval: int
  use24hFormat: bool
  backgroundColor: string

declareControl(CupertinoDialogAction, Control):
  text: string
  isDefaultAction: bool
  isDestructiveAction: bool
  textStyle: string

declareControl(CupertinoListTile, Control):
  title: string
  subtitle: string
  additionalInfo: string
  leading: string
  trailing: string
  bgcolor: string

declareControl(CupertinoNavigationBar, Control):
  middle: string
  backgroundColor: string
  border: string

declareControl(CupertinoPicker, Control):
  itemExtent: float64
  diameterRatio: float64
  offAxisFraction: float64
  useMagnifier: bool
  magnification: float64
  backgroundColor: string

declareControl(CupertinoRadio, Control):
  value: string
  activeColor: string
  fillColor: string
  toggleable: bool
  autofocus: bool

declareControl(CupertinoSegmentedButton, Control):
  selected: string
  selectedColor: string
  unselectedColor: string
  borderColor: string

declareControl(CupertinoSlidingSegmentedButton, Control):
  selected: string
  thumbColor: string
  backgroundColor: string

declareControl(CupertinoTimerPicker, Control):
  value: int
  mode: string
  minuteInterval: int
  secondInterval: int
  alignment: string
  backgroundColor: string
