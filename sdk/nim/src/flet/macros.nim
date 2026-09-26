## Macro Meta-Engine for Generative Control Types and Setters

import std/macros
import flet/[types, control, protocol]

macro declareControl*(typeName: untyped, baseType: untyped, body: untyped): untyped =
  ## Generates type definitions, initialization proc, property assignment setters (`=`), and custom property patch serialization with bitmask tracking.
  let nameStr = $typeName
  let typeNode = newIdentNode(nameStr)
  let baseNode = newIdentNode($baseType)
  let newProcIdent = newIdentNode("new" & nameStr)

  var recList = newNimNode(nnkRecList)
  var setterProcs = newStmtList()
  var customSerializers = newStmtList()

  var fieldIdx = 1 # Bit 0 reserved for structural/children updates

  for node in body:
    if node.kind == nnkCall or node.kind == nnkExprColonExpr:
      let fieldName = node[0]
      let fieldType = node[1]

      let privateFieldName = newIdentNode("f" & $fieldName)
      recList.add(newIdentDefs(postfix(privateFieldName, "*"), fieldType))

      let bitIdx = fieldIdx
      inc fieldIdx

      let fieldNameStr = $fieldName
      let getterIdent = newIdentNode(fieldNameStr)
      let setterIdent = newIdentNode(fieldNameStr & "=")

      # Getter proc
      let getterCode = quote do:
        proc `getterIdent`*(c: `typeNode`): `fieldType` =
          return c.`privateFieldName`
      setterProcs.add(getterCode)

      # Setter proc
      let setterCode = quote do:
        proc `setterIdent`*(c: `typeNode`, val: `fieldType`) =
          c.`privateFieldName` = val
          c.markDirty(`bitIdx`)
      setterProcs.add(setterCode)

      let fieldTypeRepr = repr(fieldType)
      if fieldTypeRepr == "string":
        customSerializers.add(
          quote do:
            if (c.dirtyFlags and (1u64 shl `bitIdx`)) != 0:
              buf.writeStringWithLen(c.`privateFieldName`)
        )
      elif fieldTypeRepr == "int":
        customSerializers.add(
          quote do:
            if (c.dirtyFlags and (1u64 shl `bitIdx`)) != 0:
              let v = int32(c.`privateFieldName`)
              buf.appendByte(byte(v and 0xFF))
              buf.appendByte(byte((v shr 8) and 0xFF))
              buf.appendByte(byte((v shr 16) and 0xFF))
              buf.appendByte(byte((v shr 24) and 0xFF))
        )
      elif fieldTypeRepr == "bool":
        customSerializers.add(
          quote do:
            if (c.dirtyFlags and (1u64 shl `bitIdx`)) != 0:
              buf.appendByte(if c.`privateFieldName`: byte(1) else: byte(0))
        )
      elif fieldTypeRepr == "float64" or fieldTypeRepr == "float":
        customSerializers.add(
          quote do:
            if (c.dirtyFlags and (1u64 shl `bitIdx`)) != 0:
              buf.writeF64(c.`privateFieldName`)
        )

  let typeDef = newNimNode(nnkTypeDef).add(
    postfix(typeNode, "*"),
    newNimNode(nnkEmpty),
    newNimNode(nnkRefTy).add(
      newNimNode(nnkObjectTy).add(
        newNimNode(nnkEmpty),
        newNimNode(nnkOfInherit).add(baseNode),
        recList
      )
    )
  )

  let typeSection = newNimNode(nnkTypeSection).add(typeDef)

  let newProc = quote do:
    proc `newProcIdent`*(): `typeNode` =
      let res = `typeNode`()
      initControl(res, `nameStr`)
      return res

  let serializeMethod = quote do:
    method serializeCustomProps*(c: `typeNode`, buf: var MemoryBuffer) =
      `customSerializers`

  result = newStmtList()
  result.add(typeSection)
  result.add(newProc)
  result.add(setterProcs)
  result.add(serializeMethod)
