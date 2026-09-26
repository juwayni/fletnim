import std/[unittest, tables]
import flet/[types, control, macros, ffi, session, pubsub, value_types, component, router]

declareControl(Button, Control):
  text: string
  icon: string

type CounterComponent = ref object of Component
  count: int

method build(comp: CounterComponent): Control =
  let btn = newButton()
  btn.text("Count: " & $comp.count)
  return btn

suite "Nim Flet Core SDK & Extensions Tests":

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

    sess.rootControl.addChild(btn)
    sess.registerControl(btn)

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

  test "PubSub Messaging Bus":
    let hub = newPubSubHub()
    var msgReceived = ""

    let cb: PubSubCallback = proc(args: seq[string]) =
      msgReceived = args[0]

    hub.subscribe("sess1", cb)
    hub.sendAll("Hello PubSub")
    check msgReceived == "Hello PubSub"

    hub.free()

  test "Value Types & Layout Primitives":
    let c = rgb(255, 0, 0)
    check c.r == 255
    check c.a == 255

    let p = paddingAll(16.0)
    check p.top == 16.0
    check p.left == 16.0

  test "Reactive Component Lifecycle & State Mutations":
    let comp = CounterComponent(count: 0)
    comp.mount()
    check comp.isMounted
    check comp.children.len == 1

    comp.setState(proc() =
      comp.count = 5
    )
    check comp.count == 5
    check isDirty(comp)

  test "Router Route Matching":
    let r = newRouter()
    r.addRoute("/", proc(params: Table[string, string]): Control =
      let btn = newButton()
      btn.text("Home")
      return btn
    )

    let pageCtrl = r.matchRoute("/")
    check pageCtrl.controlType == "Button"
