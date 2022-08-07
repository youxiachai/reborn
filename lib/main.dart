import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reborn/src/settings/settings_controller.dart';
import 'package:reborn/src/settings/settings_services.dart';
import 'package:window_size/window_size.dart';

import 'src/app.dart';

const double windowWidth = 640;
const double windowHeight = 1280;

//限制桌面版本窗口的大小
void setupWindow()  {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
   
    setWindowTitle('Reborn');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupWindow();
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(RebornApp(settingsController: settingsController));
}
