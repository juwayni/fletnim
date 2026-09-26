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

# Stable C string buffers for FFI boundary return values
var gLastEventNameCStr: string
var gLastPayloadCStr: string

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
  ## Polls the next event from the queue in non-blocking thread-safe fashion.
  var ev: EventNode
  var hasItem = false

  withLock(gEventQueue.lock):
    if gEventQueue.items.len > 0:
      ev = gEventQueue.items[0]
      gEventQueue.items.delete(0)
      hasItem = true

  if not hasItem:
    return false

  if outTargetId != nil:
    outTargetId[] = ev.targetId
  if outEventName != nil:
    gLastEventNameCStr = ev.eventName
    outEventName[] = gLastEventNameCStr.cstring
  if outPayload != nil:
    gLastPayloadCStr = ev.payload
    outPayload[] = gLastPayloadCStr.cstring

  return true
