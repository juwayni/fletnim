## Application Entrypoint & Main Lifecycle Runner

import flet/[control, session, ffi]

type
  AppMainHandler* = proc (page: Control) {.closure.}

proc app*(target: AppMainHandler) =
  ## Main entrypoint for running Flet apps in Nim over Dart FFI.
  let sess = newSession("main-session")

  flet_register_event_dispatcher(proc (targetId: uint64, eventName, payload: string) =
    sess.handleControlEvent(targetId, eventName, payload)
    sess.updateUI()
  )

  target(sess.rootControl)
  sess.updateUI()
