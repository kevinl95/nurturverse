import "dart:async";

import "package:flutter/services.dart";

class BoincBridge {
  BoincBridge({
    MethodChannel? methodChannel,
    EventChannel? eventChannel,
  })  : _methodChannel = methodChannel ?? const MethodChannel("nurturverse/boinc"),
        _eventChannel = eventChannel ?? const EventChannel("nurturverse/boinc_events");

  final MethodChannel _methodChannel;
  final EventChannel _eventChannel;

  Future<bool> start() async {
    try {
      final result = await _methodChannel.invokeMethod<bool>("start");
      return result ?? false;
    } on MissingPluginException {
      return true;
    }
  }

  Future<bool> stop() async {
    try {
      final result = await _methodChannel.invokeMethod<bool>("stop");
      return result ?? true;
    } on MissingPluginException {
      return true;
    }
  }

  Future<bool> isRunning() async {
    try {
      final result = await _methodChannel.invokeMethod<bool>("isRunning");
      return result ?? false;
    } on MissingPluginException {
      return false;
    }
  }

  Stream<int> minutesStream() {
    return _eventChannel.receiveBroadcastStream().map((event) {
      if (event is int) return event;
      if (event is double) return event.toInt();
      return 0;
    });
  }
}
