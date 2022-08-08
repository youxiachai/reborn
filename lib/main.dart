import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reborn/src/settings/settings_controller.dart';
import 'package:reborn/src/settings/settings_services.dart';
import 'package:window_manager/window_manager.dart';

import 'src/app.dart';
import 'src/platform/windows_view.dart';

const double windowWidth = 320;
const double windowHeight = 640;

//限制桌面版本窗口的大小
Future<bool> setupWindow() async {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    // // Must add this line.
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(windowWidth, windowHeight),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      print('waitUntilReadyToShow');
      await windowManager.show();
      await windowManager.focus();
    });

    return true;
  }
  return false;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  var isDesktop = await setupWindow();

  if (isDesktop) {
    runApp(RebornAppForDesktop(settingsController: settingsController));
  } else {
    runApp(RebornApp(settingsController: settingsController));
  }
}
