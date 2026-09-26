## Reactive Component Engine

import flet/control

type
  Component* = ref object of Control
    isMounted*: bool

method build*(comp: Component): Control {.base.} =
  ## Override this in custom stateful components to return the control tree.
  return newControl("Container")

proc mount*(comp: Component) =
  if not comp.isMounted:
    let body = comp.build()
    comp.addChild(body)
    comp.isMounted = true

proc setState*(comp: Component, updateAction: proc() {.closure.}) =
  ## Mutates state and triggers dirty flag recalculation for re-rendering.
  updateAction()
  if comp.isMounted:
    comp.children.setLen(0)
    let body = comp.build()
    comp.addChild(body)
    comp.markDirty(0)
