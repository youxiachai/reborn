import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

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
  @override
  void initState() {
      print('_RebornAppForDesktopState initState');
    windowManager.addListener(this);
    super.initState();
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
  void onWindowFocus() {
    print('onWindowFocus');
    // Make sure to call once.
    setState(() {});
    // do something
  }
}
