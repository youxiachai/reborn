import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../../main.dart';
import '../app.dart';
import '../settings/settings_controller.dart';
import 'desktop_init_manager.dart';

class RebornAppForDesktop extends StatefulWidget {
  final SettingsController settingsController;

  const RebornAppForDesktop({Key? key, required this.settingsController})
      : super(key: key);

  @override
  State<RebornAppForDesktop> createState() => _RebornAppForDesktopState();
}

class _RebornAppForDesktopState extends State<RebornAppForDesktop>
    with WindowListener {
  var _isOnWindowFocus = false;

  @override
  void initState() {
    print('_RebornAppForDesktopState initState');
    windowManager.addListener(this);
    super.initState();

    initManger.on<WindowShowEvent>().listen((event) {
      print('_isOnWindowFocus ${_isOnWindowFocus} initReady ${initManger.isInit}');
      if (!_isOnWindowFocus) {
        setState(() {});
      }
      initManger.initReady();
    });
  }

  @override
  void dispose() {
    print('_RebornAppForDesktopState dispose');
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('_RebornAppForDesktopState build');

    return RebornApp(settingsController: widget.settingsController);
  }

  @override
  void onWindowEvent(String eventName) {
    print('onWindowEvent ${eventName}');
    super.onWindowEvent(eventName);
  }

  @override
  void onWindowFocus() {
    print('onWindowFocus ${_isOnWindowFocus}');
    _isOnWindowFocus = true;
    // Make sure to call once.
    setState(() {});
    // do something
  }
}
