import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../../main.dart';
import '../app.dart';
import '../settings/settings_controller.dart';

class RebornAppForDesktop extends StatefulWidget {
  final SettingsController settingsController;

  const RebornAppForDesktop({Key? key, required this.settingsController})
      : super(key: key);

  @override
  State<RebornAppForDesktop> createState() => _RebornAppForDesktopState();
}

class _RebornAppForDesktopState extends State<RebornAppForDesktop>
    with WindowListener {
  var _isFirstOnWindowFocus = false;

  @override
  void initState() {
    appLog.info('_RebornAppForDesktopState initState');
    windowManager.addListener(this);
    super.initState();

    initManger.on<WindowShowEvent>().listen((event) {
      appLog.info(
          '_isOnWindowFocus $_isFirstOnWindowFocus initReady ${initManger.isInit}');

      if (!_isFirstOnWindowFocus) {
        setState(() {});
      }
      initManger.initReady();
    });
  }

  @override
  void dispose() {
    appLog.info('_RebornAppForDesktopState dispose');
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appLog.info('_RebornAppForDesktopState build');

    return RebornApp(settingsController: widget.settingsController);
  }

  @override
  void onWindowEvent(String eventName) {
    appLog.info('onWindowEvent $eventName');
    super.onWindowEvent(eventName);
  }

  @override
  void onWindowFocus() {
     appLog.info('onWindowEvent $onWindowFocus');
    _isFirstOnWindowFocus = true;
    // Make sure to call once.
    setState(() {});
    // do something
  }
}
