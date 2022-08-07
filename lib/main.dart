import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reborn/src/settings/settings_controller.dart';
import 'package:reborn/src/settings/settings_services.dart';
import 'package:window_manager/window_manager.dart';
import 'package:window_size/window_size.dart';

import 'src/app.dart';

const double windowWidth = 320;
const double windowHeight = 640;

//限制桌面版本窗口的大小
Future<void> setupWindow() async {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();

    // Must add this line.
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = WindowOptions(
      size: Size(windowWidth, windowHeight),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });

    // var window = await getWindowInfo();

    // setWindowFrame(Rect.fromCenter(
    //   center: window.screen!.frame.center,
    //   width: windowWidth,
    //   height: windowHeight,
    // ));

    // setWindowMinSize(const Size(windowWidth, windowHeight));
    // setWindowMaxSize(const Size(windowWidth, windowHeight));
    // setWindowTitle('Reborn');

    // getCurrentScreen().then((screen) {
    //   setWindowFrame(Rect.fromCenter(
    //     center: screen!.frame.center,
    //     width: windowWidth,
    //     height: windowHeight,
    //   ));
    // });
  }
}

void main() async {
  await setupWindow();

  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(RebornApp(settingsController: settingsController));


}
