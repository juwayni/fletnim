## Hardware Sensors & OS Services Control Library for Nim Flet SDK

import flet/[control, macros]

declareControl(Accelerometer, Control):
  interval: int

declareControl(Barometer, Control):
  interval: int

declareControl(Battery, Control):
  level: int
  charging: bool

declareControl(BrowserContextMenu, Control):
  enabled: bool

declareControl(Clipboard, Control):
  value: string

declareControl(Connectivity, Control):
  status: string

declareControl(FilePicker, Control):
  dialogTitle: string
  initialDirectory: string
  fileType: string
  allowedExtensions: string
  allowMultiple: bool

declareControl(Gyroscope, Control):
  interval: int

declareControl(HapticFeedback, Control):
  feedbackType: string

declareControl(Magnetometer, Control):
  interval: int

declareControl(ScreenBrightness, Control):
  brightness: float64

declareControl(SemanticsService, Control):
  message: string

declareControl(SensorErrorEvent, Control):
  error: string

declareControl(Service, Control):
  name: string

declareControl(ShakeDetector, Control):
  minimumShakeCount: int

declareControl(Share, Control):
  text: string
  subject: string
  title: string

declareControl(SharedPreferences, Control):
  key: string
  value: string

declareControl(StoragePaths, Control):
  appDocumentsDir: string
  temporaryDir: string

declareControl(UrlLauncher, Control):
  url: string
  mode: string

declareControl(UserAccelerometer, Control):
  interval: int

declareControl(Wakelock, Control):
  enabled: bool
