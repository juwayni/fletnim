## FFI and Memory Event Loop Bridge for Dart/Flutter Integration

import locks
import flet/types

var gPatchCallback: PatchCallback = nil

type
  EventNode = object
    targetId: uint64
    eventName: string
    payload: string

  EventQueue = object
    lock: Lock
    items: seq[EventNode]

var gEventQueue: EventQueue
initLock(gEventQueue.lock)

proc flet_register_patch_callback*(cb: PatchCallback) {.exportc, cdecl, dynlib.} =
  ## Registers the callback that Dart provides for receiving patch payloads.
  gPatchCallback = cb

proc flet_dispatch_event*(targetId: uint64, eventName: cstring, payloadPtr: ptr byte, payloadLen: int32) {.exportc, cdecl, dynlib.} =
  ## C-ABI exported endpoint called directly by Dart FFI when a UI event occurs.
  var payload = ""
  if payloadPtr != nil and payloadLen > 0:
    payload.setLen(payloadLen)
    copyMem(addr payload[0], payloadPtr, payloadLen)

  let node = EventNode(
    targetId: targetId,
    eventName: if eventName != nil: $eventName else: "",
    payload: payload
  )
  withLock(gEventQueue.lock):
    gEventQueue.items.add(node)

proc emitPatchToDart*(buf: var MemoryBuffer) =
  ## Sends a memory buffer containing UI patches to Dart over the registered callback.
  if gPatchCallback != nil and buf.len > 0:
    gPatchCallback(cast[ptr byte](buf.data), buf.len.int32)

proc pollEvent*(outTargetId: ptr uint64, outEventName: ptr cstring, outPayload: ptr cstring): bool {.exportc, cdecl, dynlib.} =
  ## Non-blocking FFI polling endpoint reserved for outbound client actions.
  return false
