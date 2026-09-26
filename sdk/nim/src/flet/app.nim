## Application Entrypoint & Main Lifecycle Runner

import flet/[control, session]

type
  AppMainHandler* = proc (page: Control) {.closure.}

proc app*(target: AppMainHandler) =
  ## Main entrypoint for running Flet apps in Nim over Dart FFI.
  let sess = newSession("main-session")
  target(sess.rootControl)
  sess.updateUI()
