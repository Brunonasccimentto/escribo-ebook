import 'package:flutter/services.dart';

class SystemInfoService {
  static const MethodChannel _channel = MethodChannel('my_channel');

  Future<String?> getAndroidVersion() async {
    try {
      final String version = await _channel.invokeMethod('getAndroidVersion');
      return version;

    } on PlatformException {
      // print("Failed to get Android version: ${e.message}");
      return null;
    }
  }

}