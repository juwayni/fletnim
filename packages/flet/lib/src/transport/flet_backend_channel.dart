import 'dart:typed_data';

import '../utils/platform_utils_web.dart'
    if (dart.library.io) "../utils/platform_utils_non_web.dart";
import 'flet_backend_channel_javascript_web.dart'
    if (dart.library.io) "flet_backend_channel_javascript_io.dart";
import 'flet_backend_channel_mock.dart';
import 'flet_backend_channel_socket.dart';
import 'flet_backend_channel_web_socket.dart';
import 'flet_backend_channel_ffi.dart';

typedef FletBackendChannelOnDisconnectCallback = void Function();

class FletAppStartupException implements Exception {
  final String message;

  const FletAppStartupException(this.message);

  @override
  String toString() => message;
}

typedef FletBackendChannelOnPacketCallback = void Function(Uint8List packet);

typedef FletBackendChannelBuilder = FletBackendChannel Function({
  required FletBackendChannelOnPacketCallback onPacket,
  required FletBackendChannelOnDisconnectCallback onDisconnect,
});

abstract class FletBackendChannel {
  factory FletBackendChannel(
      {required String address,
      required Map<String, dynamic> args,
      required bool forcePyodide,
      bool embedded = false,
      required FletBackendChannelOnDisconnectCallback onDisconnect,
      required FletBackendChannelOnPacketCallback onPacket}) {
    if (address.startsWith("ffi://") || address == "ffi") {
      // Direct Memory Dart FFI Channel to Nim Native Library
      return FletFFIBackendChannel(
          address: address,
          onDisconnect: onDisconnect,
          onPacket: onPacket);
    } else if (isPyodideMode() || forcePyodide) {
      // Pyodide/JavaScript
      return FletJavaScriptBackendChannel(
          address: address,
          args: args,
          onDisconnect: onDisconnect,
          onPacket: onPacket);
    } else if (address.startsWith("http://") ||
        address.startsWith("https://")) {
      // WebSocket
      return FletWebSocketBackendChannel(
          address: address,
          embedded: embedded,
          onDisconnect: onDisconnect,
          onPacket: onPacket);
    } else if (address == "mock") {
      // Mock
      return FletMockBackendChannel(
          address: address, onDisconnect: onDisconnect, onPacket: onPacket);
    } else {
      // TCP or UDS
      return FletSocketBackendChannel(
          address: address, onDisconnect: onDisconnect, onPacket: onPacket);
    }
  }

  Future connect();
  bool get isLocalConnection;
  int get defaultReconnectIntervalMs;

  void send(Uint8List packet);

  void disconnect();
}
