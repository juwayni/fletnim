import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:io';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';

import 'flet_backend_channel.dart';

typedef PatchCallbackNative = ffi.Void Function(ffi.Pointer<ffi.Uint8> bufPtr, ffi.Int32 len);
typedef RegisterPatchCallbackNative = ffi.Void Function(ffi.Pointer<ffi.NativeFunction<PatchCallbackNative>> cb);
typedef DispatchEventNative = ffi.Void Function(ffi.Uint64 targetId, ffi.Pointer<Utf8> eventName, ffi.Pointer<ffi.Uint8> payloadPtr, ffi.Int32 payloadLen);
typedef PollEventNative = ffi.Uint8 Function(ffi.Pointer<ffi.Uint64> outTargetId, ffi.Pointer<ffi.Pointer<Utf8>> outEventName, ffi.Pointer<ffi.Pointer<Utf8>> outPayload);

typedef RegisterPatchCallbackDart = void Function(ffi.Pointer<ffi.NativeFunction<PatchCallbackNative>> cb);
typedef DispatchEventDart = void Function(int targetId, ffi.Pointer<Utf8> eventName, ffi.Pointer<ffi.Uint8> payloadPtr, int payloadLen);
typedef PollEventDart = int Function(ffi.Pointer<ffi.Uint64> outTargetId, ffi.Pointer<ffi.Pointer<Utf8>> outEventName, ffi.Pointer<ffi.Pointer<Utf8>> outPayload);

class FletFFIBackendChannel implements FletBackendChannel {
  final FletBackendChannelOnDisconnectCallback onDisconnect;
  final FletBackendChannelOnPacketCallback onPacket;

  late ffi.DynamicLibrary _nimLib;
  late RegisterPatchCallbackDart _registerPatchCallbackFn;
  late DispatchEventDart _dispatchEventFn;
  late PollEventDart _pollEventFn;

  ffi.NativeCallable<PatchCallbackNative>? _patchNativeCallable;
  Timer? _pollTimer;

  FletFFIBackendChannel({
    required String address,
    required this.onDisconnect,
    required this.onPacket,
  }) {
    if (Platform.isAndroid || Platform.isLinux) {
      _nimLib = ffi.DynamicLibrary.open("libflet.so");
    } else if (Platform.isMacOS) {
      _nimLib = ffi.DynamicLibrary.open("libflet.dylib");
    } else if (Platform.isWindows) {
      _nimLib = ffi.DynamicLibrary.open("flet.dll");
    } else {
      _nimLib = ffi.DynamicLibrary.process();
    }

    _registerPatchCallbackFn = _nimLib
        .lookup<ffi.NativeFunction<RegisterPatchCallbackNative>>("flet_register_patch_callback")
        .asFunction<RegisterPatchCallbackDart>();

    _dispatchEventFn = _nimLib
        .lookup<ffi.NativeFunction<DispatchEventNative>>("flet_dispatch_event")
        .asFunction<DispatchEventDart>();

    _pollEventFn = _nimLib
        .lookup<ffi.NativeFunction<PollEventNative>>("pollEvent")
        .asFunction<PollEventDart>();
  }

  @override
  Future connect() async {
    // Register synchronous isolateLocal native callback for zero-copy memory safety
    _patchNativeCallable = ffi.NativeCallable<PatchCallbackNative>.isolateLocal((bufPtr, len) {
      if (bufPtr != ffi.nullptr && len > 0) {
        final bytes = bufPtr.asTypedList(len);
        final packet = Uint8List.fromList(bytes);
        onPacket(packet);
      }
    });

    _registerPatchCallbackFn(_patchNativeCallable!.nativeFunction);

    // Start polling timer for Nim events
    _pollTimer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      _pollNimEvents();
    });
  }

  void _pollNimEvents() {
    final targetIdPtr = calloc<ffi.Uint64>();
    final evNamePtr = calloc<ffi.Pointer<Utf8>>();
    final payloadPtr = calloc<ffi.Pointer<Utf8>>();

    try {
      while (_pollEventFn(targetIdPtr, evNamePtr, payloadPtr) != 0) {
        final targetId = targetIdPtr.value;
        final evName = evNamePtr.value != ffi.nullptr ? evNamePtr.value.toDartString() : "";
        final payload = payloadPtr.value != ffi.nullptr ? payloadPtr.value.toDartString() : "";

        final eventBytes = Uint8List.fromList("$targetId:$evName:$payload".codeUnits);
        onPacket(eventBytes);
      }
    } finally {
      calloc.free(targetIdPtr);
      calloc.free(evNamePtr);
      calloc.free(payloadPtr);
    }
  }

  @override
  bool get isLocalConnection => true;

  @override
  int get defaultReconnectIntervalMs => 0;

  @override
  void send(Uint8List packet) {
    if (packet.isEmpty) return;
    final namePtr = "event".toNativeUtf8();
    final payloadMem = calloc<ffi.Uint8>(packet.length);
    final blob = payloadMem.asTypedList(packet.length);
    blob.setAll(0, packet);

    _dispatchEventFn(0, namePtr, payloadMem, packet.length);

    calloc.free(namePtr);
    calloc.free(payloadMem);
  }

  @override
  void disconnect() {
    _pollTimer?.cancel();
    _patchNativeCallable?.close();
    onDisconnect();
  }
}
