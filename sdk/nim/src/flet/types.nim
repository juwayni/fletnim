## Core Types and C-ABI Compatible Primitives for Nim Flet

type
  ControlId* = uint64

  MessageAction* {.pure, size: sizeof(int32).} = enum
    RegisterClient = 1
    PatchControl = 2
    ControlEvent = 3
    UpdateControlProps = 4
    InvokeMethod = 5
    SessionCrashed = 6
    PythonOutput = 7

  # MemoryBuffer is a contiguous byte buffer used for zero-copy binary packaging
  MemoryBuffer* = object
    data*: ptr UncheckedArray[byte]
    capacity*: int
    len*: int

  # FFI Callback signature for Flutter/Dart rendering pipeline
  PatchCallback* = proc (bufPtr: ptr byte, len: int32) {.cdecl.}
  EventCallback* = proc (targetId: uint64, eventName: cstring, payloadPtr: ptr byte, len: int32) {.cdecl.}

proc newMemoryBuffer*(initialCap: int = 1024): MemoryBuffer =
  let p = cast[ptr UncheckedArray[byte]](alloc0(initialCap))
  result = MemoryBuffer(data: p, capacity: initialCap, len: 0)

proc free*(buf: var MemoryBuffer) =
  if buf.data != nil:
    dealloc(buf.data)
    buf.data = nil
    buf.capacity = 0
    buf.len = 0

proc ensureCapacity*(buf: var MemoryBuffer, needed: int) =
  if buf.len + needed > buf.capacity:
    var newCap = if buf.capacity == 0: 1024 else: buf.capacity * 2
    while buf.len + needed > newCap:
      newCap *= 2
    buf.data = cast[ptr UncheckedArray[byte]](realloc(buf.data, newCap))
    buf.capacity = newCap

proc appendByte*(buf: var MemoryBuffer, b: byte) {.inline.} =
  buf.ensureCapacity(1)
  buf.data[buf.len] = b
  inc buf.len

proc appendBytes*(buf: var MemoryBuffer, bytes: openArray[byte]) {.inline.} =
  if bytes.len == 0: return
  buf.ensureCapacity(bytes.len)
  copyMem(addr buf.data[buf.len], unsafeAddr bytes[0], bytes.len)
  buf.len += bytes.len

proc appendString*(buf: var MemoryBuffer, str: string) {.inline.} =
  if str.len > 0:
    buf.ensureCapacity(str.len)
    copyMem(addr buf.data[buf.len], unsafeAddr str[0], str.len)
    buf.len += str.len
