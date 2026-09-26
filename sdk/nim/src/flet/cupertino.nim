## Comprehensive Cupertino Controls Library for Nim Flet SDK

import flet/[control, macros]

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

declareControl(CupertinoAlertDialog, Control):
  title: string
  content: string

declareControl(CupertinoAppBar, Control):
  middle: string
  backgroundColor: string

declareControl(CupertinoBottomSheet, Control):
  modal: bool

declareControl(CupertinoButton, Control):
  text: string
  color: string
  disabledColor: string

declareControl(CupertinoFilledButton, Control):
  text: string
  color: string

declareControl(CupertinoTintedButton, Control):
  text: string
  color: string

declareControl(CupertinoCheckbox, Control):
  value: bool
  activeColor: string
  checkColor: string

declareControl(CupertinoContextMenu, Control):
  enable: bool

declareControl(CupertinoContextMenuAction, Control):
  text: string
  isDefaultAction: bool
  isDestructiveAction: bool

declareControl(CupertinoDatePicker, Control):
  value: string
  mode: string
  minimumDate: string
  maximumDate: string

declareControl(CupertinoDialogAction, Control):
  text: string
  isDefaultAction: bool
  isDestructiveAction: bool

declareControl(CupertinoListTile, Control):
  title: string
  subtitle: string
  additionalInfo: string

declareControl(CupertinoNavigationBar, Control):
  middle: string
  backgroundColor: string

declareControl(CupertinoPicker, Control):
  itemExtent: float64
  diameterRatio: float64

declareControl(CupertinoRadio, Control):
  value: string
  activeColor: string

declareControl(CupertinoSegmentedButton, Control):
  selected: string

declareControl(CupertinoSlider, Control):
  value: float64
  min: float64
  max: float64
  divisions: int
  activeColor: string

declareControl(CupertinoSlidingSegmentedButton, Control):
  selected: string

declareControl(CupertinoSwitch, Control):
  value: bool
  activeColor: string
  trackColor: string

declareControl(CupertinoTextField, Control):
  value: string
  placeholder: string
  password: bool

declareControl(CupertinoTimerPicker, Control):
  value: int
  mode: string
