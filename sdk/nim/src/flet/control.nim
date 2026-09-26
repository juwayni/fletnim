## Base Control Type and Mutation Tracking Engine

import std/[tables, atomics]
import flet/types

var gLastId: Atomic[uint64]

proc nextControlId*(): ControlId =
  return gLastId.fetchAdd(1u64) + 1u64

type
  EventHandler* = proc (e: string) {.closure.}

  Control* = ref object of RootObj
    id*: ControlId
    controlType*: string
    dirtyFlags*: uint64
    visible*: bool
    disabled*: bool
    expand*: int
    opacity*: float64
    tooltip*: string
    events*: Table[string, EventHandler]
    children*: seq[Control]

method serializeCustomProps*(c: Control, buf: var MemoryBuffer) {.base.} =
  ## Base method for polymorphically writing custom control properties into memory buffer.
  discard

proc initControl*(c: Control, controlType: string) =
  c.id = nextControlId()
  c.controlType = controlType
  c.visible = true
  c.disabled = false
  c.expand = 0
  c.opacity = 1.0
  c.dirtyFlags = 0xFFFF_FFFF_FFFF_FFFFu64
  c.events = initTable[string, EventHandler]()

proc newControl*(controlType: string): Control =
  result = Control()
  initControl(result, controlType)

proc on*(c: Control, eventName: string, handler: EventHandler) =
  c.events[eventName] = handler

proc `onClick=`*(c: Control, handler: EventHandler) =
  c.events["click"] = handler

proc `onChange=`*(c: Control, handler: EventHandler) =
  c.events["change"] = handler

proc `onFocus=`*(c: Control, handler: EventHandler) =
  c.events["focus"] = handler

proc `onBlur=`*(c: Control, handler: EventHandler) =
  c.events["blur"] = handler

proc `onHover=`*(c: Control, handler: EventHandler) =
  c.events["hover"] = handler

proc markDirty*(c: Control, flagIndex: int) {.inline.} =
  c.dirtyFlags = c.dirtyFlags or (1u64 shl flagIndex)

proc clearDirty*(c: Control) {.inline.} =
  c.dirtyFlags = 0

proc isDirty*(c: Control): bool {.inline.} =
  c.dirtyFlags != 0

proc addChild*(parent: Control, child: Control) =
  parent.children.add(child)
  parent.markDirty(0)
