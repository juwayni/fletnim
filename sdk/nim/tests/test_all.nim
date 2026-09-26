import std/[unittest, tables]
import flet/[types, control, ffi, session, pubsub, value_types, component, router, controls, canvas, auth, app, utils, testing]

type CounterComponent = ref object of Component
  count: int

method build(comp: CounterComponent): Control =
  let btn = newElevatedButton()
  btn.text = "Count: " & $comp.count
  return btn

suite "Nim Flet Full SDK Test Suite":

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
    let btn = newElevatedButton()
    check btn.controlType == "ElevatedButton"
    check btn.id > 0
    check isDirty(btn)

    clearDirty(btn)
    check not isDirty(btn)

    btn.text = "Click Me"
    check isDirty(btn)
    check (btn.dirtyFlags and (1u64 shl 1)) != 0

  test "Material, Cupertino & Canvas Controls":
    let txt = newText()
    txt.value = "Hello World"
    txt.size = 24.0

    let cv = newCanvas()
    cv.width = 300.0
    cv.height = 200.0

    let line = newShapeLine()
    line.x1 = 0.0
    line.y1 = 0.0
    line.x2 = 100.0
    line.y2 = 100.0

    check txt.value == "Hello World"
    check cv.width == 300.0
    check line.x2 == 100.0

  test "Utilities Slugify, Hashing, Vector Math":
    check slugify("Hello World 123!") == "hello-world-123"
    check fnv1a32("test") > 0u32
    let v1 = vec2(0.0, 0.0)
    let v2 = vec2(3.0, 4.0)
    check distance(v1, v2) == 5.0

  test "Testing Finder Utilities":
    let root = newColumn()
    let btn = newElevatedButton()
    btn.text = "Find Me"
    root.addChild(btn)

    let found = findControlByType(root, "ElevatedButton")
    check found.len == 1
    check found[0].id == btn.id

  test "OAuth Provider Setup":
    let provider = newGitHubOAuthProvider("client-123", "secret-456")
    check provider.clientId == "client-123"

  test "App Runner Entrypoint":
    var appRan = false
    app(proc(page: Control) =
      let btn = newElevatedButton()
      btn.text = "App Started"
      page.addChild(btn)
      appRan = true
    )
    check appRan

  test "Session, hierarchy tree and binary patch serialization":
    let sess = newSession("sess-123")
    let btn = newElevatedButton()
    btn.text = "Submit"

    let col = newColumn()
    col.addChild(btn)

    sess.rootControl.addChild(col)
    sess.registerControl(col)

    var receivedBytes: seq[byte] = @[]
    proc onPatch(bufPtr: ptr byte, len: int32) {.cdecl.} =
      receivedBytes.setLen(len)
      if len > 0 and bufPtr != nil:
        copyMem(addr receivedBytes[0], bufPtr, len)

    flet_register_patch_callback(onPatch)
    sess.updateUI()

    check receivedBytes.len > 0
    check receivedBytes[0] == byte(0x00) # Flet packet frame discriminator
    check receivedBytes[1] == byte(MessageAction.PatchControl)

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

    let hexC = hexColor("#FF0000")
    check hexC.r == 255

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
      let btn = newElevatedButton()
      btn.text = "Home"
      return btn
    )

    let pageCtrl = r.matchRoute("/")
    check pageCtrl.controlType == "ElevatedButton"
