import 'package:flutter/material.dart';
import 'package:reborn/src/settings/settings_controller.dart';
import 'package:reborn/src/settings/settings_services.dart';

import 'src/app.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(RebornApp(settingsController: settingsController));
}
