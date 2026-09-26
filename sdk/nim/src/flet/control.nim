## Base Control Type and Mutation Tracking Engine

import std/atomics
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
  c.dirtyFlags = 0xFFFF_FFFF_FFFF_FFFFu64 # Initially all flags set so full state is emitted

proc newControl*(controlType: string): Control =
  result = Control()
  initControl(result, controlType)

proc markDirty*(c: Control, flagIndex: int) {.inline.} =
  c.dirtyFlags = c.dirtyFlags or (1u64 shl flagIndex)

proc clearDirty*(c: Control) {.inline.} =
  c.dirtyFlags = 0

proc isDirty*(c: Control): bool {.inline.} =
  c.dirtyFlags != 0

proc addChild*(parent: Control, child: Control) =
  parent.children.add(child)
  parent.markDirty(0)
