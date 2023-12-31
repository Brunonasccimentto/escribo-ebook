import 'dart:io';

import 'package:escribo_ebook/services/system_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class SystemInfoViewModel extends ChangeNotifier {
  final SystemInfoService _systemInfoService = SystemInfoService();

  Future<void> fetchAndroidVersion(Future<void> downloadBook) async {
    final String? version = await _systemInfoService.getAndroidVersion();

    if (version != null) {
      String? firstPart;

      if (version.toString().contains(".")) {
        int indexOfFirstDot = version.indexOf(".");
        firstPart = version.substring(0, indexOfFirstDot);

      } else {
        firstPart = version;
      }

      int intValue = int.parse(firstPart);

      if (intValue >= 13) {
        await downloadBook;

      } else {
        final PermissionStatus status = await Permission.storage.request();

        if (status == PermissionStatus.granted) {
          await downloadBook;
        } else {
          await Permission.storage.request();
        }
      }
    }
  }

  downloadBookManager(Future<void> downloadBook) async {
    if (Platform.isIOS) {
      final PermissionStatus status = await Permission.storage.request();

      if (status == PermissionStatus.granted) {
        await downloadBook;

      } else {
        await Permission.storage.request();
      }

    } else if (Platform.isAndroid) {
      await fetchAndroidVersion(downloadBook);
    } else {
      PlatformException(code: '500');
    }
  }
  
}