## Material Controls with Full Event Handlers & Properties

import flet/[control, macros]

declareControl(MaterialCheckbox, Control):
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
  onChange: EventHandler
  onFocus: EventHandler
  onBlur: EventHandler

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
  onChange: EventHandler
  onSubmit: EventHandler
  onFocus: EventHandler
  onBlur: EventHandler

declareControl(MaterialElevatedButton, Control):
  text: string
  icon: string
  iconColor: string
  bgcolor: string
  color: string
  elevation: float64
  autofocus: bool
  onClick: EventHandler
  onFocus: EventHandler
  onBlur: EventHandler
  onHover: EventHandler

declareControl(MaterialOutlinedButton, Control):
  text: string
  icon: string
  iconColor: string
  autofocus: bool
  onClick: EventHandler

declareControl(MaterialIconButton, Control):
  icon: string
  iconColor: string
  iconSize: float64
  selectedIcon: string
  selected: bool
  onClick: EventHandler

declareControl(MaterialSwitch, Control):
  value: bool
  label: string
  labelPosition: string
  activeColor: string
  activeTrackColor: string
  inactiveThumbColor: string
  inactiveTrackColor: string
  autofocus: bool
  onChange: EventHandler

declareControl(MaterialSlider, Control):
  value: float64
  min: float64
  max: float64
  divisions: int
  label: string
  activeColor: string
  inactiveColor: string
  thumbColor: string
  onChange: EventHandler

declareControl(MaterialAlertDialog, Control):
  title: string
  content: string
  open: bool
  modal: bool
  onDismiss: EventHandler

declareControl(MaterialCard, Control):
  elevation: float64
  color: string
  margin: float64
  shape: string

declareControl(MaterialDataTable, Control):
  border: string
  showCheckboxColumn: bool
  headingRowHeight: float64
  dataRowHeight: float64
  onSelectAll: EventHandler
