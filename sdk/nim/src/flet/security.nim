## Security & Client State Encryption Module

import std/[base64, sysrand]

proc encryptSecret*(data: string, secretKey: string): string =
  ## Simple XOR stream cipher key obfuscation for client state
  var bytes = newSeq[byte](data.len)
  if secretKey.len == 0:
    return encode(data)
  for i in 0..<data.len:
    bytes[i] = byte(ord(data[i]) xor ord(secretKey[i mod secretKey.len]))
  return encode(bytes)

proc decryptSecret*(encodedData: string, secretKey: string): string =
  let decoded = decode(encodedData)
  if secretKey.len == 0:
    return decoded
  var res = newString(decoded.len)
  for i in 0..<decoded.len:
    res[i] = char(byte(ord(decoded[i])) xor byte(ord(secretKey[i mod secretKey.len])))
  return res

proc generateRandomKey*(len: int = 32): string =
  var bytes = newSeq[byte](len)
  if urandom(bytes):
    return encode(bytes)[0..<len]
  return "default_flet_random_secret_key"
