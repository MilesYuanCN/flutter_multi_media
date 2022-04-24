import 'dart:async';

import 'package:flutter/services.dart';

class CameraExternalPlugin {
  static const MethodChannel _channel = const MethodChannel('camera_external_plugin');

  int textureId = -1;

  bool get isInitialized => textureId != -1;

  /// 初始化textureId
  Future<int> initialize(int width, int height) async {
    textureId = await _channel.invokeMethod('create', {
      'width': width,
      'height': height,
    });
    return textureId;
  }

  /// dispose
  Future<Null> dispose() => _channel.invokeMethod('dispose', {'textureId': textureId});

}
