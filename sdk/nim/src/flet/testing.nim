## Testing Harness and Control Finder Utilities

import flet/[types, control, session]

type
  Tester* = ref object
    session*: Session

proc newTester*(sess: Session): Tester =
  Tester(session: sess)

proc findControlByType*(root: Control, controlType: string): seq[Control] =
  result = @[]
  if root.controlType == controlType:
    result.add(root)
  for child in root.children:
    let sub = findControlByType(child, controlType)
    for c in sub:
      result.add(c)

proc findControlById*(root: Control, targetId: ControlId): Control =
  if root.id == targetId:
    return root
  for child in root.children:
    let res = findControlById(child, targetId)
    if res != nil:
      return res
  return nil
