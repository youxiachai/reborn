import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reborn/src/settings/settings_controller.dart';
import 'package:reborn/src/settings/settings_services.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'src/LocaleLogic.dart';
import 'src/nav2/reborn_nav2.dart';
import 'src/platform/desktop_init_manager.dart';
import 'src/platform/windows_view.dart';
import 'package:logging/logging.dart';

final appLog = Logger('RebornApp');

const double windowWidth = 320;
const double windowHeight = 640;

var initManger = InitManager();

class WindowShowEvent {}

void _setLoggingConfig() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });
}

//限制桌面版本窗口的大小
Future<bool> setupWindow() async {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    // // Must add this line.
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(windowWidth, windowHeight),
      center: true,
      backgroundColor: Colors.transparent,
      minimumSize: Size(windowWidth, windowHeight),
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      appLog.info('waitUntilReadyToShow');
      var isShowBefore = await windowManager.isFocused();
      await windowManager.show();
      var isShowAfter = await windowManager.isFocused();
      await windowManager.focus();
      var isFoucs = await windowManager.isFocused();
      appLog.info(
          'waitUntilReadyToShow isShowBefore ${isShowBefore} ${isShowAfter} ${isFoucs}');
      if (!initManger.isInit) {
        initManger.initEvent(WindowShowEvent());
      }
    });

    return true;
  }
  return false;
}

void main() async {
  _setLoggingConfig();
  WidgetsFlutterBinding.ensureInitialized();
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  var isDesktop = await setupWindow();


  if (isDesktop) {
    runApp(ProviderScope(child: RebornAppForDesktop(settingsController: settingsController)));
  } else {
    runApp(ProviderScope(child: RebornNav2(settingsController: settingsController)));
  }

}
