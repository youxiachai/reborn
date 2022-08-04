import 'package:flutter/material.dart';

import 'settings_services.dart';

class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  final SettingsService _settingsService;

  late ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();

    //ChangeNotifier 关键代码通知UI更新
    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    if (newThemeMode == _themeMode) return;

    notifyListeners();

    //持久化当前设置
    await _settingsService.updateThemeMode(newThemeMode);
  }
}
