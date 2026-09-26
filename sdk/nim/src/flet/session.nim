## Native Session & Page Pipeline Engine

import tables, hashes
import flet/[types, control, protocol, ffi]

type
  Session* = ref object
    sessionId*: string
    rootControl*: Control
    controlRegistry*: Table[ControlId, Control]

proc newSession*(sessionId: string): Session =
  let root = newControl("Page")
  result = Session(
    sessionId: sessionId,
    rootControl: root,
    controlRegistry: initTable[ControlId, Control]()
  )
  result.controlRegistry[root.id] = root

proc registerControl*(s: Session, c: Control) =
  s.controlRegistry[c.id] = c
  for child in c.children:
    s.registerControl(child)

proc handleControlEvent*(s: Session, targetId: ControlId, eventName, payload: string) =
  ## Handles incoming UI events dispatched from Dart/Flutter over FFI.
  if s.controlRegistry.hasKey(targetId):
    let ctrl = s.controlRegistry[targetId]
    # Execute event handlers registered on control
    discard

proc updateUI*(s: Session) =
  ## Scans dirty controls, packs binary patch, emits to Dart FFI, and frees heap buffer.
  var patchBuf = generatePatchBuffer(s.rootControl)
  emitPatchToDart(patchBuf)
  free(patchBuf)
