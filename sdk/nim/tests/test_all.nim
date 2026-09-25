import std/unittest
import flet/[types, control, macros, ffi, session]

declareControl(Button, Control):
  text: string
  icon: string

declareControl(TextField, Control):
  value: string
  label: string

suite "Nim Flet Core SDK Tests":

  test "MemoryBuffer allocation and operations":
    var buf = newMemoryBuffer(16)
    check buf.capacity == 16
    check buf.len == 0
    buf.appendByte(byte(0x42))
    check buf.len == 1
    buf.appendString("Hello Nim Flet")
    check buf.len == 15
    free(buf)
    check buf.data == nil

  test "Macro generation and bitmask mutation tracking":
    let btn = newButton()
    check btn.controlType == "Button"
    check btn.id > 0
    check isDirty(btn)

    clearDirty(btn)
    check not isDirty(btn)

    btn.text("Click Me")
    check isDirty(btn)
    check (btn.dirtyFlags and (1u64 shl 1)) != 0

  test "Session, hierarchy tree and binary patch serialization":
    let sess = newSession("sess-123")
    let btn = newButton()
    btn.text("Submit")

    let tf = newTextField()
    tf.value("User Input")

    sess.rootControl.addChild(btn)
    sess.rootControl.addChild(tf)
    sess.registerControl(btn)
    sess.registerControl(tf)

    var receivedBytes: seq[byte] = @[]
    proc onPatch(bufPtr: ptr byte, len: int32) {.cdecl.} =
      receivedBytes.setLen(len)
      if len > 0 and bufPtr != nil:
        copyMem(addr receivedBytes[0], bufPtr, len)

    flet_register_patch_callback(onPatch)
    sess.updateUI()

    check receivedBytes.len > 0
    check receivedBytes[0] == byte(MessageAction.PatchControl)

  test "Dart FFI Event Dispatching Queue":
    flet_dispatch_event(100u64, "click", nil, 0)

    var targetId: uint64
    var evName: cstring
    var payload: cstring

    let polled = pollEvent(addr targetId, addr evName, addr payload)
    check polled
    check targetId == 100u64
