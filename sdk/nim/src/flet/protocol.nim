## Binary Serialization & Patch Protocol Engine

import flet/[types, control]

proc writeU64*(buf: var MemoryBuffer, val: uint64) =
  var v = val
  for i in 0..<8:
    buf.appendByte(byte(v and 0xFFu64))
    v = v shl 8

proc writeF64*(buf: var MemoryBuffer, val: float64) =
  var bits = cast[uint64](val)
  writeU64(buf, bits)

proc writeStringWithLen*(buf: var MemoryBuffer, str: string) =
  let l = uint32(str.len)
  buf.appendByte(byte(l and 0xFF))
  buf.appendByte(byte((l shr 8) and 0xFF))
  buf.appendByte(byte((l shr 16) and 0xFF))
  buf.appendByte(byte((l shr 24) and 0xFF))
  buf.appendString(str)

proc serializePatchNode*(c: Control, buf: var MemoryBuffer) =
  ## Serializes a single control node's mutated properties into binary buffer.
  buf.writeU64(c.id)
  buf.writeStringWithLen(c.controlType)
  buf.writeU64(c.dirtyFlags)

  # Basic properties
  buf.appendByte(if c.visible: byte(1) else: byte(0))
  buf.appendByte(if c.disabled: byte(1) else: byte(0))

  # Write base properties
  let expVal = int32(c.expand)
  buf.appendByte(byte(expVal and 0xFF))
  buf.appendByte(byte((expVal shr 8) and 0xFF))
  buf.appendByte(byte((expVal shr 16) and 0xFF))
  buf.appendByte(byte((expVal shr 24) and 0xFF))
  buf.writeF64(c.opacity)
  buf.writeStringWithLen(c.tooltip)

  # Custom properties generated via macro
  c.serializeCustomProps(buf)

  # Children count & recursively serialize dirty children
  let childCount = uint32(c.children.len)
  buf.appendByte(byte(childCount and 0xFF))
  buf.appendByte(byte((childCount shr 8) and 0xFF))
  buf.appendByte(byte((childCount shr 16) and 0xFF))
  buf.appendByte(byte((childCount shr 24) and 0xFF))

  for child in c.children:
    serializePatchNode(child, buf)

  c.clearDirty()

proc generatePatchBuffer*(root: Control): MemoryBuffer =
  ## Generates binary patch frame for the entire UI hierarchy rooted at `root`.
  result = newMemoryBuffer(2048)
  # Frame header: Action type (PatchControl = 2)
  result.appendByte(byte(MessageAction.PatchControl))
  serializePatchNode(root, result)
