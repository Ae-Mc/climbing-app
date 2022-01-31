import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

enum AppPlatform {
  android,
  desktop,
  ios,
  web,
}

extension AppPlatforms on AppPlatform {
  static AppPlatform get() {
    if (kIsWeb) {
      return AppPlatform.web;
    }
    if (Platform.isAndroid) {
      return AppPlatform.android;
    }
    if (Platform.isIOS) {
      return AppPlatform.ios;
    }
    if (Platform.isLinux | Platform.isMacOS | Platform.isWindows) {
      return AppPlatform.desktop;
    }
    throw UnsupportedError('Unsupported platform: ' + Platform.operatingSystem);
  }
}
